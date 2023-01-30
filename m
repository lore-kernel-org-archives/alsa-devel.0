Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFFBC54EAA
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Jan 2023 09:28:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DCEF846;
	Mon, 30 Jan 2023 10:27:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DCEF846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675070929;
	bh=L6DQkAcPvIKi+T4eGspMMolrBK+1nrGGRuHqkmC162U=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nI962AV+RPXVqif3EaFgxS2er6UlKqWxod5dcaNj3RxPdZo3a9HYKuIs3efzDEZia
	 3HqfUafLo7En1oZ29IQeqc7gDPv0cN/s85JOoW/7NBVcz+SVZWK5qvbuVDqfLxOLJ9
	 N2p5Dl0bDJWoEonuuU6NuuIZ80OdXhy3zSkhp3Xg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D44FAF80236;
	Mon, 30 Jan 2023 10:27:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC336F8032B; Mon, 30 Jan 2023 10:27:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E829AF800A7
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2023 10:27:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E829AF800A7
Authentication-Results: alsa1.perex.cz; dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=kdbA+rmU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E7F45B80E50;
 Mon, 30 Jan 2023 09:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BCC433EF;
 Mon, 30 Jan 2023 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1675070871;
 bh=L6DQkAcPvIKi+T4eGspMMolrBK+1nrGGRuHqkmC162U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kdbA+rmUpGxEMKET78aKHH01Iq9x5xjEDMJgNaY4Dt+iL54lpORmj/9a8H28uJjI5
 dwKmBABgkEwgxmmZW70yuBrtVzVvGcLc3ByoXR2nBwBqSS1UC8qjMjlp0dOLhuUBlZ
 eYREFAHN5Iot6xilhKAZKD9QLqtBND1vMzfazX8o=
Date: Mon, 30 Jan 2023 10:27:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhou Furong <furong.zhou@linux.intel.com>
Subject: Re: [RFC PATCH v2 07/22] ASoC: Add SOC USB APIs for adding an USB
 backend
Message-ID: <Y9eNlKNRqsar4GDb@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-8-quic_wcheng@quicinc.com>
 <Y9UiiMbJFjkzyEol@kroah.com>
 <7c1d80b6-5db3-9955-0a67-908455bd77fa@linux.intel.com>
 <Y9YbumlV9qh+k68h@kroah.com>
 <7f461661-2dcf-056d-f78a-93c409388f29@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f461661-2dcf-056d-f78a-93c409388f29@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org, bgoswami@quicinc.com, mathias.nyman@intel.com,
 Thinh.Nguyen@synopsys.com, andersson@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, agross@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
 quic_plai@quicinc.com, Wesley Cheng <quic_wcheng@quicinc.com>,
 linux-kernel@vger.kernel.org, quic_jackp@quicinc.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Jan 30, 2023 at 04:34:58PM +0800, Zhou Furong wrote:
> 
> 
> On 2023/1/29 15:09, Greg KH wrote:
> > On Sun, Jan 29, 2023 at 02:54:43PM +0800, Zhou Furong wrote:
> > > 
> > > 
> > > > > +void *snd_soc_usb_get_priv_data(struct device *usbdev)
> > > > > +{
> > > > > +	struct snd_soc_usb *ctx;
> > > > > +
> > > > > +	if (!usbdev)
> > > > > +		return NULL;
> > > > 
> > > > How could usbdev ever be NULL?
> > > The method is exported to public, valid check should be reasonable
> > > as someone may call it by mistake
> > 
> > We do not protect the kernel from itself like this, no need to check
> > things that should never happen.  If the caller gets it wrong, their
> > code will break :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> Thank you Greg!
> 
> This has been confused me for long time when I found Linux kernel don't
> check input even for public method.

That is because we control all callers of internal kernel apis,
otherwise we would have nothing but checks all over the place that did
nothing in the end.

thanks,

greg k-h
