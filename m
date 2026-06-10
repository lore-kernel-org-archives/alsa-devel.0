Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66422CD8CB9
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:06:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20A8D601DE;
	Wed, 10 Jun 2026 19:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20A8D601DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781111179;
	bh=ZL/retJxHghMbMm3wBG9GjaIXvHzD/b88uWKFxklHjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RoWfAGU7c7PNFCgzPtINh0UBVgGsvniD9+g12plGNSU6xV4H3UI/FVrgR3rqRTTai
	 znHMOeypXM4QjlTpnoDjcL4BucFjUfrLMLZKCIFjufENyfxxEugz5n7duGTPocJ1PF
	 RTeeyDRp/XvZdVRZKpzwSPpxuNkOCeNmZ7LFjQnI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC7D6F805F1; Wed, 10 Jun 2026 19:05:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF479F805B1;
	Wed, 10 Jun 2026 19:05:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 610E2F8058C; Wed, 10 Jun 2026 19:05:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781111138;
	b=JtJF+xMe0ME4eGjwkB+aQUpmfP9F7JXOqof1vK8WywueTfpWa/riUBrhvnqEu2pa/WyO
	 B0VHbnzue7gYOB23DrwR2Euktd7ywEAvLaJr9xIJfMXI93dTFnGgVYGvZahhWs9yKB5uW
	 7HlyJqxRtn8c2zViu/I6IayRwqY7tlovqFLHWtDj1fVm6DXTsl72xr5I1zuOftNnqLUO8
	 UFnz+5XMHWVRkyeNkafzqz26cDwx/qKyPHFn+JIZ49lDuLxSNzTR2KkMazvGcjQx3YskA
	 31dVG1E7LqszUvVJmJPnUcWnGdm8SJXeJOHEB3Q2SSzjZEUEY1U1t6K1VCsb8h0WnGw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781111138;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=ZL/retJxHghMbMm3wBG9GjaIXvHzD/b88uWKFxklHjY=;
	b=Rqoon66rfTja/MdFvsPzvvSFMvLGQHTftjv9awt2NZ6eJRL1A0rNNFVdlpK274/rejls
	 rqwMp7G3aRFh/JKCVZIuQB9SM6xX3O9MPJG58eRobg1WFAZjpxq9ymjnSZ+KqurOqwipz
	 xHVxx4eQJtK+hiI35ZRKkFFkPr5ORHUyqpntfcZAUMlGTPld4Un1l+RlAKX4unL+wiJ5y
	 2HNe3lDCXhhi5q2JciTFdEIrXvTyHHMFv7BYHjaSbe0GAPksFz+32gP27Wxe4qoKB6+G6
	 80TPdkOOjNDYulNZXTQ8IYl0sEAbR9j/L+ZvqfdSXo74ZnkFl9X8DePQDc4mc/1ytqQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HVlZ5gQW;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5231F8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 19:05:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5231F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HVlZ5gQW
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-6606678420bso7282172d50.1
        for <alsa-devel@alsa-project.org>;
 Wed, 10 Jun 2026 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111136; x=1781715936;
 darn=alsa-project.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPeGpob12XOt4wzuRg8cl6DokPVvqxwlbtTZOi7h9QE=;
        b=HVlZ5gQWDmq93UZ/PqVO/QbIt1rJZIArQkTQTsR9vrGgx+7sobSq6K+RyLtRYSLNBL
         CO0P4mbUT2Mz59ijudlpOMhihXk+/nh5Jz/v5Bdi783Az3cGMHTNmz/PFR9TCS6C45ou
         39+enHw6Bs2UfM/wm9H5Nppbv/WAc7+oYQdgG/VYPvSI6MlcuFGei7L/LkNmkhyaBb0K
         TvNguJIHjnCO0IOxvTTOo7UJXyXjj6qDWLmhRtf3tErIrQ0lDxwwP7XbGDtdeAgRTh2s
         I023elSJxAP56l0d0luRh/u7JagUeRBkmIeJNgbagXnlKc1MIgVj9pRMzCOaH7akWHT7
         6+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111136; x=1781715936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPeGpob12XOt4wzuRg8cl6DokPVvqxwlbtTZOi7h9QE=;
        b=hhRqYDfgRzplid1AEcARPymxjTdlNMDtqRsx1QdE8067RafgpQaH73fdDZ/4Ga94Zo
         LRzKNiNnQlx0QBrscjJ5t+5Bmuiu2rZPsebxNuaO/yeSrsu/N/7zFbVKiP+BZXf9w4eh
         U1oAbPOmqGUWnYF6dH3Nf79p7ieEoYj7/rfYpFq8HvFo4lpXet5Mirse+W1U5B2hqG1a
         RgmzMYHBrdFdZxWVf7chyowFm3rMb7zyNo6NV2D+AXxW8Yb+muqzCeXYLnUi+6Hk9AUm
         B8qpGupKJ/0fN9iYGTW5hzOILawCrop6vP4pP0O6MR4NT3NIhL6OYq66vPkyGDvvkmXq
         8vcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MUxQPDBH9vVU3AUVFKgDKnE5Vi5h4wM8uifTJHzwn4VSSl0diFPzNj7lYEN577QXuH7qlx1Hu/+Qk@alsa-project.org
X-Gm-Message-State: AOJu0YyJksITZdppv639b8ZzS2+432afb9oqFSE5UR//w1+4dOQ7M66T
	HAdsRKKCLnMA/c46CSCQzPDAoOkLGmpNeanXDoJvB+39M2lHuuI+pD9b
X-Gm-Gg: Acq92OGKlH1qkPCbc6DlauHlAEqdnjMolxKAHhhF+YuV7eab8Dflvlagw6d2pPwTW64
	9NG3zBnOnBMwlg2OTnr06fZ4/2enEoeUTIg2u3oXk1FgcCSPYo3S+e5goN3o1am7bgWlqf22xJM
	gSPDrk+HbiiaR4Yal1s841tpOKa8N+IJUj7htEj0B7vGbPrmuvkLIMGuiroZ+GKGcWXk/msJj4q
	Ka+GT1Ofh3MXTkLcTgg469qMXrdDsCH4BvdhUnhjj5h+9VRLZyBeNVuNPPif/Kp+Gv99d4YaSR0
	J7OvNLtjdBQDvmTS9v8Q8q5HS3ihMY3W5TC1U933zVuHrWjYtikUcb8oO0QKNN75KU9pl4+7A2E
	AlOknwgS+smEFLGjOyJ3oPooMpYH6GW7O21IgDO7QSvoJPp/xN0K7WWU/Whg2oAPw2Oc4TnGBm0
	NJUMF3cmjhSqEhsOu0eCLo0Afr6dnt5IWXUYlswLvrIMStCRQdI/J+N5Z6CCZGd3wTIX3o4m/sq
	WkrTk+5Ou3PDLzYJP1G79srYrDF604NjnSdM04=
X-Received: by 2002:a05:690e:1508:b0:651:bc51:e6b6 with SMTP id
 956f58d0204a3-66106f158f2mr21856830d50.38.1781111135599;
        Wed, 10 Jun 2026 10:05:35 -0700 (PDT)
Received: from alsa-dev.int.suenodeluz.com.do ([74.244.193.113])
        by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-660d5f883e2sm12477189d50.6.2026.06.10.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:05:35 -0700 (PDT)
Date: Wed, 10 Jun 2026 13:05:32 -0400
From: Frank van de Pol <fvdpol@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] ALSA: usb: Add support for Reloop Jockey 3 DJ
 controllers
Message-ID: <lgws3n4rvfphdusgrnubgcbca6vmqrtbrsattyngvovkodtd7c@qh3xupfie5nu>
References: <20260609221643.3439698-1-fvdpol@gmail.com>
 <87o6hi6djp.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6hi6djp.wl-tiwai@suse.de>
Message-ID-Hash: TP2KARR6YSQJU63MGONK426HS5JLW7VH
X-Message-ID-Hash: TP2KARR6YSQJU63MGONK426HS5JLW7VH
X-MailFrom: fvdpol@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TP2KARR6YSQJU63MGONK426HS5JLW7VH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, Jun 10, 2026 at 09:48:58AM +0200, Takashi Iwai wrote:
> Hi Frank, nice to hear you again!
> 
> Through a quick glance, the driver design looks good and most of the
> code are fine, but there can be small details that matter.  Could you
> take a look at Sashiko review?
>   https://sashiko.dev/#/patchset/20260609221643.3439698-2-fvdpol%40gmail.com
> 
> Not all items pointed there are useful, but the playback/capture
> stream spinlock should be taken, and the use of the devres-memory for
> URB buffer needs the re-consideration, too.

Hi Takashi,

Thank you for your review.  

Great to hear that the architectural decision to make an isolated driver
over shoehorning this into the standard driver is accepted.  

I will have a look at the Sashiko review and pay extra attention to the
points you've highlighted.  

Hopefully I'll be able to submit version 2 of the patch by next week (after
completing the multi-platform validation).

> Last but not least, for the resubmission, please send to
> linux-sound@vger.kernel.org (and Cc to linux-kernel@vger.kernel.org).
> Recently we use alsa-devel ML only for user-space stuff, and the
> kernel patches go to vger.
> 

Thank you for pointing this out; I clearly missed that subtle yet important
detail.  Will keep learning :-)

Thanks,
Frank.
