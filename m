From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: [Ekiga-devel-list] Pls don't require exclusive
 Alsa audio device access, use snd_pcm_dmix_open ()
Date: Wed, 28 Nov 2007 19:16:07 +0100
Message-ID: <474DB067.1050008@googlemail.com>
References: <471FE2A7.9080309@googlemail.com>	<47201223.5050304@googlemail.com>	<474D2F8A.9090001@googlemail.com>	<Pine.LNX.4.61.0711281014180.8244@tm8103.perex-int.cz>	<fijjso$aeg$1@ger.gmane.org>	<474D90EB.5030400@googlemail.com>
	<s5hir3mgx1m.wl%tiwai@suse.de>
Reply-To: thomas.schorpp@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 7482A24AE1
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 19:16:12 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1317610nfd
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 10:16:11 -0800 (PST)
In-Reply-To: <s5hir3mgx1m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ekiga development mailing list <ekiga-devel-list@gnome.org>, alsa-devel@alsa-project.org
Cc: michel@twinklephone.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 28 Nov 2007 17:01:47 +0100,
> thomas schorpp wrote:
>>> +1 Dmix should not be enforced... this can be handled at a lower
>>> level.... e.g. with dmix configured in alsa config or by using
>>> pulseaudio instead of dmix (my preferred solution so I can switch from
>>> my internal speakers to my usb headset should I plug it in mid-call).
>>>
>>> Col.
>> alsa docs say dmix config files are no longer neccessary?
> 
> The behavior depends on the name string passed to snd_pcm_open().
> If you open the PCM with "default", the alsa-lib takes an approriate
> configuration for multi-playback and automatic conversions.  But, if
> app opens with other strings like "hw" or "plughw", then it means
> that it's an exclusive access.  dmix cannot be involved with that.
> 
> 
> Takashi
> 

thx guys. using the "default" device in ekiga audio device config solved it :)

skype     5218   skype  mem    CHR 116,24       8292 /dev/snd/pcmC0D0c
skype     5218   skype  mem    CHR 116,16       8284 /dev/snd/pcmC0D0p
iceape-bi 5277 schorpp    0r   CHR    1,3       1107 /dev/null
ekiga     5411 schorpp  mem    CHR 116,16       8284 /dev/snd/pcmC0D0p
ekiga     5411 schorpp  mem    CHR 116,24       8292 /dev/snd/pcmC0D0c
ekiga     5411 schorpp    0r   CHR    1,3       1107 /dev/null
ekiga     5411 schorpp   63r   CHR 116,33       7972 /dev/snd/timer
ekiga     5411 schorpp   64u   CHR 116,24       8292 /dev/snd/pcmC0D0c
ekiga     5411 schorpp   67r   CHR 116,33       7972 /dev/snd/timer
ekiga     5411 schorpp   68u   CHR 116,16       8284 /dev/snd/pcmC0D0p

many thx, Takashi. ALSA rocks!

BTW:

http://www.xs4all.nl/~mfnboer/twinkle/manual.html#sys_audio

"NOTE:The ALSA default device should only be used for the ring tone and/or speaker. It is not recommended to use the ALSA default device for the microphone as it gives poor quality."

this is not the case. fine here.

http://www.xs4all.nl/~mfnboer/twinkle/faq.html#alsa_no_sound

"There can be many reasons why you do not get sound. With ALSA, a common problem is the lack of a proper /etc/asound.conf file. Here is a copy of my asound.conf."

twinkle guys should update their docs.

y
tom
