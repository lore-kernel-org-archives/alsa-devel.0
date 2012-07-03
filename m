From: Sangbeom Kim <sbkim73@samsung.com>
Subject: RE: [PATCH 1/1] ASoC: Samsung: Convert to use snd_soc_register_card()
Date: Tue, 03 Jul 2012 19:35:54 +0900
Message-ID: <0d9701cd5907$9fb058f0$df110ad0$@com>
References: <1341304444-11188-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1341304444-11188-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, alsa-devel@alsa-project.org
Cc: linux-samsung-soc@vger.kernel.org, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, tiwai@suse.de, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi!
On Tuesday, Jul 03, 2012 at 05:34PM, Sachin Kamat wrote:
> Current method for machine driver to register with the ASoC core is to use
> snd_soc_register_card() instead of creating a "soc-audio" platform device.

It looks better to include reason of using snd_soc_register_card
instead of creating "soc-audio" or warning message.

Acked-by: Sangbeom Kim <sbkim73@samsung.com>
