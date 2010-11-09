From: Mohammad Bahathir Hashim <bahathir@gmail.com>
Subject: Re: HDMI on HDA device=3
Date: Tue, 9 Nov 2010 17:04:12 +0000 (UTC)
Message-ID: <ibbuuc$4ar$1@dough.gmane.org>
References: <4CD95DD9.2070102@canonical.com> <ibbsj9$o50$1@dough.gmane.org>
	<alpine.LNX.2.00.1011091739060.29422@eeebox2.perex-int.cz>
Reply-To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F566103871
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 18:04:34 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PFrcP-00045B-Ni
	for alsa-devel@alsa-project.org; Tue, 09 Nov 2010 18:04:25 +0100
Received: from 118.101.18.113 ([118.101.18.113])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 18:04:25 +0100
Received: from bahathir by 118.101.18.113 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 18:04:25 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-11-09, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 9 Nov 2010, Mohammad Bahathir Hashim wrote:
>
>> On 2010-11-09, David Henningsson <david.henningsson@canonical.com> wrote:
>>> I have seen a few HDMIs which share the HDA controller with the onboard
>>> sound card, but the codecs are different, e g the onboard one is at
>>> address #0 and the HDMI is at address #3 - or even #3, #7, #8 and #9 in
>>> some cases.
>>>
>>> Now, if the user specifies the device string hdmi:x (where x is card
>>> name/number), I'd like it to kind of autodetect this and use DEV=3
>>> instead of DEV=0, and without breaking the cards where the hdmi is a
>>> separate card with a codec at address #0. However, it still seems like
>>> the device is at DEV=3 somehow.
>>>
>>> Now, looking at /usr/share/alsa/cards/HDA-Intel.conf, I notice that
>>> there are entries HDA-Intel.pcm.hdmi.0 which sets DEV=3, so it seems
>>> like someone already thought of this. However, just using "hdmi:x" does
>>> not trigger "DEV=3". I'm still not grepping all of the alsa lisp
>>> architecture stuff, so could someone explain to me how the
>>> HDA-Intel.pcm.hdmi.0 entry relates to the "hdmi:x" alsa device string?
>>>
>>
>> I am not sure about Intel HDMI, but, in my case with MacbookPro 6,2
>> (15" Mid 2010); the HDMI audio stream via NVIDIA HDMI can only be
>> started if I use hw:1,7 (or Mplayer's -ao alsa:device=hw=1.7). No
>
> This should be equal to '-ao alsa:device=hdmi=1.1' (hdmi:1,1 in ALSA 
> naming).
>
>  						Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.


Ok, I tried the -ao alsa:device=hdmi=1.7 ... but, MPlayer complains;

[AO_ALSA] alsa-lib: confmisc.c:1286:(snd_func_refer) Unable to find
definition
'cards.HDA-Intel.pcm.hdmi.7:CARD=1,AES0=4,AES1=130,AES2=0,AES3=2'
[AO_ALSA] alsa-lib: conf.c:4154:(_snd_config_evaluate) function
snd_func_refer returned error: No such file or directory [AO_ALSA]
alsa-lib: conf.c:4633:(snd_config_expand) Evaluate error: No such file
or directory
[AO_ALSA] alsa-lib: pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM
hdmi:1,7 [AO_ALSA] Playback open error: No such file or directory
Failed to initialize audio driver 'alsa:device=hdmi=1.7' Could not
open/initialize audio device -> no sound.


In other words, in current default alsa configuration, 'hdmi' keyword
is only for Intel HDMI HDA. But, for MacbookPro6,2 , I need to use
NVIDIA HDMI. That's why (-ao alsa:device=hw=1.7) is much better
option; for more generic purposes.  :)

Thank you.
