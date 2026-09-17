Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08B0C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:52:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 203B1601F0;
	Thu, 17 Sep 2026 11:52:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 203B1601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789638740;
	bh=xw8QTQg+KP8KHzgOiL9d1W8Z3pnvqGgEvEe5gvXC02c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VQg4/GO5p6v0OY7sAaPGtQafTTLIPbI61e8iQktagasIfApBxWssjAS/Kxz+YT5HA
	 pyXdUuzitzfFglWM9V0X9B7GmebXBkC8Ze25AicL53/zlWE+APTliGqshA06IVwfyF
	 eFylk3PWmJmzaSc0GkD0gGVdEgy6haG6arCK2uz0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08D33F805EB; Thu, 17 Sep 2026 11:51:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7423AF80600;
	Thu, 17 Sep 2026 11:51:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D17DF80537; Thu, 17 Sep 2026 11:51:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=182.22.18.210
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789638698;
	b=q3ii67WLwHqb+hSyW3cgxYEXf9uV/18cXdK3hlZS8mM7FjgAXGSDMDUI8E5Ta8uyPHKg
	 DZTgfTcdxkxxarJLwOmcZskQ8+FcfYTDm4Jtax1pIWUCNSt6Zs/Ya1/DTU9VIiHkka28a
	 SWiQ+MGO1i0Rw8YK+DfCy73bxIwTofselMpPe5XrvnIxOHRlbeVY9m6BSTnwJqt9B4eya
	 QCfCKFXixNKU2N7nUTFKIRdrAuvKGZnTHSy8MkPdVegRYe+TImKy1NTPrFi4e08Ds1s0S
	 RBF84DPPOC2nA/1hJf10iiNT1gAY09n4McwUUVUVJvVR5nsxkmRxY3KI1qwwPCrYOoA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789638698;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=xw8QTQg+KP8KHzgOiL9d1W8Z3pnvqGgEvEe5gvXC02c=;
	b=NlvI0kbe1WhIGNF+hzaRWavcKUJP3A3NSz5wdU74rDec0aoEEA9BF9E197XIv9Re9OYU
	 2CG3zJMOeHgnREsmSYemCDrlO98xTuKFYMVKGI5SwQ6/F7tlaDItgTKbD2sEN2ci2ZApU
	 LqmFpy5rHde5c+OntuwTsjSfFH9FHXXQBCs6sui2WtZVxlD3uqzDYOQeu/Q+K4TJ0//aW
	 Wg9Scm+38OyiTCoOz27o7zPpvWUOnpi9vsye7KI912mxT/qRUA+Hrf7ovfgj8baxdGp7g
	 jVN+LN/2Pp4QqxUacsJ8t+zEM5/egzEEHWVj54BUhGC/ecl6qhvMboteeuU6cUB21XA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=SAHK0K8l;
	arc=none smtp.remote-ip=182.22.18.210
Received: from omggw0013-vm0.mail.otm.yahoo.co.jp
 (omggw0013-vm0.mail.otm.yahoo.co.jp [182.22.18.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 87140F8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 11:51:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87140F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=SAHK0K8l
X-YMail-OSG: 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
 Cd1EXp36lxBNZ15rg//wUvJ5pfw==
X-Sonic-MF: seiji_adachi@yahoo.co.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by
 sonicconh6104.mail.ssk.ynwp.yahoo.co.jp with HTTP;
 Thu, 17 Sep 2026 09:51:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789638684;
	s=yahoocojp-202506; d=yahoo.co.jp;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=yYunXypG8ybvRM7Im97Zkt6oUO9NyYy3nqq3uQyEhjM=;
	b=SAHK0K8lAfUwNM5LvMNUtyGuvg10KFzQGhHDbRY1/FcFhSQgm/j93gAj6T3tK5Ui
	316aTSTL0lox5xgmEIjq4+EkfLv1rQTn4cvxnrbqyCbDKoBqWJauggc0w5z1ls9U9i1
	Qau0FMdrYoo6fyIpuBnI7acgIPeuI78cGLq0mFLpkpuFM7zvgcTQICc3sht6P59HyDQ
	RY8RvBXwtQBhm6rp5N6HXInOf3OAHyN05aXSaHd66jQhz6G5BexGjxeSgoZxhr53F/C
	Eggx3UFMyTsLmLPWUo6Fiqh+l5mdft3fWUw/7NBXqNZXeI47b4V3SjQ+woqVSJ4TMHW
	3axvPCAoEg==
Received: by smtphe6004.mail.ssk.ynwp.yahoo.co.jp (YJ Hermes SMTP Server) with
 ESMTPA ID 21d850ee35a89be4551df81a82ad8df6;
          Thu, 17 Sep 2026 18:51:26 +0900 (JST)
Date: Thu, 17 Sep 2026 18:51:24 +0900
From: Seiji Adachi <seiji_adachi@yahoo.co.jp>
To: Vijendar.Mukunda@amd.com, broonie@kernel.org
Cc: venkataprasad.potturu@amd.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Seiji Adachi <seiji_adachi@yahoo.co.jp>
Subject: [RESEND PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN)
 to quirks
Message-ID: <aqu4HOCmdCUs_unm@adriana>
References: <almeAbvirJwQ5doF.ref@adriana>
 <almeAbvirJwQ5doF@adriana>
 <alnKI3bPaZUc6uwB@adriana>
 <aoukqUoiIzcctf-k@adriana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoukqUoiIzcctf-k@adriana>
Message-ID-Hash: EOEMJDNH3EM7SCJSVRYOH4XPWCI476OG
X-Message-ID-Hash: EOEMJDNH3EM7SCJSVRYOH4XPWCI476OG
X-MailFrom: seiji_adachi@yahoo.co.jp
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EOEMJDNH3EM7SCJSVRYOH4XPWCI476OG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I am resending this request along with the code change (diff) required for 
Lenovo ThinkPad E16 Gen 2 (21JN).

Could you please review and consider applying the following patch to 
sound/soc/amd/yc/acp6x-mach.c?

Thanks,
Seiji

---
Subject: [PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks

Add ThinkPad E16 Gen 2 (21JN) to the DMI table in acp6x-mach.c
to enable the internal digital microphone (DMIC).

Signed-off-by: Seiji Adachi <seiji_adachi@yahoo.co.jp>
---
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 385fede6d..ea173bdab 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 						 DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 				 }
 		 },
+		{
+				.driver_data = &acp6x_card,
+				.matches = {
+						DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+						DMI_MATCH(DMI_PRODUCT_NAME, "21JN"),
+				}
+		},
 		 {
 				 .driver_data = &acp6x_card,
 				 .matches = {
---


On Mon, Aug 24, 2026 at 10:55:53AM +0900, Seiji Adachi wrote:
> Hi,
> 
> I am writing to provide an update regarding the internal microphone issue on Lenovo ThinkPad E16 Gen 2 (21JN-003SCD).
> 
> I have recently updated the kernel to version 7.1.8+deb13-amd64 (Debian trixie-backports), but the internal digital microphone (DMIC) is still not recognized.
> 
> Output of `arecord -l` on kernel 7.1.8:
> **** List of CAPTURE Hardware Devices ****
> card 1: Generic_1 [HD-Audio Generic], device 0: CX11880 Analog [CX11880 Analog]
>   Subdevices: 0/1
>   Subdevice #0: subdevice #0
> 
> Could you please check if the DMI entry for 21JN can be added to sound/soc/amd/yc/acp6x-mach.c?
> 
> Thank you for your help.
> 
> Best regards,
> Seiji
> 
> 
> On Fri, Jul 17, 2026 at 02:22:27PM +0800, Seiji Adachi wrote:
> > Hi,
> > 
> > An update on this: I have just upgraded my system kernel to the latest available version, 7.0.13. 
> > 
> > However, the internal digital microphone (DMIC) is still not detected (`arecord -l` shows the same result as before). 
> > 
> > So the quirk entry for "21JN" is definitely still needed in the latest kernel version.
> > 
> > Best regards,
> > 
> > Seiji
> > 
> > On Fri, Jul 17, 2026 at 11:17:58AM +0800, Seiji Adachi wrote:
> > > Hi,
> > > 
> > > I have a Lenovo ThinkPad E16 Gen 2 (AMD Ryzen 7 7735HS) with machine type "21JN".
> > > Currently, the internal digital microphone (DMIC) is not detected on Debian 13 (kernel 6.18).
> > > 
> > > Similar to the "21M5" model, this "21JN" model also requires a DMI quirk entry to enable the internal microphone.
> > > 
> > > Could you please add the "21JN" model to the quirk list in `sound/soc/amd/yc/acp6x-mach.c`?
> > > 
> > > DMI info:
> > > - Vendor: LENOVO
> > > - Product Name: 21JN
> > > 
> > > Thank you,
> > > 
> > > Seiji Adachi
