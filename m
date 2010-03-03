From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 4/5] OMAP3: McBSP: Add interface for FIFO caused delay
 query
Date: Wed, 3 Mar 2010 16:38:15 +0200
Message-ID: <20100303163815.34c7ecbe.jhnikula@gmail.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267621689-30337-6-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1267621689-30337-6-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, ext-eero.nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

On Wed,  3 Mar 2010 15:08:08 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> New functions for querying the FIFO caused delay on both
> TX and RX path.
> On TX path the return value shows the number of used
> locations in the FIFO.
> On RX papth it returns the number of locations to be filled
> to reach the threshold value (DMA will be triggered to read
> the data out from the FIFO).
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
