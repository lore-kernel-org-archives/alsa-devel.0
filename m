From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: atmel-ssc: add phybase in device structure
Date: Wed, 29 Jun 2011 10:48:26 -0700
Message-ID: <20110629174822.GB13051@opensource.wolfsonmicro.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
 <a128473d585314a01420a5869949065a549119e3.1309368631.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a128473d585314a01420a5869949065a549119e3.1309368631.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2011 at 08:00:16PM +0200, Nicolas Ferre wrote:

>  struct ssc_device {
>  	struct list_head	list;
> +	resource_size_t		phybase;

The type here looks rather wrong?
