From: Pavel Roskin <proski@gnu.org>
Subject: Re: EeePC 1005PE microphone is "stereo only",
 silent in mono
Date: Wed, 03 Aug 2011 11:29:30 -0400
Message-ID: <4E39695A.9080202@gnu.org>
References: <20110731233945.1frwedfvso8c8kck-cebfxv@webmail.spamcop.net>
	<s5hwrex5xd4.wl%tiwai@suse.de>
	<20110801131229.d0smwpen9cw0wg8k-cebfxv@webmail.spamcop.net>
	<s5hk4aws0r0.wl%tiwai@suse.de> <4E384D7A.2020206@gnu.org>
	<s5h1ux3sjlp.wl%tiwai@suse.de> <4E385AD2.7060904@gnu.org>
	<s5hty9zqace.wl%tiwai@suse.de>
	<1312361761.4004.14.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c60.cesmail.net (c60.cesmail.net [216.154.195.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D8B51037F3
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 17:29:35 +0200 (CEST)
In-Reply-To: <1312361761.4004.14.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/03/2011 04:56 AM, Paul Menzel wrote:
> Am Mittwoch, den 03.08.2011, 08:26 +0200 schrieb Takashi Iwai:
>
> [=85]
>
>> From: Takashi Iwai<tiwai@suse.de>
>> Subject: [PATCH] ALSA: hda - Fix digital-mic mono recording on ASUS eeePC

Tested-by: Pavel Roskin <proski@gnu.org>

>> stereo PCM, thus you can't record a mono stream from the stereo stream as
>> is; the summing the stereo signal results in almost zero level, and you'=
ll
>
> Should =BBthe summing=AB be =BBin summary=AB?
>
>> hear only noise.

Actually, I was hearing almost complete silence.  I was able to hear a =

very faint voice if I would scream at the microphone while recording. =

But I cannot vouch for that and I'm not in the environment to reproduce =

that test :)

The noise is a different thing.  I would get it from the microphone =

without "model=3Dauto" on the current sound-2.6/master, but not on 3.0. =

Perhaps some other initialization was tied to "model=3Dauto".  But this =

patch appears to remove the need to use that parameter.

>> As a workaround, use ALC269-specific COEF to manipulate the dmic route
>> for mono, like used for ALC271x.  Since this is implemented as a fix-up
>> and the auto-parser works fine for eeePC, the patch drops the model
>> quirk entries for them, too.
>
> So as a consequence everyone using `model=3Dauto` can drop that from
> `/etc/modprobe.d/`?

Yes.  Disclaimer: I only tried it once, and I rebooted after having =

"model=3Dauto".

> I do not know how high the regression chance might be, but if there is
> any, maybe split the patch and write all models in the commit summary
>
>          ALSA: hda - Use auto parser for ASUS UX50, Eeepc P901, Eeepc S10=
1 and P1005HA

You are not following the naming scheme you are suggesting :)

By the way, the full name of my laptop as written on the underside is =

ASUS Eee 1005PEB.  I assume "B" is for "brown".  dmidecode gives 1005PE =

for the system and 1005P for the base board.

The CPU is Intel Atom N450.  I looked for 1005HA online, and they are =

said to have N270.

I assume 1005HA and 1005PE are different models.  Of course, the sound =

chip may be the same.

-- =

Regards,
Pavel Roskin
