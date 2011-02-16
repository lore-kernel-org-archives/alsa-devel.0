From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v19 3/3] ASoC: WL1273 FM radio: Access I2C
 IO functions through pointers.
Date: Tue, 15 Feb 2011 18:02:18 -0800
Message-ID: <20110216020217.GB3021@opensource.wolfsonmicro.com>
References: <1297757626-3281-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1297757626-3281-2-git-send-email-matti.j.aaltonen@nokia.com>
	<1297757626-3281-3-git-send-email-matti.j.aaltonen@nokia.com>
	<1297757626-3281-4-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC29B243F5
	for <alsa-devel@alsa-project.org>; Wed, 16 Feb 2011 03:02:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297757626-3281-4-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, mchehab@redhat.com, hverkuil@xs4all.nl, lrg@slimlogic.co.uk, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 15, 2011 at 10:13:46AM +0200, Matti J. Aaltonen wrote:

>  	if (core->i2s_mode != mode) {
> -		r = wl1273_fm_write_cmd(core, WL1273_I2S_MODE_CONFIG_SET, mode);
> +		r = core->write(core, WL1273_I2S_MODE_CONFIG_SET, mode);

I'm having a hard time loving the replacement of the function with the
direct dereference from the struct but overall this is a good win so:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
