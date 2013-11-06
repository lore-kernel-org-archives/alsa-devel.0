From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/31] ASoC: wm_adsp: Fix BUG_ON() and
	WARN_ON() usages
Date: Wed, 6 Nov 2013 18:44:22 +0000
Message-ID: <20131106184422.GI30879@opensource.wolfsonmicro.com>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
 <1383673218-18405-14-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 791FF265327
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 19:50:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1383673218-18405-14-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 05, 2013 at 06:40:00PM +0100, Takashi Iwai wrote:
> @@ -645,27 +647,22 @@ static int wm_adsp_load(struct wm_adsp *dsp)
>  			reg = offset;
>  			break;
>  		case WMFW_ADSP1_PM:
> -			BUG_ON(!mem);
>  			region_name = "PM";
>  			reg = wm_adsp_region_to_reg(mem, offset);
>  			break;
>  		case WMFW_ADSP1_DM:
> -			BUG_ON(!mem);
>  			region_name = "DM";
>  			reg = wm_adsp_region_to_reg(mem, offset);
>  			break;
>  		case WMFW_ADSP2_XM:
> -			BUG_ON(!mem);
>  			region_name = "XM";
>  			reg = wm_adsp_region_to_reg(mem, offset);
>  			break;
>  		case WMFW_ADSP2_YM:
> -			BUG_ON(!mem);
>  			region_name = "YM";
>  			reg = wm_adsp_region_to_reg(mem, offset);
>  			break;
>  		case WMFW_ADSP1_ZM:
> -			BUG_ON(!mem);
>  			region_name = "ZM";
>  			reg = wm_adsp_region_to_reg(mem, offset);
>  			break;

These do make me a little nervous previously we would panic here,
so everything would stop but now we may write random registers on
the CODEC which could cause some odd behaviour. I think it would
be better to update wm_adsp_region_to_reg to allow a failed
return code and then error out of wm_adsp_load rather than just
relying on the WARN_ON inside.

Otherwise the patch looks good to me though.

Thanks,
Charles
