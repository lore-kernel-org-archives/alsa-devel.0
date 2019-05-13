From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] mfd: madera: Add missing of table registration
Date: Mon, 13 May 2019 09:15:21 +0100
Message-ID: <20190513081521.GE45394@ediswmail.ad.cirrus.com>
References: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1557569038-20340-1-git-send-email-dagmcr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Gomez <dagmcr@gmail.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee.jones@linaro.org>, "moderated list:CIRRUS LOGIC MADERA CODEC DRIVERS" <alsa-devel@alsa-project.org>, "open list:CIRRUS LOGIC MADERA CODEC DRIVERS" <patches@opensource.cirrus.com>, open list <linux-kernel@vger.kernel.org>, javier@dowhile0.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 11, 2019 at 12:03:58PM +0200, Daniel Gomez wrote:
> MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
> OF mathing mechanism and register it.
> 
> Before this patch:
> modinfo ./drivers/mfd/madera.ko | grep alias
> 
> After this patch:
> modinfo ./drivers/mfd/madera.ko | grep alias
> alias:          of:N*T*Ccirrus,wm1840C*
> alias:          of:N*T*Ccirrus,wm1840
> alias:          of:N*T*Ccirrus,cs47l91C*
> alias:          of:N*T*Ccirrus,cs47l91
> alias:          of:N*T*Ccirrus,cs47l90C*
> alias:          of:N*T*Ccirrus,cs47l90
> alias:          of:N*T*Ccirrus,cs47l85C*
> alias:          of:N*T*Ccirrus,cs47l85
> alias:          of:N*T*Ccirrus,cs47l35C*
> alias:          of:N*T*Ccirrus,cs47l35
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
