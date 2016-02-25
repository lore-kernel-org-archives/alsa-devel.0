From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [patch 2/2] ASoC: max9867: silence and array overflow warning
Date: Thu, 25 Feb 2016 16:18:37 +0800
Message-ID: <CAFRkauDgp3B=HXkd3dcZ0dwhGEg+KfYdgfK5Sfr9B_pi5x-G=g@mail.gmail.com>
References: <20160225075038.GC7333@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160225075038.GC7333@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, anish kumar <yesanishhere@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2016-02-25 15:50 GMT+08:00 Dan Carpenter <dan.carpenter@oracle.com>:
> Smatch complains that we might reach the end of this loop without
> finding what we're looking for leading to a buffer overflow.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
