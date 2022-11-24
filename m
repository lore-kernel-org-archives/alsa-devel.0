Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596FEC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Nov 2022 09:33:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6630F16DB;
	Thu, 24 Nov 2022 10:32:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6630F16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669282392;
	bh=J0NwZnjrS0O8MoDomCIMQw6ef/tSlF82d6RB1VnCFX8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RgI4Q0wtyCoEBC6sagIyO55QaFNOx+NqtdstCPHjKw04WY36P6j7ubNhGk3eFj4+N
	 XM8w20Zii5+mw/QYUvK75IRIfECrl2s5i4brM4EFBb4M0UMWPMPM9vchrZ6CKioIyQ
	 wkPuRQ61hDRjQAGJFqRHse1aK+6pzDrCk8i7buUs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1412DF80149;
	Thu, 24 Nov 2022 10:32:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2CED2F80115; Thu, 24 Nov 2022 10:32:21 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1EF8F80115
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2022 10:32:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1EF8F80115
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QKn+ulHb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0DEDFB82735;
 Thu, 24 Nov 2022 09:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5E1C433D6;
 Thu, 24 Nov 2022 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669282325;
 bh=J0NwZnjrS0O8MoDomCIMQw6ef/tSlF82d6RB1VnCFX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QKn+ulHbsn84kkDCubdAUf8zD6eWCGO/Gsi60LsOFC1MobLEzGvp9tgjT4aNv9Ffq
 FZUxh/RFl/FbwABMtOTtWB7O/TrspsBd1xdNiu7lmQ8YZwQ13QWImQvVWxcJpkxXfY
 f0MUwP+1amUKzDkSHZG0clEsZhTBYVPTJk8TrYru/Av5F9IylMMtQPZYIfMWuC4xfZ
 XwmSbH/vFzjKr9BxLRHZjIkvNnZbk4Yp5jW57B5EP2It27fzh8jTneILp0/dtiVnAu
 YKToq5UGLrtUgXURLMU6BnqLyN1P8JgGJfvzZniQm9aKmtZP4K8tVL9PNdSuzaMrxW
 bhVN/JjDHcBUA==
Date: Thu, 24 Nov 2022 15:02:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/4] soundwire: Provide build stubs for common functions
Message-ID: <Y386ERSr1EmkTYwk@matsya>
References: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
 <20221121141406.3840561-3-ckeepax@opensource.cirrus.com>
 <Y374VPAQcX6MkG22@matsya>
 <20221124092231.GD105268@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124092231.GD105268@ediswmail.ad.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On 24-11-22, 09:22, Charles Keepax wrote:
> On Thu, Nov 24, 2022 at 10:21:32AM +0530, Vinod Koul wrote:
> > On 21-11-22, 14:14, Charles Keepax wrote:
> > > Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
> > > that are quite likely to be used from common code on devices supporting
> > > multiple control buses.
> > > 
> > > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > > +static inline int sdw_stream_add_slave(struct sdw_slave *slave,
> > > +				       struct sdw_stream_config *stream_config,
> > > +				       struct sdw_port_config *port_config,
> > > +				       unsigned int num_ports,
> > > +				       struct sdw_stream_runtime *stream)
> > > +{
> > > +	return 0;
> > 
> > Should this and other here not return error...? Indicating sdw is not
> > available..? Silently ignoring may not be very helpful in debugging
> > 
> 
> Yeah I was a little unsure which way to go on that, in the end I
> opted for returning zero as it was more likely code would get
> optimised out. But I am happy to switch to returning an error, it
> would as you say making debugging misconfigurations easier.
> -ENOSYS seems kinda reasonable I think.

Right, -ENOSYS seems to be apt here

-- 
~Vinod
