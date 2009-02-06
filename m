From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] enable concurrent digital outputs for
	ALC1200
Date: Fri, 6 Feb 2009 16:30:35 +0800
Message-ID: <20090206083035.GA28267@localhost>
References: <49538A00.3070009@gmx.net> <20081226024838.GA13302@localhost>
	<4954CE2A.2040309@gmx.net> <20081230095414.GA1206@localhost>
	<495FEA39.1000404@gmx.net> <20090206070227.GA17793@localhost>
	<s5hiqno7yzb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E120A244BC
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 09:31:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hiqno7yzb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Thomas Schneider <nailstudio@gmx.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2009 at 10:26:16AM +0200, Takashi Iwai wrote:
> At Fri, 6 Feb 2009 15:02:27 +0800,
> Wu Fengguang wrote:
> > 
> > Add the SPDIF pin as slave digital out to enable concurrent
> > HDMI/SPDIF outputs for ASUS M3A-H/HDMI with ALC1200 codec.
> > 
> > Tested-by: Thomas Schneider <nailstudio@gmx.net>
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> 
> BTW, Thomas, could you give the output of alsa-info.sh
> (with --no-upload option)?  The script is found at
> 	http://www.alsa-project.org/alsa-info.sh

He once uploaded one here:
        http://www.alsa-project.org/db/?f=8282910dc807e1f141896886cd5f8fd574117000

Thanks,
Fengguang
