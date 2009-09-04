From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: a11y: howto reduce latency with alsa's dmix plugin?
Date: Fri, 04 Sep 2009 11:09:17 +0200
Message-ID: <87skf3oz42.fsf@freenet.de>
References: <20090823095517.GA27741@halim> <s5hws4k2f1k.wl%tiwai@suse.de>
	<87fxb7j6pw.fsf@freenet.de> <s5hy6ozt0cd.wl%tiwai@suse.de>
	<87ab1dg1xq.fsf@freenet.de> <s5hd467k7gk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id AD4A71038D8
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 11:09:58 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MjUne-0002mf-Vd
	for alsa-devel@alsa-project.org; Fri, 04 Sep 2009 11:09:42 +0200
Received: from pd9e3fe58.dip.t-dialin.net ([217.227.254.88])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 11:09:42 +0200
Received: from halim.sahin by pd9e3fe58.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 04 Sep 2009 11:09:42 +0200
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

On Fr, Sep 04 2009, Takashi Iwai wrote:

> At Wed, 02 Sep 2009 10:56:17 +0200,
> Halim Sahin wrote:
>> 
>> On Di, Sep 01 2009, Takashi Iwai wrote:
>> 
>> > At best, we need a small C code that reproduces the behavior.
>> Ok here is a small example.
>> It's a modified version of pcm_min.c.
>> Simply press ctrl+c to reproduce the problematic behaviour.
>> on my machine it takes about an half sek to stop with an usb head which
>> uses dmix.
>
> Hmm, I cannot reproduce the problem, at least, dmix + HD-audio.
> After removing sleep(1), it quits immediately.

Yes you can't, because the program doesn't run.
The sleep shouldn't be removed to see the problem.
When speech-dispatcher is running and someone tries to stop the output,
the programm doesn't exit.
Think about it like a pause key :-).

The sblive stopps emmidiately with inserted sleep the usb headset
doesn't.


> Doesn't this problem happen if you use usb-audio with "hw" PCM?

The pcm_min example of alsalib doesn't run this way.
--8<---------------cut here---------------start------------->8---

ALSA lib pcm.c:7125:(snd_pcm_set_params) Sample format not available for
PLAYBAC
K: Invalid argument
Playback open error: Invalid argument
--8<---------------cut here---------------end--------------->8---

Can you tell me which sampleformat works with this device???

> It's possible that the behavior of snd_pcm_drop() of usb-audio is
> different from others because of URB handling.

The stop problem also happends on my laptop with hd audio and ad1981
chip.

with kind regards
Halim
