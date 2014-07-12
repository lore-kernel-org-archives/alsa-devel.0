From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
	registration
Date: Sat, 12 Jul 2014 17:27:59 +0200
Message-ID: <53C153FF.4090705@metafoo.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id D3ACF2651FE
 for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2014 17:29:04 +0200 (CEST)
In-Reply-To: <1405086308-1461192-4-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/11/2014 03:45 PM, Arnd Bergmann wrote:
> As a prerequisite for moving s3c64xx into multiplatform configurations,
> we need to change the smartq audio driver to stop using hardcoded
> gpio numbers from the header file, and instead pass the gpio data
> through platform_data.

This should be using the gpiod API. The gpiod API allows you to pass the GPIOs 
without having to add a platform_data struct.

- Lars
