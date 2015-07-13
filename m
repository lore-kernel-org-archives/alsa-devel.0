From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 37/37] ALSA:
 firewire-motu: add hwdep interface
Date: Mon, 13 Jul 2015 20:28:50 +0930
Message-ID: <20150713105850.GB32641@marvin.atrad.com.au>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
 <1436623968-10780-38-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 46E1D260459
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 12:58:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1436623968-10780-38-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 11, 2015 at 11:12:48PM +0900, Takashi Sakamoto wrote:
> This commit adds hwdep interface so as the other firewire sound devices
> has.
> :

> +static int hwdep_get_info(struct snd_motu *motu, void __user *arg)
> +{
> +	struct fw_device *dev = fw_parent_device(motu->unit);
> +	struct snd_firewire_get_info info;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.type = SNDRV_FIREWIRE_TYPE_FIREWORKS;

A SNDRV_FIREWIRE_TYPE_MOTU type identifier was defined, so should it not be
used here?

> +int snd_motu_create_hwdep_device(struct snd_motu *motu)
> +{
> +	struct snd_hwdep *hwdep;
> +	int err;
> +
> +	err = snd_hwdep_new(motu->card, "MOTU", 0, &hwdep);
> +	if (err < 0)
> +		goto end;
> +	strcpy(hwdep->name, "MOTU");
> +	hwdep->iface = SNDRV_HWDEP_IFACE_FW_FIREWORKS;

Similarly, SNDRV_HWDEP_IFACE_FW_MOTU is defined and it would seem to me that
it should be used here instead of SNDRV_HWDEP_IFACE_FW_FIREWORKS.  Am I
missing something?

Regards
  jonathan
