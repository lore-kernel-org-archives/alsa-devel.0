From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: add api for dapm kcontrol
	configiuration
Date: Mon, 26 May 2014 15:26:39 +0200
Message-ID: <5383410F.9020404@metafoo.de>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-006.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id D3AF026518B
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:26:40 +0200 (CEST)
In-Reply-To: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 05/26/2014 02:08 PM, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>
> For DSPs we need to set and get the value for snd_kcontrol. This is currently
> done by dapm_kcontrol_set/get_value, so create a wrapper
> snd_soc_dapm_kcontrol_get/set_value APIs to let drivers use this

Can you go a bit more into detail how you intend to use this?

> [...]
> +unsigned int snd_soc_dapm_kcontrol_get_value(
> +	const struct snd_kcontrol *kcontrol)
> +{
> +	dapm_kcontrol_get_value(kcontrol);

The compiler should have complained about this.

> +}
> +EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_get_value);

I'm also not sure how much sense it makes to have a single line wrapper 
function for exporting things? Why not just rename the original function and 
then export it?
