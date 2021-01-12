Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD51C433E9
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:44:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB7B230F9
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB7B230F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACD501698;
	Tue, 12 Jan 2021 14:43:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACD501698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610459046;
	bh=O3ZxclRaHb7UYkW8AhS9xhy3AQ/CuHuZ69TGUrSJ8Y4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dBKFpvgDQl+OIJQlbcvEmux3tPE1ASeq+KED2VImN0BQG8UlRvRs+pq3VkmmjZAM6
	 7ctuG1qU8FlBDkP2m50O7y31qBc6z3IUoyUOA2b9kHBm9XDcp9hVdtJdXEe2Zq2+yB
	 R2PU8wxzw1L5CXX/v3+zw2vvL2BfLYnegY+TVUmI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4083BF80249;
	Tue, 12 Jan 2021 14:43:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AE37F8025E; Tue, 12 Jan 2021 14:43:14 +0100 (CET)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A080CF800EB
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 14:43:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A080CF800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="br3p1BvM"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="e5+aVboH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 7C6D95C01D6;
 Tue, 12 Jan 2021 08:43:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 12 Jan 2021 08:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=4OnyMZBP3xdS7J3G7RqbMtjxsfB
 6houuqw2q1oOqhp0=; b=br3p1BvMwiHbXihsb9loRMpTHYznGsbWZH9N+LJRK3e
 sNwhOhAtUXQyOKYc1kipzgeFCm7qBxinbm0Kplt61uztJSfCcxL0prXkVV3Nydhs
 RXMxbwdGsCcn5mQ6hEM8LWuBGzpU9r/gTfxPeHa+YwcqfH3h0Q8HP5jc3dKrRJM2
 MUMRXZ/B59SyiwEKpyOhHcD+N9gBWMjVKXZ0oR1/sd8+DkScfpPbdMi3PIyGbJTR
 ChVqmaFbk2ULVddIRj0Q5KlVY+S2rV+CBrbvndY2wc5uEI4qHNWsJtjhQgotOBXe
 j/QO0BhVEWFluER2yWiB4Q0+UOifXIMxTXrYoXP4s9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4OnyMZ
 BP3xdS7J3G7RqbMtjxsfB6houuqw2q1oOqhp0=; b=e5+aVboHLxqcQp8O4XeAwM
 rE6GYf1QPxzXwFbjxUkGC83ntFKwJTnLpCJB94bERT2oA5APKfGezCK+XqLUL5Ey
 TnEglBBGpk/I8A1JmfVakGTo0mH2nMKX5LYKgr9Ka/to0Nw96S2XwsNrY/ZkksyT
 6pptJT8Y+mNgt240YBTalQa/0vOr9S+HdrXIWVDXRO4eXTYOFP46V+dKE4ziN0Sj
 kEAv5HM0z0twEB15kN59Ht3zjM8ZMNPTZHt8YB3N7Te4PEPzaUH52oMzL728mFAZ
 p9WB2T7TPOIzxvjXx0aKNkmW/2PlOzNUw8T0x96Jv7jYP/jvJi472k9Vt5yuYNRQ
 ==
X-ME-Sender: <xms:Z6f9XyxuayZujUl-QvEjv_wC1gKH8weyG3JUI84vziYFbNs4NMU5WA>
 <xme:Z6f9X-SMP-EwH9xIo2XR5_p0GCPdyzOx9zo79VkOYXcUVkq5TbvZfPAIHEivT_RKp
 6RN6HayenmQ4LgGuMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddvfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
 ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
 eqnecuggftrfgrthhtvghrnhepjeegieefueevueefieeggeejledvgfejgeffjefgvdek
 leehgfdtfeetjeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepud
 dukedrvdegfedrjeekrdehkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Z6f9X0UtNJIj4lVLcuaXXJwnTpG_WbeSyHIMIzfuhkO5Cis3u6JO4A>
 <xmx:Z6f9X4iwYveNfs5zRUI7c9EZLYTwLq6Ab-DR3UqMWdW409hertBwdg>
 <xmx:Z6f9X0AeQ-mj1F2ZcWScIsN2MDnys6-b-kbmWn2VxvVJQAxeUxayOA>
 <xmx:aKf9X3PD52cGLbqmJNwtG-WACSF4DeNWMLqjK88ELeq6h-VV8S9Q9A>
Received: from workstation (y078058.dynamic.ppp.asahi-net.or.jp
 [118.243.78.58])
 by mail.messagingengine.com (Postfix) with ESMTPA id DE939108005C;
 Tue, 12 Jan 2021 08:43:01 -0500 (EST)
Date: Tue, 12 Jan 2021 22:42:59 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH/RFC 2/2] ALSA: firewire-tascam: Fix integer overflow in
 midi_port_work()
Message-ID: <20210112134259.GA44140@workstation>
Mail-Followup-To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Clemens Ladisch <clemens@ladisch.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210111130251.361335-1-geert+renesas@glider.be>
 <20210111130251.361335-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111130251.361335-3-geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>
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

Hi,

On Mon, Jan 11, 2021 at 02:02:51PM +0100, Geert Uytterhoeven wrote:
> As snd_fw_async_midi_port.consume_bytes is unsigned int, and
> NSEC_PER_SEC is 1000000000L, the second multiplication in
> 
>     port->consume_bytes * 8 * NSEC_PER_SEC / 31250
> 
> always overflows on 32-bit platforms, truncating the result.  Fix this
> by precalculating "NSEC_PER_SEC / 31250", which is an integer constant.
> 
> Note that this assumes port->consume_bytes <= 16777.
> 
> Fixes: 531f471834227d03 ("ALSA: firewire-lib/firewire-tascam: localize async midi port")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> 
> I don't know the maximum transfer length of MIDI, but given it's an old
> standard, I guess it's rather small.  If it is larger than 16777, the
> constant "8" should be replaced by "8ULL", to force 64-bit arithmetic.
> ---
>  sound/firewire/tascam/tascam-transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
 
Indeed. The calculation brings integer overflow of 32 bit storage. Thanks
for your care and proposal of the patch. I agree with the intension of
patch, however I have a nitpicking that the consume_bytes member is
defined as 'int', not 'unsigned int' in your commit comment.

The member has value returned from the call of 'fill_message()'[1] for the
length of byte messages in buffer to process, or for error code. The
error code is checked immediately. The range of value is equal to
or less than 3 when reaching the calculation, thus it should be less than
16777.

Regardless of the type of 'int' or 'unsigned int', this patch can fix
the issued problem. Feel free to add my tag when you post second version
with comment fix.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
> index 90288b4b46379526..a073cece4a7d5e3a 100644
> --- a/sound/firewire/tascam/tascam-transaction.c
> +++ b/sound/firewire/tascam/tascam-transaction.c
> @@ -209,7 +209,7 @@ static void midi_port_work(struct work_struct *work)
>  
>  	/* Set interval to next transaction. */
>  	port->next_ktime = ktime_add_ns(ktime_get(),
> -				port->consume_bytes * 8 * NSEC_PER_SEC / 31250);
> +			port->consume_bytes * 8 * (NSEC_PER_SEC / 31250));
>  
>  	/* Start this transaction. */
>  	port->idling = false;
> -- 
> 2.25.1

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/tascam/tascam-transaction.c#n197

Thanks

Takashi Sakamoto
