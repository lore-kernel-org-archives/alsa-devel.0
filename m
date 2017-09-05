From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/3] ASoC: wm8741: Set OSR mode in
	hw_params()
Date: Tue, 5 Sep 2017 17:12:21 +0100
Message-ID: <20170905161221.qopgxgaw4zhfzfvs@localhost.localdomain>
References: <1504553653-8144-1-git-send-email-sergej@taudac.com>
 <1504553653-8144-3-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 93E08267217
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 18:12:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504553653-8144-3-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 04, 2017 at 09:34:12PM +0200, Sergej Sawazki wrote:
> +	/* oversampling rate */
> +	if (params_rate(params) > 96000)
> +		mode |= 0x0040;
> +	else if (params_rate(params) > 48000)
> +		mode |= 0x0020;

Should this not have a case for <= 48k as well? To reset the mode
if it was set on a previous playback.

> +
>  	/* bit size */
>  	switch (params_width(params)) {
>  	case 16:
> @@ -243,6 +250,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>  		params_width(params), params_rate(params));
>  
>  	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
> +	snd_soc_write(codec, WM8741_MODE_CONTROL_1, mode);

Better to use an update_bits rather than basically open-code it
with read and then this write.

Thanks,
Charles
