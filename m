Return-Path: <SRS0=/1nv=PD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D17C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:24:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFD7611C1
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Oct 2021 16:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8FFD7611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5AA21771;
	Fri, 15 Oct 2021 18:23:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5AA21771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634315041;
	bh=sbKMPEHHYLj0QrlyBw7/CkxUe9vtzn/3iWuvuvNWqiQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dcBPvR+rbuzqqZ3hT4VoHOgiq3awIV8ncb2Mx+ocjxHJXsxluyZS8geIG3CxMH9af
	 TQ2A6nvUGTB5k01/WfS4DeQFiwrxNuVcxXmvDYg7cOKLK2MNBnQ2CQrfaU0UqNiX0I
	 rW9saWH+aa5oXlTlgy8tUaaa0P3T/m/i6jv4El1I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1834AF8025B;
	Fri, 15 Oct 2021 18:23:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B94DF80269; Fri, 15 Oct 2021 18:23:09 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E86EF80167
 for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2021 18:23:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E86EF80167
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214879085"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="214879085"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 09:23:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; d="scan'208";a="492623169"
Received: from liminghu-mobl.ccr.corp.intel.com (HELO [10.212.23.213])
 ([10.212.23.213])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2021 09:23:01 -0700
Subject: Re: [RFC PATCH v3 05/13] ASoC: soc-pcm: align BE 'atomicity' with
 that of the FE
To: Takashi Iwai <tiwai@suse.de>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
 <20211013143050.244444-6-pierre-louis.bossart@linux.intel.com>
 <2847a6d1-d97f-4161-c8b6-03672cf6645c@nvidia.com>
 <s5hmtnavisi.wl-tiwai@suse.de>
 <e2a79095-b8ce-9dd4-3e6d-00f8dda99f30@linux.intel.com>
 <s5h1r4muwlj.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8aa4fa07-2b55-3927-f482-c2fd2b01a22e@linux.intel.com>
Date: Fri, 15 Oct 2021 11:22:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5h1r4muwlj.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>,
 vkoul@kernel.org, broonie@kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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


> The FE stream locks are necessary only two points: at adding and
> deleting the BE in the link.  We used dpcm_lock in other places, but
> those are superfluous or would make problem if converted to a FE
> stream lock.

I must be missing a fundamental concept here - possibly a set of concepts...

It is my understanding that the FE-BE connection can be updated
dynamically without any relationship to the usual ALSA steps, e.g. as a
result of a control being changed by a user.

So if you only protect the addition/removal, isn't there a case where
the for_each_dpcm_be() loop would either miss a BE or point to an
invalid one?

In other words, don't we need the *same* lock to be used
a) before changing and
b) walking through the list?

I also don't get what would happen if the dpcm_lock was converted to an
FE stream lock. It works fine in my tests, so if there's limitation I
didn't see it.

>>> In addition, a lock around dpcm_show_state() might be needed to be
>>> replaced with card->pcm_mutex, and we may need to revisit whether all
>>> other paths take card->pcm_mutex.
>>
>> What happens if we show the state while a trigger happens? That's my
>> main concern with using two separate locks (pcm_mutex and FE stream
>> lock) to protect the same list, there are still windows of time where
>> the list is not protected.
> 
> With the proper use of mutex, the list itself is protected.
> If we need to protect the concurrent access to each BE in the show
> method, an additional BE lock is needed in that part.  But that's a
> subtle issue, as the link traversal itself is protected by the mutex.

If I look at your patch2, dpcm_be_disconnect() protects the list removal
with the fe stream lock, but the show state is protected by both the
pcm_mutex and the fe stream lock.

I have not been able to figure out when you need
a) the pcm_mutex only
b) the fe stream lock only
c) both pcm_mutex and fe stream lock

