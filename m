From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix reporting of partial jack updates
Date: Tue, 6 Sep 2011 01:16:01 +0100
Message-ID: <CABS+qY2OA-Yub-K-7LGq7QZKmiGLQH4X26NqtS83AeEgmVp=CQ@mail.gmail.com>
References: <1315149522-20488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B6791038E1
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 02:16:02 +0200 (CEST)
Received: by mail-qy0-f178.google.com with SMTP id 30so3245373qyk.2
	for <alsa-devel@alsa-project.org>; Mon, 05 Sep 2011 17:16:01 -0700 (PDT)
In-Reply-To: <1315149522-20488-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 4 September 2011 16:18, Mark Brown
<broonie@opensource.wolfsonmicro.com>wrote:

> We need to report the entire jack state to the core jack code, not just
> the bits that were being updated by the caller, otherwise the status
> reported by other detection methods will be omitted from the state seen
> by userspace.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-jack.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
> index 38b0013..fa31d9c 100644
> --- a/sound/soc/soc-jack.c
> +++ b/sound/soc/soc-jack.c
> @@ -105,7 +105,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int
> status, int mask)
>
>        snd_soc_dapm_sync(dapm);
>
> -       snd_jack_report(jack->jack, status);
> +       snd_jack_report(jack->jack, jack->status);
>
>  out:
>        mutex_unlock(&codec->mutex);
> --
> 1.7.5.4
>
>
Acked-by: Liam Girdwood <lrg@ti.com>
