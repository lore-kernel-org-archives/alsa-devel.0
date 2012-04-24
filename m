From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback underrun recovery
Date: Tue, 24 Apr 2012 16:04:51 +0200
Message-ID: <4F96B303.2090008@ladisch.de>
References: <FB1A4815959E42EF9F7B4F3A48E8E129@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 94E72243B5
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 16:00:59 +0200 (CEST)
In-Reply-To: <FB1A4815959E42EF9F7B4F3A48E8E129@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Paul D. DeRocco wrote:
> I've got a synth program outputting directly to the main hw PCM device, with
> no intervening plugins. It uses about 75-80% of the time on one core, so it
> normally doesn't underrun. Once in a while, other burdens on the system
> trigger an underrun, and my program never recovers. My buffer contains two
> periods of 256 stereo frames (with 32-bit samples), which at 96KHz comes out
> to a little over 5.3ms total. When it fails, its CPU usage goes up to 100%
> on that core, and it spits out bursts of 5.3ms of audio (two full periods,
> not one), with about 4ms of silence between them.

When a PCM device is (re)started, the buffer is initially empty, so you
need more CPU to fill it.

What is your start threshold?

> My top level code consists of a loop that generates one period at a time:
>
>     while (true) {
>         generate_samples(buf, 256); // generate 256 stereo frames
>         if (snd_pcm_writei(h, buf, 256) < 0)
>             snd_pcm_prepare(h);
>     }

Is this the actual code?  You should check if snd_pcm_writei() returns
that less than 256 frames have been written, and you should use
snd_pcm_recover(), and you should that one's return value, too.


Regards,
Clemens
