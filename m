From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Tue, 27 Oct 2009 16:00:00 +0200
Message-ID: <20091027160000.f276e706.jhnikula@gmail.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<1256641643.30157.339.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1256641643.30157.339.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Oct 2009 13:07:23 +0200
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> Otherwise, that spinlocking is highly unnecessary and things are
> far better without than with it. The only case it could be useful
> is in SMPs, but OMAPs are not such quite yet - and when they
> are, things will need to be re-though anyway.
> 
Following commit is suggesting that mcbsp code *must* be SMP safe
already now:

commit a5b92cc348299c20be215b9f4b50853ecfbf3864
Author: Syed Rafiuddin <rafiuddin.syed@ti.com>
Date:   Tue Jul 28 18:57:10 2009 +0530

    ARM: OMAP4: Add McBSP support


-- 
Jarkko
