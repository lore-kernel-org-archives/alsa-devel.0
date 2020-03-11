Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B2EC10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:21:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E492205C9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LI6zqsBd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ECHIVNCT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rr04A5h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E492205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79B80166B;
	Wed, 11 Mar 2020 04:20:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79B80166B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583896864;
	bh=OejHIdQY7/CvNeiLkwcSXMAkFwVNGm/SlYFjpZCbqWY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LI6zqsBdX1N15kt6psbbynvGqX3X5xAep8A6qw8VK91yQerTjMz7jDDj5aArpUWyL
	 AjDCzk47GRKL5aB/IWkDWItgzMjvlJQuArekelMvPQMpcdaUfF35BvLcJ+fq1LV5zO
	 PzbhFTZ9OKpaRdZpnIGHAxgUfObvE6kuiIPsqvto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60073F8028C;
	Wed, 11 Mar 2020 04:19:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33488F8028D; Wed, 11 Mar 2020 04:19:50 +0100 (CET)
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com
 [64.147.123.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF8B1F8028B
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 04:19:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF8B1F8028B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="ECHIVNCT"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="rr04A5h7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.west.internal (Postfix) with ESMTP id C08D56C5;
 Tue, 10 Mar 2020 23:19:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 10 Mar 2020 23:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=b+Ma1H6/IShcWZqpJAo1sroDdFj
 4Te1+J3eJjPIM5JU=; b=ECHIVNCT6Daf9QX6h78auESsTvlreFKUsOl7YL/deIR
 DSKjlSxqc0pUdQDeWk9m8j0x/fp9VJlYhyjt0nByJumbzTGfu/0Wj3vplgfdTi6M
 4uRr9S1kVxp4FZSRI95dmyGMUbp1QFYVdaEUBasiPg9Hjd3X91tGEvRBxpfKcvtB
 oe8HGZePb7sitte8q9RvjRHSIe5FEbb6QlhOejhRNbDXZRNDPgRw9g53IoPnJC0t
 vs//S60QIOOJyXid7kyy4QOkQdBCg8bYTkzImzN7XLz3wbz3VWP3F54jLS0iekb6
 0O7rV8hwBawPi/wuvfQ8VXHedcSIy1a7Mo9gyfzBhqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=b+Ma1H
 6/IShcWZqpJAo1sroDdFj4Te1+J3eJjPIM5JU=; b=rr04A5h7BMT9Yj65iF6YDE
 ECW6/MTrQ27G7qS9nzLXGSzUhxsev/OnnstAVSVWRkGBZkzJTUNJMhGCMiIbFPa1
 t8oLSlqv9MT5IV1+qyfPZdniPIWxc6DGovX/mRPCIXQbyUySOHfmA9bcItA64CNu
 ZglX+MDj09GgJhS2qTfgmtc6WJY4QCEUrdNSahqFmD2NIujb4iWAUI19B2aiMF4b
 weI+pancvkoiZGslUBJEjf2spiHkfEw2skOlfYswPD6hZq4yCalNey0R31ecO8Pr
 oBZk5Tkj+ZeA/WK+3NRYkNepwOIn1J90G+kr3W3mglvmI/XJpENb6rb6x3mdlxJA
 ==
X-ME-Sender: <xms:z1hoXmytAzEOi46fVw3GFhW_14BvvQR1Y1vWrMnMPUK4DGjvBo2RSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvuddgheekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecukfhppedugedrfedrjeegrdduieeknecuvehluhhsthgvrhfuihiivgepuden
 ucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
 hirdhjph
X-ME-Proxy: <xmx:z1hoXiiUkX573jKbV_tcMGplJyH-eTvnmffAW08TYCowKgGJZ43ZvQ>
 <xmx:z1hoXhO4Jm58TYxyrN5zn6entPRWUgacm00qBpgIiP8xHiW2q59qiQ>
 <xmx:z1hoXgZXzw0UOQ9ISWNUI8F-0ZTWyBlm3ZZ489HaxtrKPs-w7c4QMQ>
 <xmx:z1hoXjgGQP4vx36n0nQxZ9hGyM4-mPXoxwDnyYiOPkxeFxAyk-yhQQOwuNw>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8B70A3060F09;
 Tue, 10 Mar 2020 23:19:40 -0400 (EDT)
Date: Wed, 11 Mar 2020 12:19:38 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jules Irenge <jbi.octave@gmail.com>
Subject: Re: [PATCH 7/8] ALSA: firewire-tascam: Add missing annotation for
 tscm_hwdep_read_queue()
Message-ID: <20200311031937.GB8197@workstation>
Mail-Followup-To: Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Allison Randal <allison@lohutok.net>,
 Thomas Gleixner <tglx@linutronix.de>,
 "moderated list:FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET..."
 <alsa-devel@alsa-project.org>
References: <0/8> <20200311010908.42366-1-jbi.octave@gmail.com>
 <20200311010908.42366-8-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311010908.42366-8-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:FIREWIRE AUDIO DRIVERS and IEC 61883-1/6 PACKET..."
 <alsa-devel@alsa-project.org>, netdev@vger.kernel.org, boqun.feng@gmail.com,
 Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>,
 linux-kernel@vger.kernel.org, Alexios Zavras <alexios.zavras@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bpf@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
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

On Wed, Mar 11, 2020 at 01:09:07AM +0000, Jules Irenge wrote:
> Sparse reports a warning at tscm_hwdep_read_queue()
> 
> warning: context imbalance in tscm_hwdep_read_queue() - unexpected unlock
> 
> The root cause is the missing annotation at tscm_hwdep_read_queue()
> Add the missing __releases(&tscm->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  sound/firewire/tascam/tascam-hwdep.c | 1 +
>  1 file changed, 1 insertion(+)
 
This looks good.

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/tascam/tascam-hwdep.c b/sound/firewire/tascam/tascam-hwdep.c
> index c29a97f6f638..9801e33e7f2a 100644
> --- a/sound/firewire/tascam/tascam-hwdep.c
> +++ b/sound/firewire/tascam/tascam-hwdep.c
> @@ -36,6 +36,7 @@ static long tscm_hwdep_read_locked(struct snd_tscm *tscm, char __user *buf,
>  
>  static long tscm_hwdep_read_queue(struct snd_tscm *tscm, char __user *buf,
>  				  long remained, loff_t *offset)
> +	__releases(&tscm->lock)
>  {
>  	char __user *pos = buf;
>  	unsigned int type = SNDRV_FIREWIRE_EVENT_TASCAM_CONTROL;
> -- 
> 2.24.1


Regards

Takashi Sakamoto
