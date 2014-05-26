From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 15:29:03 +0200
Message-ID: <5383419F.9040105@metafoo.de>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-006.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id 9E9CC265284
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:29:02 +0200 (CEST)
In-Reply-To: <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
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
[...]
> + * snd_soc_dapm_kcontrol_platform() - Returns the platform associated to a kcontrol
> + * @kcontrol: The kcontrol
> + */
> +struct snd_soc_platform *snd_soc_dapm_kcontrol_platform(
> +		struct snd_kcontrol *kcontrol)
> +{
> +	return dapm_kcontrol_get_wlist(kcontrol)->widgets[0]->platform;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_dapm_kcontrol_platform);

This conflicts with the series that moves DAPM support to the component 
level [1].

- Lars

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076718.html
