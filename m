Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A837EC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:46:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2772070E
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WNB3RCMV";
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCJ0yGy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2772070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95691886;
	Fri, 17 Jul 2020 11:45:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95691886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594979173;
	bh=g+aK3/l71OafSIeamIOofh9CfO/K9CrnDxq4DyCkIyQ=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WNB3RCMVX6IZij5ql3Q5EY39+sf1GOlRMYLjBP3TLHqtn8tSeGjFctq6GO0aa6hZw
	 RYUyatbbiKi5Jv5rOBdpE8QwgWewTvf0qAKLAEt16rMuR/bY5C2LmL6SEffqtE15t+
	 3LZ8JO8r0q0kltSOgIkThvKeNfwhve53BrXUgTig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25112F801D8;
	Fri, 17 Jul 2020 11:45:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01ABAF80217; Fri, 17 Jul 2020 11:45:22 +0200 (CEST)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22CDCF8014E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 11:45:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22CDCF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="DCJ0yGy4"
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06H9bQtY064898;
 Fri, 17 Jul 2020 09:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Tfzshdr+0ctb2W9/zhpfZrMu5nBKn7KtwRVe6P81CFA=;
 b=DCJ0yGy46oUAlhfbWGYwC3Ll4uClRbOg5cBzPGuSBc0c2aCFSoZ2EJmMQK4fVHdHUZPC
 r85QCAvbuVcPry/mBwxsNVSrY23ucSY9D/Up6RIxibFN+5DATgHNZEoUjSMVUhBwCbrc
 uSKSwZ6y2kvjQT8AxY6xDokg5wpXixagARvztX8FQKGnr+VMTVJ3GYbAHr4KVcZpuvVt
 1kRyXK62HL938w+GDyoW0axyRuMd7SRS4uGY+N1gabpW9Vn5T9nXVFnN6e05dI/aL/gP
 8wyQYhMkqkTsNK7iKovZnqB7T8cKadyhMrkUeByvYygys3P6HfkyMlX1q9TXrOU6dRmB Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 3275cmp9e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Jul 2020 09:45:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06H9h2fu150927;
 Fri, 17 Jul 2020 09:43:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 327qbe7du8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jul 2020 09:43:03 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06H9f1it010182;
 Fri, 17 Jul 2020 09:41:02 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 17 Jul 2020 02:41:00 -0700
Date: Fri, 17 Jul 2020 12:40:53 +0300
From: <dan.carpenter@oracle.com>
To: srinivas.kandagatla@linaro.org
Subject: [bug report] ASoC: soc-dai: return proper error for get_sdw_stream()
Message-ID: <20200717094053.GA23150@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=840
 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=3 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=833 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170073
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

The patch 308811a327c3: "ASoC: soc-dai: return proper error for
get_sdw_stream()" from Mar 16, 2020, leads to the following static
checker warning:

	drivers/soundwire/stream.c:1920 sdw_shutdown_stream()
	error: 'sdw_stream' dereferencing possible ERR_PTR()

drivers/soundwire/stream.c
  1902  void sdw_shutdown_stream(void *sdw_substream)
  1903  {
  1904          struct snd_pcm_substream *substream = sdw_substream;
  1905          struct snd_soc_pcm_runtime *rtd = substream->private_data;
  1906          struct sdw_stream_runtime *sdw_stream;
  1907          struct snd_soc_dai *dai;
  1908  
  1909          /* Find stream from first CPU DAI */
  1910          dai = asoc_rtd_to_cpu(rtd, 0);
  1911  
  1912          sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We updated this to return error pointers as well as NULL but forgot to
check the caller.

  1913  
  1914          if (!sdw_stream) {
  1915                  dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
  1916                  return;
  1917          }
  1918  
  1919          /* release memory */
  1920          kfree(sdw_stream->name);
  1921          sdw_release_stream(sdw_stream);
  1922  

regards,
dan carpenter
