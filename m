From: Bard Liao <bardliao@realtek.com>
Subject: RE: [patch] ASoC: rt5663: fix a debug statement
Date: Thu, 13 Oct 2016 09:13:47 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7011C77FF@RTITMBSV03.realtek.com.tw>
References: <20161013084712.GB16198@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013084712.GB16198@mwanda>
Content-Language: zh-TW
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Thursday, October 13, 2016 4:47 PM
> To: Bard Liao
> Cc: Oder Chiou; Liam Girdwood; Mark Brown; Jaroslav Kysela; Takashi Iwai;
> alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [patch] ASoC: rt5663: fix a debug statement
> 
> We increment "i" before printing the debug statement.  That makes it the
> wrong sleep_time[] information and Smatch complains that the last increment
> could be beyond the end of the array.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Acked-by: Bard Liao <bardliao@realtek.com>
