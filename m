From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [alsa-devel] [PATCH] OMAP: McBSP: Do not use extensive spin
 locks for dma_op_mode
Date: Thu, 29 Oct 2009 09:15:24 +0200
Message-ID: <20091029091524.a663e4e5.jhnikula@gmail.com>
References: <1256641215-26131-1-git-send-email-peter.ujfalusi@nokia.com>
	<200910280752.23859.peter.ujfalusi@nokia.com>
	<1256712814.30157.388.camel@eenurkka-desktop>
	<200910290835.51475.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <200910290835.51475.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Oct 2009 08:35:51 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > The spinlocks are unnecessary. In the above example, you get the same
> > with just "return mcbsp->dma_op_mode;"
> > 
> > -> Peter's patch is a good cleanup.
> 
> Jarkko: are we going to take this?
> 
Yep, you can have my

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
