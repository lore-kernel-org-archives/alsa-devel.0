Return-Path: <SRS0=flyq=3Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BCC33CA1
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:27:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D882082E
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JEgWvX//";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="KtyhZ7zN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gkHlwjji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D882082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C16E1616;
	Wed,  5 Feb 2020 11:26:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C16E1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580898418;
	bh=OEFcSuKn7KK4eqv4L8K6GIrNQuOgLGOOCv2bgGyHg9U=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEgWvX//SMY8sq2XvYVMezzwtKBTT3P1KouQnT7HL5u9I1FEznp+3htwE9PDppgwG
	 TGWzXFag3yP3xB8eI3gBPkQIeSmjAOpf5v2LlsbA+6s1Io0G53hK7pyxDz3icosLtr
	 FdOndi0pl0dw6z+ETrMFgrf2HRU7v36wtXe7EYRc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF9F9F80142;
	Wed,  5 Feb 2020 11:26:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61078F8014C; Wed,  5 Feb 2020 11:26:05 +0100 (CET)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F24CF80142
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2020 11:25:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F24CF80142
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="KtyhZ7zN"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="gkHlwjji"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 891C1630;
 Wed,  5 Feb 2020 05:25:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 05 Feb 2020 05:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=TFUOaIZEhkqHuP5FAVzWqFDTX85
 LZtIeeeFu/BXHUos=; b=KtyhZ7zN1PtyeNrBxWbJdKLt1riizM6IUnb/u1gcpUp
 1slgsXr/fbg9DtWTezu8ksIm2IRmId9z7aDBZsdLYq5jtBjBXvl5nRcazdGBXmAJ
 UIY3vDvJI4n7m18XEWBXLorg6JRvpS1sQif5Fumos9w+f/Cd2pnmYfQplaj4kOuZ
 X8mIkMunzDEMypL6iL7B2TxX+/VHT12j5wwgf3tvyWYBZcsjBvlyA+lST+9C41PE
 KqLiIP+k7MK58rGCkA1k7Jk42JS1gfB5TZxB9mvV/qf2wN+/u6GlbTY+r+tvqalR
 VZr3mMGW9hYJR3FfzkZ2hnTR/qYtX4A0inx7RnO4L1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=TFUOaI
 ZEhkqHuP5FAVzWqFDTX85LZtIeeeFu/BXHUos=; b=gkHlwjjiketEd5RwFYQEDm
 Y7EbW/OwBw476XLo1cjzGl4NsR6+IVUeRPE3nGff952cfU/o+NgCtoMN304OFeTx
 inhDndCV9Q2IWqUya5ucuCf7fynXJuQTgOpJe9irMHZ8NO1WrUVw9NLrQbpV51V8
 10YvLTKfWphDcpP5hRGz40ysyNYJhgPyhGAk1wkMIATsVQA06X5ICaasEQNuWfz5
 QrIpMDeBKdMtq3qmecbCQY795KQF9rgnsxBK/qhH2FvzaF+MM41SaWFa2NQyTZkK
 DhyQ5hPR8A9AsfCexpBaq8eW9Rm7x9FcPqTRPLIFDBscLBihpsBHbdLgQRnZQv0A
 ==
X-ME-Sender: <xms:NJg6XhPvzC3Uh3qE3o5v5zfLhR_7yBnuM_Oh7SdPuvVGRvhR3ViOHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrhedugddugecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucffohhmrghinheprghlshgrqdhprhhojhgvtghtrdhorhhgnecukfhppedugedr
 fedrjeegrdduieeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:NZg6XgTKO0BJ244U6df-8NadA4umb1yX1g6_q_0LLUWjaNFNIMYAuQ>
 <xmx:NZg6XjClo9NGjd88EZXTAQpyTDe_nrRLFVjSKrf6PwNeeeX1sTBWbQ>
 <xmx:NZg6XvgU6uPY4WCGg9nCQ4-kN1KnVwaVUfta_RttihlP-tvPpOqqnA>
 <xmx:NZg6XiDfCgSUPjx6QKucorkYXG8VuOritf-pTsQTAafmpzpGqXq0zw>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2723E3280059;
 Wed,  5 Feb 2020 05:25:55 -0500 (EST)
Date: Wed, 5 Feb 2020 19:25:53 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Michael Forney <mforney@mforney.org>
Message-ID: <20200205102553.GD9810@workstation>
Mail-Followup-To: Michael Forney <mforney@mforney.org>,
 alsa-devel@alsa-project.org
References: <20200205081221.18665-1-mforney@mforney.org>
 <20200205081221.18665-4-mforney@mforney.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200205081221.18665-4-mforney@mforney.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH alsa-utils 4/4] Avoid empty initializer list
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Feb 05, 2020 at 12:12:21AM -0800, Michael Forney wrote:
> To zero-initialize an object, use `{0}` instead.
> 
> Signed-off-by: Michael Forney <mforney@mforney.org>
> ---
>  alsamixer/cli.c             | 2 +-
>  amidi/amidi.c               | 2 +-
>  seq/aplaymidi/aplaymidi.c   | 2 +-
>  seq/aplaymidi/arecordmidi.c | 2 +-
>  seq/aseqdump/aseqdump.c     | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
 
Good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I think it better for you to generate cover-letter (--cover-letter
option for git-send-email) when posting a batch of patches.

> diff --git a/alsamixer/cli.c b/alsamixer/cli.c
> index 3f8f52f..7468325 100644
> --- a/alsamixer/cli.c
> +++ b/alsamixer/cli.c
> @@ -58,7 +58,7 @@ static void parse_options(int argc, char *argv[])
>  		{ .name = "view", .has_arg = 1, .val = 'V' },
>  		{ .name = "no-color", .val = 'g' },
>  		{ .name = "abstraction", .has_arg = 1, .val = 'a' },
> -		{ }
> +		{ 0 }
>  	};
>  	int option;
>  	int card_index;
> diff --git a/amidi/amidi.c b/amidi/amidi.c
> index c6268e4..cde4697 100644
> --- a/amidi/amidi.c
> +++ b/amidi/amidi.c
> @@ -469,7 +469,7 @@ int main(int argc, char *argv[])
>  		{"active-sensing", 0, NULL, 'a'},
>  		{"clock", 0, NULL, 'c'},
>  		{"sysex-interval", 1, NULL, 'i'},
> -		{ }
> +		{0}
>  	};
>  	int c, err, ok = 0;
>  	int ignore_active_sensing = 1;
> diff --git a/seq/aplaymidi/aplaymidi.c b/seq/aplaymidi/aplaymidi.c
> index b086e70..e8491e1 100644
> --- a/seq/aplaymidi/aplaymidi.c
> +++ b/seq/aplaymidi/aplaymidi.c
> @@ -869,7 +869,7 @@ int main(int argc, char *argv[])
>  		{"list", 0, NULL, 'l'},
>  		{"port", 1, NULL, 'p'},
>  		{"delay", 1, NULL, 'd'},
> -		{}
> +		{0}
>  	};
>  	int c;
>  	int do_list = 0;
> diff --git a/seq/aplaymidi/arecordmidi.c b/seq/aplaymidi/arecordmidi.c
> index 604cd0d..2034df7 100644
> --- a/seq/aplaymidi/arecordmidi.c
> +++ b/seq/aplaymidi/arecordmidi.c
> @@ -740,7 +740,7 @@ int main(int argc, char *argv[])
>  		{"metronome", 1, NULL, 'm'},
>  		{"timesig", 1, NULL, 'i'},
>  		{"num-events", 1, NULL, 'n'},
> -		{ }
> +		{0}
>  	};
>  
>  	char *filename = NULL;
> diff --git a/seq/aseqdump/aseqdump.c b/seq/aseqdump/aseqdump.c
> index 578e06f..44ae3bb 100644
> --- a/seq/aseqdump/aseqdump.c
> +++ b/seq/aseqdump/aseqdump.c
> @@ -357,7 +357,7 @@ int main(int argc, char *argv[])
>  		{"version", 0, NULL, 'V'},
>  		{"list", 0, NULL, 'l'},
>  		{"port", 1, NULL, 'p'},
> -		{ }
> +		{0}
>  	};
>  
>  	int do_list = 0;
> -- 
> 2.25.0
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
