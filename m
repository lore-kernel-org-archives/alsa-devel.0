From: =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
Subject: Re: [PATCH] RME HDSPM MADI lock fix
Date: Tue, 07 Jun 2011 10:33:55 +0200
Message-ID: <4DEDE273.9060200@stackingdwarves.net>
References: <4DEB5325.9070903@stackingdwarves.net>
	<s5hk4cz1gae.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000400060800000800050205"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.stackingdwarves.net (vm-evil.stackingdwarves.net
	[78.47.233.26]) by alsa0.perex.cz (Postfix) with ESMTP id E670E24383
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:27:24 +0200 (CEST)
In-Reply-To: <s5hk4cz1gae.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000400060800000800050205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 06/06/2011 11:05 AM, Takashi Iwai wrote:
> At Sun, 05 Jun 2011 11:57:57 +0200,
> J=C3=B6rn Nettingsmeier wrote:
>>
>> hi *!
>>
>> while we were trying to debug the midi-related xruns in the current
>> driver, i came across what looks like an unrelated locking bug to me:
>>
>> static int snd_hdspm_midi_input_read (struct hdspm_midi *hmidi)
>> ...
>>           spin_lock_irqsave (&hmidi->lock, flags);<---------------
>>           n_pending =3D snd_hdspm_midi_input_available (hmidi->hdspm,
>> hmidi->id);
>> ...
>>           hmidi->pending =3D 0;
>>
>>           hmidi->hdspm->control_register |=3D hmidi->ie;<------- !!!
>>           hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
>>                       hmidi->hdspm->control_register);
>>
>>           spin_unlock_irqrestore (&hmidi->lock, flags);<---------
>>           return snd_hdspm_midi_output_write (hmidi);
>> }
>>
>>
>> if i understand this whole business correctly, we should be holding th=
e
>> hdspm lock here, not the hmidi one.
>>
>> please review the attached patch and apply if you think it's ok.
>
> Well, it's a wrong lock for snd_hdspm_midi_input_available().
> So you'll need to lock twice, either once unlock and lock another or
> nested.  Re-locking would be less messy in this case, I suppose.

ok, here's a revised patch. has been running for 20 or so hours without=20
problems, although the load was light most of the time.

please consider for inclusion.


best,


j=C3=B6rn



--=20
J=C3=B6rn Nettingsmeier
Lortzingstr. 11, 45128 Essen, Tel. +49 177 7937487

Meister f=C3=BCr Veranstaltungstechnik (B=C3=BChne/Studio)
Tonmeister (VDT)

http://stackingdwarves.net

--------------000400060800000800050205
Content-Type: text/x-patch;
 name="hdspm-lock-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdspm-lock-fix.diff"

--- linux-2.6.39/sound/pci/rme9652/hdspm.c.orig	2011-05-19 06:06:34.000000000 +0200
+++ linux-2.6.39/sound/pci/rme9652/hdspm.c	2011-06-07 10:26:35.778933230 +0200
@@ -1639,12 +1639,14 @@
 		}
 	}
 	hmidi->pending = 0;
+	spin_unlock_irqrestore (&hmidi->lock, flags);
 
+	spin_lock_irqsave (&hmidi->hdspm->lock, flags);
 	hmidi->hdspm->control_register |= hmidi->ie;
 	hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
 		    hmidi->hdspm->control_register);
+	spin_unlock_irqrestore (&hmidi->hdspm->lock, flags);
 
-	spin_unlock_irqrestore (&hmidi->lock, flags);
 	return snd_hdspm_midi_output_write (hmidi);
 }
 

--------------000400060800000800050205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000400060800000800050205--
