From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] ASoC: Update cx20442 for TTY API change
Date: Thu, 12 May 2011 02:01:20 +0200
Message-ID: <201105120201.20772.jkrzyszt@tis.icnet.pl>
References: <1305099643-10536-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 02C422415C
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 02:02:07 +0200 (CEST)
In-Reply-To: <1305099643-10536-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Felipe Balbi <balbi@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed 11 May 2011 at 09:40:43 Mark Brown wrote:
> receive_buf() was recently changed to return the number of bytes
> received but the cx20442 driver wasn't updated to match the new API.
> I don't have any hardware but since we don't actually appears to be
> listening to the data at all just report that we accepted all the
> data that was offered to us.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

> ---
>  sound/soc/codecs/cx20442.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
> index d68ea53..f8c663d 100644
> --- a/sound/soc/codecs/cx20442.c
> +++ b/sound/soc/codecs/cx20442.c
> @@ -262,14 +262,14 @@ static int v253_hangup(struct tty_struct *tty)
>  }
> 
>  /* Line discipline .receive_buf() */
> -static void v253_receive(struct tty_struct *tty,
> -				const unsigned char *cp, char *fp, int count)
> +static unsigned int v253_receive(struct tty_struct *tty,
> +				 const unsigned char *cp, char *fp, int count)
>  {
>  	struct snd_soc_codec *codec = tty->disc_data;
>  	struct cx20442_priv *cx20442;
> 
>  	if (!codec)
> -		return;
> +		return count;
> 
>  	cx20442 = snd_soc_codec_get_drvdata(codec);
> 
> @@ -281,6 +281,8 @@ static void v253_receive(struct tty_struct *tty,
>  		codec->hw_write = (hw_write_t)tty->ops->write;
>  		codec->card->pop_time = 1;
>  	}
> +
> +	return count;
>  }
> 
>  /* Line discipline .write_wakeup() */
