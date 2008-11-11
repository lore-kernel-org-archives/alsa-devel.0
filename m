From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [Intel-gfx] G45 user experience
Date: Tue, 11 Nov 2008 15:23:23 +0800
Message-ID: <1226388208.23944.20765@de>
References: <20081107173215.GA4272@csy.ca>
	<1226109130.31821.1.camel@aiko.keithp.com>
	<20081108061035.GA6041@csy.ca> <4918EEC8.1060907@linux.intel.com>
	<20081111041500.GA15161@csy.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmsmga102.fm.intel.com (mga10.intel.com [192.55.52.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 96A6D2452B
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 08:23:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081111041500.GA15161@csy.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shane W <shane-freevo@csy.ca>
Cc: "Ma, Ling" <ling.ma@intel.com>, Fu Michael <michael_fu@linux.intel.com>, intel-gfx@lists.freedesktop.org, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 08:15:01PM -0800, Shane W wrote:
> On Tue, Nov 11, 2008 at 10:32:40AM +0800, Fu Michael wrote:
> > Do you have any HDMI sink device that can support 5.1 or 7.1 audio?  I'm  
> > looking for those kind of devices as well...
> 
> I'm not really sure what you mean by HDMI sink but my
> receiver which connects to the G45 does support 5.1 and 7.1
> HDMI decoding along with TRUEHD, DTSHD and DSD so I can
> certainly test anything that comes down the pipe as far as
> patches go.

Wow, thank you very much!

> By the way, had a bit more time to test out these HDMI sync
> xorg patches.  Under mplayer, after playing audio for about
> 10 or so minutes with a video stream, the audio starts to
> drop out and then stops altogether.  Stopping and starting

Do you mean the volume goes down gradually?

> mplayer doesn't fix it, stopping mplayer and playing a wav
> via aplay gives silence.  Stopping Xorg does correct it and
> once Xorg is restarted, it'll run with video for another 10
> or so minutes and stop again.  This is using Saturday's GIT

OK, then restarting Xorg fixed it temporarily.
I wonder if restarting the monitor restores the sound as well?

> on ALSA, Xorg and Intel with the IALSA Intel hdmi patch,
> and the HDMI patches for Xorg and the Intel driver applied.


Thank you,
Fengguang
