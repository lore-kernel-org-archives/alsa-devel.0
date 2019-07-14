From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [2/2] ASoC: samsung: odroid: fix a double-free issue for cpu_dai
Date: Sun, 14 Jul 2019 14:47:18 +0200
Message-ID: <4545ce50-493c-8faa-fdcd-5aee3ca30792@web.de>
References: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Cheng Shengyu <cheng.shengyu@zte.com.cn>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Takashi Iwai <tiwai@suse.com>, Xue Zhihong <xue.zhihong@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

> The cpu_dai variable is still being used after the of_node_put() call,

Such an implementation detail is questionable.
https://wiki.sei.cmu.edu/confluence/display/c/MEM30-C.+Do+not+access+freed+memory


> which may result in double-free:

This consequence is also undesirable.
https://cwe.mitre.org/data/definitions/415.html


Now I wonder if two update steps are really appropriate as a fix
instead of using a single update step for the desired correction
in this software module.
Should a commit (including previous ones) usually be correct by itself?

Regards,
Markus
