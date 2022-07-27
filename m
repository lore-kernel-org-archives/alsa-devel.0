Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54A3C04A68
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jul 2022 15:28:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D95F71634;
	Wed, 27 Jul 2022 17:27:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D95F71634
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658935726;
	bh=X4R38B0YvpP53+cn3c6KJ39wQ782kcGBzC4koKiMC0Q=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uwd508GbOfAZ7p19C7El4ej2620SJv02p2GLJyslvjM+zxFTyn/+Iyyk1yI+VsF/b
	 NnG+l5IeXvp0ex92HLc5j2RGg+yQHqksUOldra6qthbPZopil2QqyHU4fRDuFsq72U
	 uNVElN7tyWG4BJwX4PbflgG2Lm8o6KeXU4dsMR20=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B2D7F80155;
	Wed, 27 Jul 2022 17:27:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2DF9F801D5; Wed, 27 Jul 2022 17:27:55 +0200 (CEST)
Received: from neo-zeon.de (neo-zeon.de [70.229.12.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17F97F80155
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2022 17:27:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17F97F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=neo-zeon.de header.i=@neo-zeon.de
 header.b="Z5H8bCbe"
Received: from neo-zeon.de (localhost [::1])
 by neo-zeon.de (OpenSMTPD) with ESMTP id e4ac80df;
 Wed, 27 Jul 2022 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=neo-zeon.de; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; s=1; bh=jU9eOwxiUx1k+ij
 VHwdTw9e3iV0=; b=Z5H8bCbe141mHiQFbax3H26XSHFxkYf1kcmyWLUtEoGAdUP
 iwE3V9eetfzQdEC+E47ugf+mF41dRqpanGwu0B6ofzm6s0QpyuvmVzFPHU7zmnK3
 hrfiyln68xyxPP8kUBO9gVIAySam9kSEoVBeNj0pdo3gYY/WTgYxsWIiaNYk=
Received: by neo-zeon.de (OpenSMTPD) with ESMTPSA id 244ac74f
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO); 
 Wed, 27 Jul 2022 08:27:49 -0700 (PDT)
Message-ID: <cba8bbfe-f17b-f745-a98e-4aa735f0da34@neo-zeon.de>
Date: Wed, 27 Jul 2022 08:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/4] Add support for CLSA0101
Content-Language: en-US
To: Lucas Tanure <tanureal@opensource.cirrus.com>,
 Jaroslav Kysela <perex@perex.cz>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Mark Gross <markgross@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
From: Cameron Berkenpas <cam@neo-zeon.de>
In-Reply-To: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org
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

Sound works as expected with this patch.

Sound fails after resume from sleep & hibernate, but as mentioned by 
Lucas in another email, this is currently expected, and will be fixed in 
a patch for a separate issue.

This is arguably better than the old behavior where we only saw right 
channel sound from the left speaker. I say merge it.

Thanks, Lucas!

-Cameron

On 7/27/22 02:59, Lucas Tanure wrote:
> Add Support for the CLSA0101 laptop, an Intel version of CLSA0100.
> This patch has been tested using the CLSA0100, ensuring it
> doesn't break the sound for it.
> We appreciate it if someone with CLSA0101 could verify that this
> the patch works for them.
>
> Changes from V1:
>   - Add CLSA0101 id into scan.c, serial-multi-instantiate.c
>   and cs35l41_hda_i2c.c
>
> Lucas Tanure (4):
>    ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
>    ALSA: hda: cs35l41: Support CLSA0101
>    ACPI: scan: Add CLSA0101 Laptop Support
>    platform/x86: serial-multi-instantiate: Add CLSA0101 Laptop
>
>   drivers/acpi/scan.c                           |  1 +
>   .../platform/x86/serial-multi-instantiate.c   |  1 +
>   sound/pci/hda/cs35l41_hda.c                   | 67 ++++++++++++-------
>   sound/pci/hda/cs35l41_hda_i2c.c               |  3 +
>   sound/pci/hda/patch_realtek.c                 | 12 ++++
>   5 files changed, 58 insertions(+), 26 deletions(-)
>

