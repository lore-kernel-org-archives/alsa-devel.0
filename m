From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: core: display the platform node
 name if there is no platform name
Date: Tue, 11 Sep 2012 08:19:37 +0800
Message-ID: <20120911001936.GE30699@opensource.wolfsonmicro.com>
References: <1347314576-13832-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 654EC264EEE
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 02:19:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347314576-13832-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 05:02:55PM -0500, Timur Tabi wrote:
> A platform can be matched by either a string name or a device tree node
> pointer, so we can't assume that dai_link->platform_name is valid.  Fix
> an error message in soc_bind_dai_link() to use the device tree node
> name if the platform name is null.

Applied, but please avoid the use of the ternery operator in future.
