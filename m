From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Problems with Chromebook Pixel 2015 audio
Date: Mon, 18 Sep 2017 10:02:13 +0300
Message-ID: <1505718133.25945.262.camel@linux.intel.com>
References: <20170913145548.GC25597@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170913145548.GC25597@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

+Cc: Pierre, Liam

(Tom: I'm not an audio guy)

On Wed, 2017-09-13 at 10:55 -0400, Tom Rini wrote:
> Hey folks,
> 
> Entirely unrelated to the regression on this board that we dealt with
> the other week, I have (and have had for a bit), a problem with audio
> on
> this laptop.  After a while of use, I'll have a problem like this:
> 
> Sep 12 20:59:30 oliver kernel: haswell-pcm-audio haswell-pcm-audio: FW
> loaded, mailbox readback FW info: type 01, - version: 00.00, build 77,
> source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> (everything is fine, audio works, is in use)
> Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
> error: audio DSP boot timeout IPCD 0x0 IPCX 0x0
> Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
> ipc:
> --message timeout-- ipcx 0x83000000 isr 0x00000000 ipcd 0x00000000
> imrx
> 0x7fff0000
> Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
> error: stream commit failed
> Sep 12 21:24:04 oliver kernel:  System PCM: error: failed to commit
> stream -110
> Sep 12 21:24:04 oliver kernel: haswell-pcm-audio haswell-pcm-audio:
> ASoC: haswell-pcm-audio hw params failed: -110
> Sep 12 21:24:04 oliver kernel:  System PCM: ASoC: hw_params FE failed
> -110
> 
> With those last 4 messages repeating constantly (~3 sets per second,
> and
> the above are from v4.13, but I've had similar for as long as the
> driver
> has been mainline I think) and it only stops when I reboot.  Rebooting
> may or may not clear the problem, last night I had to power off to get
> audio to come back up.  I'm not quite sure where to begin debugging
> this
> issue.  Does anyone have any suggestions?  Thanks!
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
