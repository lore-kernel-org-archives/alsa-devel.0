From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 05/14] mfd: sun6i-prcm: Add sun8i analog codec as
 subnode
Date: Tue, 4 Oct 2016 12:52:17 +0200
Message-ID: <20161004125217.952342ecac68d3da3336cc76@free.fr>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
        <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c74aea452bd1831f439dd67884cb2879e0849f03.1475571575.git.mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: vinod.koul@intel.com, maxime.ripard@free-electrons.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lee.jones@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, alexandre.belloni@free-electrons.com, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue,  4 Oct 2016 11:46:18 +0200
Mylène Josserand <mylene.josserand@free-electrons.com> wrote:

> The sun8i audio codec is using PRCM registers to configure all the
> analog part of the audio codec. It is added as a subnode of the PRCM
> with his resource (offset of 0x1c0).
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> ---
>  drivers/mfd/sun6i-prcm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
	[snip]

I was heard that the PRCM as a MFD would disappear.

-- 
Ken ar c'hentañ	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
