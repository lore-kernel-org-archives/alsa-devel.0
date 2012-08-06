From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/27] ASoC: Use module_i2c_driver
Date: Mon, 6 Aug 2012 15:23:35 +0100
Message-ID: <20120806142334.GJ16861@opensource.wolfsonmicro.com>
References: <1344254160-6615-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5531826533D
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 15:53:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344254160-6615-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 05:25:33PM +0530, Sachin Kamat wrote:
> module_i2c_driver() is helper macro for I2C drivers which do not do anything
> special in module init/exit. This eliminates a lot of boilerplate
> and calling it replaces module_init() and module_exit().

Applied all, thanks.
