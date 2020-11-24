Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1870C56201
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 14:39:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1130A20715
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 14:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="US2yNys4";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfmYRBxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1130A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7550116AC;
	Tue, 24 Nov 2020 15:38:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7550116AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606228740;
	bh=DZ4t8E4hJBebskLtc50cMLhJTVX4QWJqNwDFEoEsSMI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=US2yNys4Oi7LxPRQ2zXaSKbCM2lOzVjmTjQE7swqVqs9MQo51ZB5jOOvNpYPcZGp2
	 6bpwokBC4WU1ii0FCT6kk+G8C1E1M8WrEAllQr3G/ahpO7M7kRCUFQn08MyNVfWEd2
	 corI0X/rhKFX/3HGCoUrW6a+yEMID/vAsfxEed1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFCF1F80161;
	Tue, 24 Nov 2020 15:38:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 110FAF80165; Tue, 24 Nov 2020 15:38:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53C81F800C1
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 15:38:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53C81F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZfmYRBxI"
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1FF50206E5;
 Tue, 24 Nov 2020 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606228678;
 bh=DZ4t8E4hJBebskLtc50cMLhJTVX4QWJqNwDFEoEsSMI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZfmYRBxI1pkz0ueSh58HJf3wOBec6adp94k1lRsoPysdoAAANWCXvOw6xmvRE+S2F
 1RcMjVZi4I5ucuKY8anVEg4fn8JoX2RltAlBj3K3nIvGs2oggt4n4mEkWX87/+jQwg
 +JEFGCv87pNixl7yxoXpOsxnwJmSdDwaivi/z89M=
Date: Tue, 24 Nov 2020 08:38:14 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 126/141] slimbus: messaging: Fix fall-through warnings
 for Clang
Message-ID: <20201124143814.GG16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
 <794916c9-30fb-1202-ec26-9abf750886dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794916c9-30fb-1202-ec26-9abf750886dc@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
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

On Tue, Nov 24, 2020 at 10:48:04AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 20/11/2020 18:39, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> 
> 
> Applied thanks,

Thank you, Srini.
--
Gustavo
