Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9433CC6FD1F
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Apr 2024 06:58:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B94292C30;
	Tue,  2 Apr 2024 08:58:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B94292C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712041097;
	bh=t5Dr+QPEU1FaZbxI2VzHHPUV33oVM25Zuyjp8wRwBxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=c6hBqfBqDAdtsG/yTz+tCV/LabgBGfgFPvg/wsydqSeFZPmtTfaCdyA+Js3IfB4wK
	 1AVubnPdRbD+1QgKBlTHuW8zRDtTWxkf3sIFouekfvgkdQUcAe4MtY9TVw7gteRpdZ
	 COgPlFX9soDiFdLLKUF9KHVafN78t9AxNx9fbWM4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50DAEF80803; Tue,  2 Apr 2024 08:51:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4A32F80803;
	Tue,  2 Apr 2024 08:51:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4D44F802DB; Wed, 27 Mar 2024 13:56:26 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 83650F801D5
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 13:56:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83650F801D5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PeI1DRl9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2187BCE2616;
	Wed, 27 Mar 2024 12:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C93C43390;
	Wed, 27 Mar 2024 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711544174;
	bh=t5Dr+QPEU1FaZbxI2VzHHPUV33oVM25Zuyjp8wRwBxQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PeI1DRl97jSBL5h+TjLof7OmsdrUn8XoRsGQVaXc1QrS2MsqMVnRRdmF+M5dmweaA
	 Cf4i01dUWOny6pJ6QuLijRvpE44xS0PcZc1e9PeN+WBhzhBO4xJy/Ts3k409QwdVEV
	 p+A11VpmypxO3Ps9Q8jXDfwY+GDNk4U7h2495MzupWAahXb3s6nMhf4xTbKbYBv9sH
	 Qg2EVim4HGea+Pk1qx3RaNxw1jAVCalYFQ1zjH9SvFpUEhLNt2Q6UwcJWGcqLuJGpO
	 jNEGpE3iLazGfTCtetqVqdY3FWUY6/vKk+gRsmlO3tArdLh8t7rKXHMt3Lo2FnfSbu
	 armFDkXpy3JVQ==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>,  Richard
 Weinberger <richard@nod.at>,  Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Jens Axboe <axboe@kernel.dk>,  Marcel
 Holtmann <marcel@holtmann.org>,  Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>,  Olivia Mackall <olivia@selenic.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  Amit Shah <amit@kernel.org>,  Arnd
 Bergmann <arnd@arndb.de>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Gonglei <arei.gonglei@huawei.com>,  "David
 S. Miller" <davem@davemloft.net>,  Viresh Kumar <vireshk@kernel.org>,
  Linus Walleij <linus.walleij@linaro.org>,  Bartosz Golaszewski
 <brgl@bgdev.pl>,  David Airlie <airlied@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Gurchetan Singh <gurchetansingh@chromium.org>,
  Chia-I Wu <olvaffe@gmail.com>,  Jean-Philippe Brucker
 <jean-philippe@linaro.org>,  Joerg Roedel <joro@8bytes.org>,  Alexander
 Graf <graf@amazon.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Eric Van
 Hensbergen <ericvh@kernel.org>,  Latchesar Ionkov <lucho@ionkov.net>,
  Dominique Martinet <asmadeus@codewreck.org>,  Christian Schoenebeck
 <linux_oss@crudebyte.com>,  Stefano Garzarella <sgarzare@redhat.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Dave Jiang <dave.jiang@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
  Bjorn Andersson <andersson@kernel.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>,  Vivek Goyal <vgoyal@redhat.com>,  Miklos
 Szeredi <miklos@szeredi.hu>,  Anton Yakovlev
 <anton.yakovlev@opensynergy.com>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  virtualization@lists.linux.dev,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-um@lists.infradead.org,  linux-block@vger.kernel.org,
  linux-bluetooth@vger.kernel.org,  linux-crypto@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-gpio@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  iommu@lists.linux.dev,
  netdev@vger.kernel.org,  v9fs@lists.linux.dev,  kvm@vger.kernel.org,
  linux-wireless@vger.kernel.org,  nvdimm@lists.linux.dev,
  linux-remoteproc@vger.kernel.org,  linux-scsi@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org
Subject: Re: [PATCH 17/22] wireless: mac80211_hwsim: drop owner assignment
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
	<20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
Date: Wed, 27 Mar 2024 14:55:58 +0200
In-Reply-To: <20240327-module-owner-virtio-v1-17-0feffab77d99@linaro.org>
	(Krzysztof Kozlowski's message of "Wed, 27 Mar 2024 13:41:10 +0100")
Message-ID: <87plvf7s0x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-MailFrom: kvalo@kernel.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: EPV727RFCX6W7OZCHK2GTIZHFTYKIEGP
X-Message-ID-Hash: EPV727RFCX6W7OZCHK2GTIZHFTYKIEGP
X-Mailman-Approved-At: Tue, 02 Apr 2024 06:49:42 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> virtio core already sets the .owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

We use "wifi:" in the title, not "wireless:". It would be nice if you
can fix this during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
