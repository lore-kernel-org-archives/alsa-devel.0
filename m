From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 0/3] McPDM driver patch series
Date: Sat, 19 Dec 2009 11:11:36 +0000
Message-ID: <20091219111136.GA2937@sirena.org.uk>
References: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8BA0A6D0@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 17, 2009 at 01:40:27PM -0600, Candelaria Villareal, Jorge wrote:
> McPDM module is the interface between the OMAP and TWL6030 audio codec.
> It transfers data between the two chips using a Pulse Density Modulation
> protocol, which allows sound to be played or recorded at speeds of up to
> 96000 Hz. Besides data, McPDM can transfer commands and read status
> to/from the codec using the frame synchronization line.

Apart from the comments Felipe already made this all looks very good to
me - because the McPDM port isn't as general purpose as the McBSP port
you can structure things a little more straightforwardly than that
driver which will be a relatively big change but apart from that what's
here seems reasonable.
