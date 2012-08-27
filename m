From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic26: Use
	module_spi_driver
Date: Mon, 27 Aug 2012 09:55:36 -0700
Message-ID: <20120827165535.GN4339@opensource.wolfsonmicro.com>
References: <1346067028-9534-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84581265E3F
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 19:01:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346067028-9534-1-git-send-email-sachin.kamat@linaro.org>
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

On Mon, Aug 27, 2012 at 05:00:26PM +0530, Sachin Kamat wrote:
> module_spi_driver makes the code simpler by eliminating
> module_init and module_exit calls.

Applied, thanks.
