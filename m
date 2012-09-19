From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] [v3] ASoC: fsl: use
 snd_soc_register_card to register the card
Date: Tue, 18 Sep 2012 22:35:31 -0400
Message-ID: <20120919023530.GE8832@opensource.wolfsonmicro.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 406B6265129
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:35:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347657278-25295-1-git-send-email-timur@freescale.com>
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

On Fri, Sep 14, 2012 at 04:14:34PM -0500, Timur Tabi wrote:
> Use snd_soc_register_card() instead of platform_device_alloc("soc-audio")
> to register the sound card from the machine drivers.  The use of
> platform_device_alloc is deprecated.

Applied, thanks.
