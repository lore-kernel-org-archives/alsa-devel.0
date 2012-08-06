From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: remove device tree probe
	match table
Date: Mon, 6 Aug 2012 12:54:00 +0100
Message-ID: <20120806115400.GA16861@opensource.wolfsonmicro.com>
References: <1344247231-21359-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C93EF265CFA
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 13:24:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344247231-21359-1-git-send-email-jason77.wang@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 06:00:31PM +0800, Hui Wang wrote:
> The sgtl5000 codec driver is an i2c driver instead of a platform
> driver, current of_i2c subsystem will convert an i2c device node
> into a traditional i2c device, the of_match_table is not used.

No, this is a regression - even though we can take a good guess for I2C
devices it is always good to provide a compatible property to avoid
ambiguity.
