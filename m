Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02D0C3DA7F
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:57:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B93572E1C;
	Wed, 31 Jul 2024 10:56:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B93572E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722416226;
	bh=V9Run24YjNoyGq66FBbC6lVjACSwTiuXq1CwQ7z1P3E=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T9yeYAp08UtdUEXyGYtfJPB2X16lDnZNpdHqMM4jl7h5Niz4k0vQ434Sfdidas+No
	 vQFExdUViE1S4wo5gqE8OKPA+AUijfBaY66rrkHYCwsNlwnt1e0vS3Ozdm1ip9ynq0
	 cacJDEHVFrCkY2bV5IB9OX4fCVp2F3L2Z72aDNgw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCAF0F8065B; Wed, 31 Jul 2024 10:51:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F3A7F80673;
	Wed, 31 Jul 2024 10:51:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62ADFF805D2; Wed, 31 Jul 2024 10:51:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 34323F805B2
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2024 10:46:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34323F805B2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dEH+fCqo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722415576; x=1753951576;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=V9Run24YjNoyGq66FBbC6lVjACSwTiuXq1CwQ7z1P3E=;
  b=dEH+fCqo6eb/pYslmEMsTKQeq56QWAqh3IaRaP9wLcwD6uvh01479PQY
   +kxh3ebSNhbUSA2yvzzy+9fiBuQ4e6sefJLw5RCIXrJsjn+jF0bXrLgvv
   pFVjJlU+G4s8mjJ1bpk25Daql0z8WCwca4dKOi2kV5g7mgPz4MPu3eRrM
   iFAvKicJUp8wikK2G4Nry6vmSnAbixcnq8+usizRki0kvuc7fTzKPSTN9
   MrcTxB/oRyOHKCuKBemwQTWEGhzwcCy6LkfvJl44QNqOzL24xwhL+3V9i
   +Y3UTsBcL8LSCiNlm6rxTXfEoFv4qoaTtNVDJb/lXMhUqZKiFpNEBVhOQ
   w==;
X-CSE-ConnectionGUID: VD7mQZrvQc6uGbCMPLy5YA==
X-CSE-MsgGUID: 0DNGWatVQtGTKRtfXp0EuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="31428283"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800";
   d="scan'208";a="31428283"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 01:46:12 -0700
X-CSE-ConnectionGUID: eUn+BenwSaulz/6QChuy1Q==
X-CSE-MsgGUID: RTe2u23zS2qdqnWYrMB6tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800";
   d="scan'208";a="54605677"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53])
 ([10.94.0.53])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 01:46:11 -0700
Message-ID: <0796c157-1ac3-47a3-9d54-ba86f59d64d5@linux.intel.com>
Date: Wed, 31 Jul 2024 10:46:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH alsa-lib 2/4] seq: Add API helper functions for creating
 UMP Endpoint and Blocks
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20240619152855.6809-1-tiwai@suse.de>
 <20240619152855.6809-3-tiwai@suse.de>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240619152855.6809-3-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZEBJT72IXA62Q3GXCIQTYNKYZMUPFR7G
X-Message-ID-Hash: ZEBJT72IXA62Q3GXCIQTYNKYZMUPFR7G
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZEBJT72IXA62Q3GXCIQTYNKYZMUPFR7G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/19/2024 5:28 PM, Takashi Iwai wrote:
> For making it easer for applications to create a virtual UMP Endpoint
> and UMP blocks, add two API helper functions.
> 
> snd_seq_create_ump_endpoint() creates (unsurprisingly) a UMP Endpoint,
> based on the given snd_ump_endpoint_info_t information.  The number of
> (max) UMP groups belonging to this Endpoint has to be specified.
> This function sets up the Endpoint info on the sequencer client, and
> creates a MIDI 2.0 UMP port as well as UMP Group ports automatically.
> The name of the sequencer client is updated from the Endpoint name,
> too.
> 
> After creating a UMP Endpoint, create each UMP Block via
> snd_seq_create_ump_block() function with a snd_ump_block_info_t info.
> The associated groups for each block have to be specified there.
> The port names and capability bits are updated accordingly after
> setting each block information.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

...

> +			if (*blknames) {
> +				strlcat(blknames, ", ", sizeof(blknames));
> +				strlcat(blknames, (const char *)bp->name,
> +					sizeof(blknames));

FYI, this seems to introduce build problems on systems that do not have 
strlcpy:

During build:
seqmid.c: In function ‘update_group_ports’:
seqmid.c:672:33: warning: implicit declaration of function ‘strlcat’; 
did you mean ‘strncat’? [-Wimplicit-function-declaration]
   672 |                                 strlcat(blknames, ", ", 
sizeof(blknames));
       |                                 ^~~~~~~
       |                                 strncat

And then during linking:
/usr/bin/ld: seq/.libs/libseq.a(seqmid.o): in function `update_group_ports':
/home/amade/workdir/avs/alsa-lib/src/seq/seqmid.c:672: undefined 
reference to `strlcat'
/usr/bin/ld: /home/amade/workdir/avs/alsa-lib/src/seq/seqmid.c:673: 
undefined reference to `strlcat'
collect2: error: ld returned 1 exit status




