From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: WM8731 using I2S on omap3 McBSP2 issues
Date: Mon, 28 Sep 2009 08:50:32 +0300
Message-ID: <20090928085032.74074fb4.jhnikula@gmail.com>
References: <E1MrZge-0002DY-0A@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id BC51F2433E
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 07:50:20 +0200 (CEST)
Received: by ewy25 with SMTP id 25so4196498ewy.45
	for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2009 22:50:19 -0700 (PDT)
In-Reply-To: <E1MrZge-0002DY-0A@amazonia.comcast.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rick Bronson <rick@efn.org>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 26 Sep 2009 08:59:52 -0700
Rick Bronson <rick@efn.org> wrote:

>   Yes, I had tried 8 before and just tried it now.  Same result.  It
> really seems like there is a DMA issue.  Can you think of anything
> else to try before I dive into the DMA code?
> 
Ok, that wasn't the reason.

Have you tried to reverse roles of codec and omap? I.e. by using
the codec as a master and omap as a slave with SND_SOC_DAIFMT_CBM_CFM.

I don't think there is any HW reason as you have seen the bit-clock and
frame sync signals toggling but I remember one case few years back
where codec had slight too high capacitive load on the bit-clock line.
That was then causing unstable frame sync as it was internally derived
directly from the bit-clock pin without any buffer. Bit-clock signal
looked just fine on oscilloscope but wasn't well enough for internal
circuits of the cpu.

So if assuming similar problem here, I could imagine that if the FSX is
used similar way directly inside the omap and if signal is not well
enough, the McBSP and DMA may not be running.

This migh be a bit far reason to look for but at least easy to try by
switching the roles as then the codec is driving the both bit-clock and
fs.


-- 
Jarkko
