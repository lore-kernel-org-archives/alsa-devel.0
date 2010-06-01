From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC PATCH 0/5] OMAP/ASoC: McBSP: FIFO handling
	related fixes
Date: Tue, 1 Jun 2010 10:09:14 +0300
Message-ID: <20100601100914.d03781a7.jhnikula@gmail.com>
References: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id D597E103968
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 09:06:52 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 5so357325eyb.16
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 00:06:52 -0700 (PDT)
In-Reply-To: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com, linux-oamp@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, 31 May 2010 11:03:21 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

Looks good move forward with the notes by you and others. Few questions
below.

> This means, that the size of the FIFO
> depends on the McBSP word size configuration.
> For example on McBSP3:
> 16bit samples: size is 128 * 2 = 256 bytes
> 32bit samples: size is 128 * 4 = 512 bytes
> It is simpler to place constraint for buffer and period based on channels.
> McBSP3 as example again (16 or 32 bit samples):
> 1 channel (mono): size is 128 frames (128 words)
> 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
> 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
> 
So McBSP FIFO holds always samples independently of number of channels
or sample size? That makes sense why I see DMA pointer advancing at 512
frame steps when max_tx_thres is 1024 (aplay -f dat /dev/zero).

> The series changes how the users of McBSP are configuring the FIFO:
> It used to be 0 based (0 meant 1 word threshold). After this series users can
> configure the threshold in 1 base mode (1 means 1 word threshold).
> The platform code now provides the _full_ size of the FIFO in words, instead of
> the already limited value used in the past.
> 
Definitely good. It's much more easier to remember and define real
threshold size than some -1 what's ends up to threshold register
value :-)

Btw, I don't remember what was the reason why maximum threshold value
must be -0x10 from FIFO size?


-- 
Jarkko
