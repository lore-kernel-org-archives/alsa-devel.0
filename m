From: Peter Rosin <peda@axentia.se>
Subject: RE: [PATCH] ASoC: tfa9879: Fix return value check in
 tfa9879_i2c_probe()
Date: Thu, 16 Apr 2015 13:08:11 +0000
Message-ID: <1e7ee2f56f044e50acacf9481a9ee746@EMAIL.axentia.se>
References: <1429186666-20547-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429186666-20547-1-git-send-email-weiyj_lk@163.com>
Content-Language: sv-SE
Sender: linux-kernel-owner@vger.kernel.org
To: "weiyj_lk@163.com" <weiyj_lk@163.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Wei Yongjun wrote:
> In case of error, the function devm_kzalloc() returns NULL not ERR_PTR().
> The IS_ERR() test in the return value check should be replaced with NULL
> test.

Acked-by: Peter Rosin <peda@axentia.se>

Thanks,
Peter
