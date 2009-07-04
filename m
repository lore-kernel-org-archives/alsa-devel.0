From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Sat, 4 Jul 2009 11:57:43 +0100
Message-ID: <20090704105743.GD10490@sirena.org.uk>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 28ED310381C
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 12:57:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2009 at 12:36:15PM +0530, Vinod Koul wrote:

> +	case SND_FS:
> +		if (intsts & 0x1) {
> +			/*send long push*/
> +			ret_val = snd_intelmad_generate_netlink(1,
> +						AUDIO_EVENT_LONG_PRESS);
> +		}
> +		if (intsts & 0x2) {
> +			/*send short push*/
> +			ret_val = snd_intelmad_generate_netlink(1,
> +						AUDIO_EVENT_SHORT_PRESS);
> +		}
> +		if (intsts & 0x4) {
> +			/*send headphone detect*/
> +			ret_val = snd_intelmad_generate_netlink(1,
> +						AUDIO_EVENT_HP_DETECT);
> +		}
> +		if (intsts & 0x8) {
> +			/*send headset detect*/
> +			ret_val = snd_intelmad_generate_netlink(1,
> +						AUDIO_EVENT_HS_DETECT);
> +		}
> +		break;

ALSA core has an interface for representing jacks to user space which
should be used here - see include/sound/jack.h.

> +	case SND_MX:

> +	case SND_NC:

Looks like you've got one of these per vendor - does this need to be
placed into the vendor abstraction?
