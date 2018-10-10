From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] pinctrl: madera: Fix uninitialized
 variable bug in madera_mux_set_mux
Date: Wed, 10 Oct 2018 17:08:01 +0100
Message-ID: <20181010160801.GB1653@imbe.wolfsonmicro.main>
References: <20181010151313.GA16854@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id AB1E82678D9
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 18:08:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181010151313.GA16854@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 10, 2018 at 05:13:13PM +0200, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is checked
> in an IF statement, and then its value is used to report an error at
> line 659 without being properly initialized previously:
> 
> 659 if (ret)
> 660	dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
> 
> Fix this by initializing variable *ret* to 0 in order to
> avoid unpredictable or unintended results.
> 
> Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
> Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
