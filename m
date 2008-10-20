From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Audio on Linux is a mess
Date: Mon, 20 Oct 2008 16:12:23 +0100
Message-ID: <gdi74o$t1v$1@ger.gmane.org>
References: <f188924b0810170624k78e74116o19fba5adb0eaf533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 542F724567
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 17:12:56 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KrwQt-0004Wg-Aa
	for alsa-devel@alsa-project.org; Mon, 20 Oct 2008 15:12:35 +0000
Received: from 81.174.147.218 ([81.174.147.218])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 15:12:35 +0000
Received: from gmane by 81.174.147.218 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 15:12:35 +0000
In-Reply-To: <f188924b0810170624k78e74116o19fba5adb0eaf533@mail.gmail.com>
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

Fred . wrote:
> ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect: Timeout
> ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect: Timeout
> AL lib: alsa.c:344: Could not open playback device 'default': Connection refused
> AL lib: oss.c:179: Could not open /dev/dsp: Device or resource busy
>   File "/var/lib/python-support/python2.5/pyglet/media/drivers/openal/__init__.py",
> line 340, in driver_init_device = alc.alcOpenDevice(device_name)

1. Pulseaudio issue (or rather the distro who configured pusleaudio 
issue, rather than pulseaudio directly - looks like you have some kind 
of networking issue where or a mismatch in pulseaudio libs but that 
beside the point).

> Audio on Linux is a mess.
> I launch an Python script that uses audio then it breaks, and when the
> Python script is closed, I still hear the audio skipping and repeating
> like,
> "kakakakakakaka" in infinite loop.
> And PulseAudio seems to be frozen.
> Then I kill PulseAudio and finally the audio noise stops.
> 
> Oh, and I heard OpenAL downsamples stereo to mono on Linux due to a bug.

2. OpenAL issue.

> Whole audio on Linux is just a big mess.

Well complaining to the ALSA list when the two things you actually 
complain about is not actually anything to do with alsa is not the right 
way to help fix that "mess".

If you wish to be constructive rather than just random flaming them I'm 
sure people will be happy to help.

I will happily take the time to explain to you why I think the future is 
quite bright for sound on linux (I agree that some degree of mess exists 
just now).

At the moment tho', you have a problem speaking to pulseaudio. You 
should debug that first. If you cannot work it out yourself, ask on 
#pulseaudio or on the pulseaudio mailing lists.

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
