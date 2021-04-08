Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E3C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 10:39:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E64861168
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 10:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E64861168
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A248166D;
	Thu,  8 Apr 2021 12:38:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A248166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617878370;
	bh=afzDkEQp//ZfJiZ9JYFwKo6XLJKJ4DcCyDmUw1KIaWY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZbfV0DOQLRbblczLHzpzfkcNKW86qwxCNV4jPF7stQFh+IZN1Sn2lxWsrmaCA8tXo
	 yxOKmgx+VCyoyWQol1e8D69f+0Xz8a2xA8Nh8a2Ug2kZq/Nrw1igehDu7Xz2SUU4Rm
	 +HMTELHXFdWGt2ukgWiVDg2900+7dpbHMKOCGSt0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F434F80169;
	Thu,  8 Apr 2021 12:38:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDEA2F8020B; Thu,  8 Apr 2021 12:38:38 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B48F4F800BD
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 12:38:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B48F4F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="KT65DIZ6"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="n03S7Vw8"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B07C25C012F;
 Thu,  8 Apr 2021 06:38:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 08 Apr 2021 06:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=QwEMU12VQj2swmmMahP+YxBzar4
 xdRDbJRN+jWDRm2Q=; b=KT65DIZ6RbwIaTGJfDTp538y6Xn296/IWHEzSzYB+oz
 hxNz9gNQi/hWRneI7F2aOCd/rOwdfjd6CHNo+ohAMqSfMAkrXL+2BsxN1vQgOYOb
 9mrXYzsQ31F+J4orVg5nl7EgkilzER0eDG7K1zkmEmevkS/ovE24ijOm/MtgrMn1
 jx6bSKgWqQkV+uplA3wW76q5eE60p3HvE2vxa2/6svFpdj1zEYeSmHxF+lS8+6j+
 A2zr906qlYSPM5Ake1JKUxL6lL4uke/45oUWtXIMs1TyerHxlzGNnfoEy/+FLU2Z
 XNn6UHxeiDoFpJ+irx9K9CB4UHjzsXQpp1StNaLS+zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QwEMU1
 2VQj2swmmMahP+YxBzar4xdRDbJRN+jWDRm2Q=; b=n03S7Vw8rGArdf2BlWCHPR
 PaqTDDm9+8108V6Rpd6LUQWgq6ZIl/f3ZTlM9kak048XqN7zHNa37/+j5/GbF0rG
 rbcy/UUJ5pgUZ1tTakzVycNq/7ihuuU+Ey2v2/E6d+72GixoKVbMFDDI7rSw7J6w
 4t17SnAxtUtY1YErO1ENQcU+vs47j98yEtoqEVcFATYkNwxWcAA4+j6c8L0Ygd4s
 Ia//C5/UgMIocAjgBSZ1G/uI09WHnzwmubyDjrSJDF1bbu+fbrHryYC2m/ERoMh9
 zEHiEsMdX/WqKSEZ6F5xQHIXqWOupgXr2pzYUdybObEZMP4SW7vZTzhDlTkqNYtQ
 ==
X-ME-Sender: <xms:Ht1uYENUiJZcHBOeOIWXeY-HgvDKmdnzT7wBfAs7KXlR5ggxXFAg-Q>
 <xme:Ht1uYK8ueqOnfuKAZklMiiYt76EqZDslBjWl3S5aXVLWbc925bWV-i1NBzM1mpAht
 __qpbw8AzwvrKGC9Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejledgfeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
 tddtgeetjeekvdefgeefhfenucfkphepudegrdefrdeihedrudejheenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
 rghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Ht1uYLRyqyMfS3gHIM9ShiCntMXiYL_tMRd6135rSo6q0DY8xeliRg>
 <xmx:Ht1uYMv64FO0GUGsoghbjd8OjCJ50p9h8ze7NdLElSFGXSR8I9a5Tg>
 <xmx:Ht1uYMfuhFHaGhBKbADPtqkh0Dfx1isTIWsutDhnMBZFQdy2s90r1g>
 <xmx:H91uYNpt_uopJ0VMRShZchmGe-2hIHdfwzET5HsMOXRmU9ETA__wxw>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 4AD6D24005B;
 Thu,  8 Apr 2021 06:38:21 -0400 (EDT)
Date: Thu, 8 Apr 2021 19:38:19 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: core - add more card sysfs entries
Message-ID: <20210408103819.GA40407@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20210408094314.1322802-1-perex@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408094314.1322802-1-perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Thu, Apr 08, 2021 at 11:43:14AM +0200, Jaroslav Kysela wrote:
> There are several strings which are describing the card. As time goes,
> we have new universal drivers which probe components in a way, which
> is disassociated from the card structure (ASoC). Also, some drivers
> may require to select another firmware depending on the specific
> platform using udev. The new firmware may change the sound card behaviour.
> 
> This patch allows flexible modifications of the card description
> from the user space to handle the specific boot / plug-in settings.
> 
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> ---
>  sound/core/init.c | 166 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 155 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/core/init.c b/sound/core/init.c
> index ef41f5b3a240..01b26912a4d0 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -662,6 +662,33 @@ void snd_card_set_id(struct snd_card *card, const char *nid)
>  }
>  EXPORT_SYMBOL(snd_card_set_id);
>  
> +#define EXTRA_ID_CHARS		"_-"
> +#define EXTRA_NAME_CHARS	" _-.:"
> +
> +static bool safe_attr_strcpy(char *dst, size_t dst_count,
> +			     const char *src, size_t src_count,
> +			     const char *extra_characters)
> +{
> +	size_t idx, copy;
> +	int c;
> +
> +	copy = src_count >= dst_count ? dst_count - 1 : src_count;
> +	for (idx = 0; idx < copy; idx++) {
> +		c = src[idx];
> +		if (c < ' ') {
> +			copy = idx;
> +			break;
> +		}
> +		if (!isalnum(c) && !strchr(extra_characters, c))
> +			return false;
> +	}
> +	if (copy < 3)
> +		return false;
> +	memcpy(dst, src, copy);
> +	dst[copy] = '\0';
> +	return true;
> +}
> +
>  static ssize_t
>  card_id_show_attr(struct device *dev,
>  		  struct device_attribute *attr, char *buf)
> @@ -676,18 +703,10 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
>  {
>  	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
>  	char buf1[sizeof(card->id)];
> -	size_t copy = count > sizeof(card->id) - 1 ?
> -					sizeof(card->id) - 1 : count;
> -	size_t idx;
> -	int c;
>  
> -	for (idx = 0; idx < copy; idx++) {
> -		c = buf[idx];
> -		if (!isalnum(c) && c != '_' && c != '-')
> -			return -EINVAL;
> -	}
> -	memcpy(buf1, buf, copy);
> -	buf1[copy] = '\0';
> +	if (!safe_attr_strcpy(buf1, sizeof(buf1), buf, count, EXTRA_ID_CHARS))
> +		return -EINVAL;
> +
>  	mutex_lock(&snd_card_mutex);
>  	if (!card_id_ok(NULL, buf1)) {
>  		mutex_unlock(&snd_card_mutex);
> @@ -712,9 +731,134 @@ card_number_show_attr(struct device *dev,
>  
>  static DEVICE_ATTR(number, 0444, card_number_show_attr, NULL);

Use DEVICE_ATTR_RO() instead.

> +static ssize_t
> +card_driver_show_attr(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", card->driver);
> +}
> +
> +static ssize_t
> +card_driver_store_attr(struct device *dev, struct device_attribute *attr,
> +		       const char *buf, size_t count)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	char driver1[sizeof(card->driver)];
> +
> +	if (!safe_attr_strcpy(driver1, sizeof(driver1), buf, count, EXTRA_NAME_CHARS))
> +		return -EINVAL;
> +	mutex_lock(&snd_card_mutex);
> +	strcpy(card->driver, driver1);
> +	mutex_unlock(&snd_card_mutex);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(driver, 0644, card_driver_show_attr, card_driver_store_attr);

Use DEVICE_ATTR_RW() instead.

> +static ssize_t
> +card_name_show_attr(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", card->shortname);
> +}
> +
> +static ssize_t
> +card_name_store_attr(struct device *dev, struct device_attribute *attr,
> +		     const char *buf, size_t count)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	char name1[sizeof(card->shortname)];
> +
> +	if (!safe_attr_strcpy(name1, sizeof(name1), buf, count, EXTRA_NAME_CHARS))
> +		return -EINVAL;
> +	mutex_lock(&snd_card_mutex);
> +	strcpy(card->shortname, name1);
> +	mutex_unlock(&snd_card_mutex);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(name, 0644, card_name_show_attr, card_name_store_attr);

Use DEVICE_ATTR_RW() instead.

> +static ssize_t
> +card_longname_show_attr(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", card->longname);
> +}
> +
> +static ssize_t
> +card_longname_store_attr(struct device *dev, struct device_attribute *attr,
> +			 const char *buf, size_t count)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	char longname1[sizeof(card->longname)];
> +
> +	if (!safe_attr_strcpy(longname1, sizeof(longname1), buf, count, EXTRA_NAME_CHARS))
> +		return -EINVAL;
> +	mutex_lock(&snd_card_mutex);
> +	strcpy(card->longname, longname1);
> +	mutex_unlock(&snd_card_mutex);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(longname, 0644, card_longname_show_attr, card_longname_store_attr);

Use DEVICE_ATTR_RW() instead.

> +static ssize_t
> +card_mixername_show_attr(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", card->mixername);
> +}
> +
> +static ssize_t
> +card_mixername_store_attr(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t count)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	char mixername1[sizeof(card->mixername)];
> +
> +	if (!safe_attr_strcpy(mixername1, sizeof(mixername1), buf, count, EXTRA_NAME_CHARS))
> +		return -EINVAL;
> +	mutex_lock(&snd_card_mutex);
> +	strcpy(card->mixername, mixername1);
> +	mutex_unlock(&snd_card_mutex);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(mixername, 0644, card_mixername_show_attr, card_mixername_store_attr);

Use DEVICE_ATTR_RW() instead.

> +static ssize_t
> +card_components_show_attr(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", card->components);
> +}
> +
> +static ssize_t
> +card_components_store_attr(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t count)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +	char components1[sizeof(card->components)];
> +
> +	if (!safe_attr_strcpy(components1, sizeof(components1), buf, count, EXTRA_NAME_CHARS))
> +		return -EINVAL;
> +	mutex_lock(&snd_card_mutex);
> +	strcpy(card->components, components1);
> +	mutex_unlock(&snd_card_mutex);
> +	return count;
> +}
> +
> +static DEVICE_ATTR(components, 0644, card_components_show_attr, card_components_store_attr);

Use DEVICE_ATTR_RW() instead.

>  static struct attribute *card_dev_attrs[] = {
>  	&dev_attr_id.attr,
>  	&dev_attr_number.attr,
> +	&dev_attr_driver.attr,
> +	&dev_attr_name.attr,
> +	&dev_attr_longname.attr,
> +	&dev_attr_mixername.attr,
> +	&dev_attr_components.attr,
>  	NULL
>  };
>  
> -- 
> 2.30.2

It should be done to emit snd_ctl_event when changing card parameters.
Silent change is the worst since many userspace applications can refer
to them in advance.


Regards

Takashi Sakamoto
