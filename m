From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: wm0010: disable regulator on
	error
Date: Fri, 18 Sep 2015 12:34:12 +0100
Message-ID: <20150918113412.GF7694@ck-lbox>
References: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id C9A4F260412
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 13:58:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2015 at 04:02:19PM +0530, Sudip Mukherjee wrote:
> We have done regulator_bulk_enable() while booting the DSP but on the
> error exit path we have not disbled it.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  sound/soc/codecs/wm0010.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
> index 8434d45..79a7cd3 100644
> --- a/sound/soc/codecs/wm0010.c
> +++ b/sound/soc/codecs/wm0010.c
> @@ -739,8 +739,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
>  abort:
>  	/* Put the chip back into reset */
>  	wm0010_halt(codec);
> -	mutex_unlock(&wm0010->lock);
> -	return ret;

Does wm0010_halt not disable the regulators?

Thanks,
Charles

>  
>  err_core:
>  	mutex_unlock(&wm0010->lock);
> -- 
> 1.9.1
