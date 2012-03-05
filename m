From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 03/20] ARM: imx: merge audmux-v1 and
	audmux-v2
Date: Mon, 5 Mar 2012 15:33:47 +0800
Message-ID: <20120305073345.GA16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
	<4F54072E.6040407@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DE8B4103EC4
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 08:19:24 +0100 (CET)
Received: by iakh37 with SMTP id h37so5495325iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Mar 2012 23:19:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F54072E.6040407@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 12:22:07AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > +static unsigned char port_mapping[] = {
> > +	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
> > +};
> 
> May as well make this a 'const' array while you're at it.  And perhaps 
> uint8_t is a better choice than "unsigned char".
> 
Okay, will do.

-- 
Regards,
Shawn
