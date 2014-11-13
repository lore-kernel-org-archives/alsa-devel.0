From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: add TI ts3a227e headset chip
	driver
Date: Thu, 13 Nov 2014 08:22:24 +0100
Message-ID: <54645C30.7010406@metafoo.de>
References: <1415837738-22888-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-122.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 65E0F2657CA
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 08:21:42 +0100 (CET)
In-Reply-To: <1415837738-22888-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, bleung@chromium.org, dmitry.torokhov@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/13/2014 01:15 AM, Dylan Reid wrote:
> +static struct snd_soc_codec_driver ts3a227e_codec_driver;
> [...]
> +	ret = snd_soc_register_codec(&i2c->dev, &ts3a227e_codec_driver,
> +				     NULL, 0);
> [...]

Since the driver doesn't need anything CODEC specific it could be made a 
component driver and then you can also use devm_snd_soc_register_component.
