From: Colomban Wendling <lists.ban@herbesfolles.org>
Subject: Re: Realtek ALC889: HDA Intel and kernel 3.1 gives
 choppy sound (again)
Date: Tue, 22 Nov 2011 19:13:48 +0100
Message-ID: <4ECBE65C.9060507@herbesfolles.org>
References: <4EB85F94.2060908@herbesfolles.org> <s5hobwnm8dj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.herbesfolles.org (a4nancy.globenet.org [80.67.172.114])
	by alsa0.perex.cz (Postfix) with ESMTP id A0CA4103807
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 19:13:49 +0100 (CET)
In-Reply-To: <s5hobwnm8dj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le 08/11/2011 07:32, Takashi Iwai a =E9crit :
> At Mon, 07 Nov 2011 23:45:40 +0100,
> Colomban Wendling wrote:
>>
>> Hi,
>>
>> Back to 3.0, the sound on my soundcard [1] started to be choppy, I
>> reported it [2] and it got fixed (thanks to Takashi Iwai!).
>>
>> However, the story repeated with 3.1 (and probably 3.0.8 or before [3]):
>> I've got similar choppy sound again.
>>
>> I bisected the few commits that happened on
>> sound/pci/hda/patch_realtek.c, and finally found the villain:
>>
>> "8974bd51 ALSA: hda/realtek - Fix auto-mute with HP+LO configuration"
>>
>> Reverting it from v3.1 fixes the problem.
> =

> Does it?  Very weird.  This patch has nothing to do with the HD-audio
> controller side but purely a codec change.
> =

>> master (94956ee) also suffers of the problem, but I couldn't test
>> without that commit because reverting it fails, too much changes happene=
d.
> =

> Did you try to pass position_fix=3D1 (or 2) option?
> Also, passing enable_msi=3D0 (or 1) may change anything?
> =

> In anyway, please give alsa-info.sh output again with the fresh
> kernel.  Run it with --no-upload option and attach the output.

My answer was moderated because it was huge (including the alsa-info
outputs), but I guess you got it?  Any news on the subject?

Regards,
Colomban
