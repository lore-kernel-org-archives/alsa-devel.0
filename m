Return-Path: <SRS0=HRrq=LM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD55C48BDF
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 09:18:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130C8613B4
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 09:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130C8613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C3E41686;
	Fri, 18 Jun 2021 11:17:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C3E41686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624007896;
	bh=+6YROVLmsQEImrRJZauNOrwwfwLrqH9UYUkj7qYQxdc=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eBcpM9pK33X+d3LOmBXi7Ck9qMTHQScclVjIl04/xLoLYoTCqWe7w0slmPrJnvDqK
	 b4FOn4SKCDOT+4K1jHzhsC25kfhZ4H1PGJJIVWF6Lu67+Exj7L28VRao6hw510JN9f
	 /pMUzOp4IHVst+N/aIMbLsmtrSQ38ToOT1WT12mc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A45EBF802E8;
	Fri, 18 Jun 2021 11:17:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACD05F8032D; Fri, 18 Jun 2021 11:17:23 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F065F80084
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 11:17:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F065F80084
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="iL3hncc9"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15I9Bj24010506; Fri, 18 Jun 2021 09:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=WD+/EmQvcBf27Rwf8ptwYMAsvMh6Al8V5cD5IJ2JT+8=;
 b=iL3hncc941WS7Bjn8WfxeyqZO0tYzuAgx1732AUzdP2D4y3icHzTydbi08NrpMCB2OBu
 dXzR/AFYYStqcN6wdzNFNwGJS83O4t6WhgWZZMmeVQ/GXzNOUW6cLGPtdyiWXYGYqkF2
 lNApDPJpXkYOPPB5fPpPV6Z9rYwamOmat/QFXIujT0nXFxH48N3UmXLTq6T2vGbtGilZ
 ceBCsuUQKgpU6208WbnR3P9ofKrYRu79AFsjPcINh9irPCIR6Usv/qUaMUsMppOpKVFR
 SepPCB3SFblXsK4G+uXR3zsD0/QBh5/FDPVBhsCywGpKBV3kBS0grN0XRO+Atk9yCEgb Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 39893qsgc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 09:17:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15I9FbT7177366;
 Fri, 18 Jun 2021 09:17:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3020.oracle.com with ESMTP id 396waynray-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 09:17:13 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15I9HDow180324;
 Fri, 18 Jun 2021 09:17:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 396waynrag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jun 2021 09:17:13 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15I9H9uq030940;
 Fri, 18 Jun 2021 09:17:12 GMT
Received: from mwanda (/102.222.70.252)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 18 Jun 2021 02:17:08 -0700
Date: Fri, 18 Jun 2021 12:17:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: srinivas.kandagatla@linaro.org
Subject: [bug report] ASoC: codecs: wcd938x: add capture dapm widgets
Message-ID: <YMxkjxBO3sQpq5rY@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: 4iAbBaqmDK4MOkXwEph09P8LdidPM8FJ
X-Proofpoint-GUID: 4iAbBaqmDK4MOkXwEph09P8LdidPM8FJ
Cc: alsa-devel@alsa-project.org
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

Hello Srinivas Kandagatla,

The patch d5add08fcbce: "ASoC: codecs: wcd938x: add capture dapm
widgets" from Jun 9, 2021, leads to the following static checker
warning:

	sound/soc/codecs/wcd938x.c:2189 wcd938x_tx_channel_config()
	error: uninitialized symbol 'reg'.

sound/soc/codecs/wcd938x.c
  2165  static void wcd938x_tx_channel_config(struct snd_soc_component *component,
  2166                                       int channel, int mode)
  2167  {
  2168          int reg, mask;
  2169  
  2170          switch (channel) {
  2171          case 0:
  2172                  reg = WCD938X_ANA_TX_CH2;
  2173                  mask = WCD938X_HPF1_INIT_MASK;
  2174                  break;
  2175          case 1:
  2176                  reg = WCD938X_ANA_TX_CH2;
  2177                  mask = WCD938X_HPF2_INIT_MASK;
  2178                  break;
  2179          case 2:
  2180                  reg = WCD938X_ANA_TX_CH4;
  2181                  mask = WCD938X_HPF3_INIT_MASK;
  2182                  break;
  2183          case 3:
  2184                  reg = WCD938X_ANA_TX_CH4;
  2185                  mask = WCD938X_HPF4_INIT_MASK;
  2186                  break;

We could add a default case?

default:
	return;

  2187          }
  2188  
  2189          snd_soc_component_write_field(component, reg, mask, mode);
  2190  }


regards,
dan carpenter
