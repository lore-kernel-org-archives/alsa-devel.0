Return-Path: <SRS0=tU6Y=FV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7BDC4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 16:48:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4361623382
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Dec 2020 16:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4361623382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED8B81932;
	Thu, 17 Dec 2020 17:47:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED8B81932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608223728;
	bh=T0AqmIKfN/RiiDxYkYFYd5395/1w+BZKyYmZ6ZcOSfo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NAhWj91iaqzSKrVhGpI68tMdU5u8RzIrZ9LwSQWx7I5PckZVZFjR9yn2uI3voC4iX
	 i1FovZHBbpgOl4j8bS9rw99rWPOnu/25Af60RNu437U7wvUicX9k6ULrfKrbWvsKvY
	 XKlk4JJyjrc/+vDFCL8mAoh2YbedJpJxAJvhquxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85BA3F800C7;
	Thu, 17 Dec 2020 17:47:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 703CDF80260; Thu, 17 Dec 2020 17:47:56 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC71BF800C7
 for <alsa-devel@alsa-project.org>; Thu, 17 Dec 2020 17:47:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC71BF800C7
IronPort-SDR: hQa+7G3+5NGRAeDXhWXR8ojSDjeXTETLxiyk0jdDsN6zYjUv/70uqgkzPDYKAPr5CutOKN4rbQ
 dei7UDaQBdcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="175426733"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; d="scan'208";a="175426733"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2020 08:47:49 -0800
IronPort-SDR: L/SWRq+UB49cEsqIcyS5HnF58GzrJWyLysAMOOEUky9aMxNeHuk5Uy5Bkmrc+iy1UaO2vJk+/5
 XZDKH6YS+H4A==
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; d="scan'208";a="369914134"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2020 08:47:47 -0800
Date: Thu, 17 Dec 2020 18:45:05 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Hui Wang <hui.wang@canonical.com>
Subject: Re: [RFC][PATCH v2 1/1] alsa: jack: implement software jack injection
 via debugfs
In-Reply-To: <20201216114628.35739-2-hui.wang@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2012171749580.864696@eliteleevi.tm.intel.com>
References: <20201216114628.35739-1-hui.wang@canonical.com>
 <20201216114628.35739-2-hui.wang@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hey,

I gave a quick test spin and features seems to work as advertized. A few 
minor comments on the code. If Jaroslav you think this would be ok as an 
approach, I can give a more extensive test run on this.

On Wed, 16 Dec 2020, Hui Wang wrote:

> We want to perform remote audio auto test, need the audio jack to
> change from plugout to plugin or vice versa by software ways.
> 
> Here the design is creating a sound-core root folder in the debugfs
> dir, and each sound card will create a folder cardN under sound-core,
> then the sound jack will create folders by jack_ctrl->ctrl->id.name,
> and will create 2 file nodes jackin_inject and sw_inject_enable in
> the folder, this is the layout of folder on a machine with 2 sound
> cards:
> $tree $debugfs_mount_dir/sound-core
> sound-core/
> ├── card0
> │   ├── HDMI!DP,pcm=10 Jack

this combination of "!,= " characters in filenames is a bit non-unixy, 
but maybe in 2020 we are ready for this. 

> +static void _snd_jack_report(struct snd_jack *jack, int status, bool from_inject)
> +{
> +	struct snd_jack_kctl *jack_kctl;
> +	unsigned int mask_bits = 0;
> +#ifdef CONFIG_SND_JACK_INPUT_DEV
> +	int i;
> +#endif
> +	list_for_each_entry(jack_kctl, &jack->kctl_list, list) {
> +		if (jack_kctl->sw_inject_enable == from_inject)
> +			snd_kctl_jack_report(jack->card, jack_kctl->kctl,
> +					     status & jack_kctl->mask_bits);
> +		else if (jack_kctl->sw_inject_enable)
> +			mask_bits |= jack_kctl->mask_bits;
> +	}

I'm wondering if it would be worth the code duplication to have the 
inject-variant of this code in a separate function. I find the above code 
to set up "mask_bits" a bit hard to read and this adds a layer of 
complexity to anyone just wanting to look at the regular jack report code 
path.

> +static ssize_t sw_inject_enable_write(struct file *file,
> +				      const char __user *from, size_t count, loff_t *ppos)
> +{
> +	struct snd_jack_kctl *jack_kctl = file->private_data;
> +	char *buf;
> +	int ret, err;
> +	unsigned long enable;
> +
> +	buf = kzalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = simple_write_to_buffer(buf, count, ppos, from, count);
> +	err = kstrtoul(buf, 0, &enable);
> +	if (err) {
> +		ret = err;
> +		goto exit;
> +	}
> +
> +	jack_kctl->sw_inject_enable = !!enable;

Here it's a bit annoying that after you disable sw_inject, the kcontrol
values are not restored to reflrect actual hw state (until there are 
new jack events from hw). User-space cannot completely handle the 
save'n'restore as it cannot detect if real hw jack status changed 
during the sw-inject test. OTOH, this would require caching the most 
recent value and maybe not worth the effort.

> +static int snd_jack_debugfs_add_inject_node(struct snd_jack *jack,
> +					    struct snd_jack_kctl *jack_kctl)
> +{
> +	char *tname;
> +
> +	/* the folder's name can't contains '/', need to replace it with '!' as lib/kobject.c does */
> +	tname = kstrdup(jack_kctl->kctl->id.name, GFP_KERNEL);

This goes over 100-column limit and triggers a checkpatch complaint.

Br, Kai
