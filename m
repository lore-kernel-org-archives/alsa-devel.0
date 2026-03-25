Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED3AFEA835
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:55:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 878A9601F7;
	Wed, 25 Mar 2026 09:55:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 878A9601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774428932;
	bh=181LJJSr+VqdA9G5EcHAo2ZcMUdhse3ksWkeV4TVQGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XTU4NSY5/YWU92cnCp4uMy9hBTRHIEf+TBxtoSVrpE07xPtgxaO7mGYWO+OVrrz7b
	 AGjSX1HiZ+eoobSnPwfQrtpqaaNIbwK94itaEhnYdveYtQ0OhY7poYC8svodtml019
	 oBv8QFshsmBXHk+wjbwkhBnmyvbUj0YsVhnh6rIQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6897CF805F3; Wed, 25 Mar 2026 09:54:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 83379F805F4;
	Wed, 25 Mar 2026 09:54:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F1FEF8059F; Wed, 25 Mar 2026 09:54:51 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 43EDCF800AC
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2026 09:54:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43EDCF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=buPyr8S1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DD142600AC;
	Wed, 25 Mar 2026 08:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C70C4CEF7;
	Wed, 25 Mar 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774428883;
	bh=181LJJSr+VqdA9G5EcHAo2ZcMUdhse3ksWkeV4TVQGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buPyr8S19yhDSlTcmQdmSdNCEJlGi+bJ3hbaJsOEoMVVZ3YWq1QYi00ADizZ5B6T0
	 7qwv5Icr73ku8IVLkZ/XtfuNr3oMEwqM33gtC7i8VScSxUToZ6LPbj+4b4LeBRZDPG
	 qLVRmEp92/SfJIeXvFp9JZGyUfMfZsmrPfkM6UNk=
Date: Wed, 25 Mar 2026 09:54:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dima Art <artdima93@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Victus 15-fa2xxx
Message-ID: <2026032514-exes-repave-9420@gregkh>
References: 
 <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
Message-ID-Hash: SU2YI7VLHZQ4YXZH4M3FFKOIEN3TZ6MZ
X-Message-ID-Hash: SU2YI7VLHZQ4YXZH4M3FFKOIEN3TZ6MZ
X-MailFrom: gregkh@linuxfoundation.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SU2YI7VLHZQ4YXZH4M3FFKOIEN3TZ6MZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Mar 24, 2026 at 10:25:03PM +0000, Dima Art wrote:
> The HP Victus 15-fa2xxx (subsystem ID 103c:8dcd) uses two TAS2781
> amplifiers connected via I2C bus at addresses 0x36 and 0x37.
> Without this quirk, the amplifiers remain uninitialized causing
> mono audio output with no bass.
> 
> Tested on HP Victus 15-fa2xxx (HP-VictusbyHPGamingLaptop15_fa2xxx--8DCD)
> with kernel 6.19.0-9-generic on Ubuntu 26.04.
> 
> Signed-off-by: ardima93@gmail.com
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ alc269_fixup_tbl[] @@
> +    SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx",
> ALC245_FIXUP_TAS2781_I2C),
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
