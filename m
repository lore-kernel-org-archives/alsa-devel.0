From: VDR User <user.vdr@gmail.com>
Subject: xine AC3 dropout problem - Please help!
Date: Fri, 27 Aug 2010 09:24:19 -0700
Message-ID: <AANLkTim_nj3t6FUY1Qnd=3AXkajELkAGzswOHN3ox3xE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1766024658
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 18:24:20 +0200 (CEST)
Received: by pzk5 with SMTP id 5so1403660pzk.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 09:24:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.  Xine seems to have a problem with ac3 audio dropping out
frequently, which ruins the ability to watch hdtv for example.  I have
made a sample which exhibits this problem, which plays just fine in
mplayer so I assume that means root causes such as a buggy system
scheduler can be ruled out.  The sample also plays fine on my main
Windows desktop as well.  Adjusting things such as
engine.buffers.audio_num_buffers in xine's config has no affect.  It
has been suggested that the problem may be xine not properly handling
a stream error.

If anyone can and is willing to take a look at this and hopefully
resolve the problem once and for all, that would be great.  The sample
is 20MB so it can't be attached to this post.  Until I can find a
better place to host the sample, I've temporarily uploaded it to:
http://rapidshare.com/files/415479559/xine_ac3_dropout_bug.tar.bz2

System details are:

debian testing
stable kernel 2.6.35.3 (quiet notsc clocksource=hpet)
gcc 4.4.4-8
alsa-base 1.0.23+dfsg-1
alsa-utils 1.0.23-2
xine-lib-1.2 hg r11577
xine-ui hg r3054
VDR-1.7.15
mplayer-nogui 2:1.0~rc3++svn20100804-0.0

I recently tried the notsc and clocksource=hpet kernel options, which
also had no affect.  I want to reiterate that the dropout problem only
occurs in xine.  The error I see in the xine log when the dropout
occurs is: pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed
(-32).

Best regards,
Derek
