Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8494C47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:20:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6073161950
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 16:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6073161950
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C670B1706;
	Wed,  2 Jun 2021 18:19:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C670B1706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622650824;
	bh=qvBEcbI198Qvxii8nRg+4vo0FkZmamyVoyqxdECmJf4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IGczOurv2OrMzB+ysAc5xEKTTCkUr/fk2uRvpuhFIfqPyFdVu8WcpC7+sxOSK8CkN
	 VtKeN0vvaGTNNabhyaQGdSRyC4N6rQugQujV4PVOPUB4Jx8eBHgEbnOYW+xDTr4ebL
	 qBv0jZNrGHMqT4DVY3KvJUpH9dcQDtZcZ3MF/+SQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59015F802A9;
	Wed,  2 Jun 2021 18:19:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BDBEF80424; Wed,  2 Jun 2021 18:19:33 +0200 (CEST)
Received: from mail1.bemta23.messagelabs.com (mail1.bemta23.messagelabs.com
 [67.219.246.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15CA3F80273
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 18:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15CA3F80273
Received: from [100.112.6.224] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-3.bemta.az-c.us-east-1.aws.symcld.net id D1/92-36331-F8FA7B06;
 Wed, 02 Jun 2021 16:19:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRWlGSWpSXmKPExsWS8eIhj27f+u0
 JBkvfalpcuXiIyWLqwydsFt+udDBZfOv5xG7x6fwFNosN39cyOrB5bPjcxOaxc9Zddo9NqzrZ
 PNZvucoSwBLFmpmXlF+RwJrxa8c+1oI/PBWbf69jbmDcx9XFyMUhJPCfUWJCw09WCOcRo8TLS
 /1sXYwcHMICyRIPN9p0MXJyiAgoS1z9vpcFpIZZoIdR4tb+tWwQDRMYJfafX8MOUsUmoC2xZc
 svNhCbV8BW4l7TZ1YQm0VARWLXxMWMILaoQLjE7o6XTBA1ghInZz5hAbE5BdwlNlz+wwyymFl
 AU2L9Ln2QMLOAuMStJ/OZIGx5ie1v5zCD2BICihLrrnQxQtgJEj3/HrFNYBSchWTqLIRJs5BM
 moVk0gJGllWMpklFmekZJbmJmTm6hgYGuoaGRrrmuiaWeolVusl6pcW6qYnFJbqGeonlxXrFl
 bnJOSl6eaklmxiBkZNSwG64g3Hxmw96hxglOZiURHk3OW5PEOJLyk+pzEgszogvKs1JLT7EKM
 PBoSTB67EOKCdYlJqeWpGWmQOMYpi0BAePkgjvOZA0b3FBYm5xZjpE6hRjOMebtUsWMXO8BZN
 t9+4CyXYwOXPBwdXMHLPA5P32Q0DyAYgUYsnLz0uVEucNBRknADIuozQPbhksSV1ilJUS5mVk
 YGAQ4ilILcrNLEGVf8UozsGoJMybCTKFJzOvBO6mV0DnMgGdK+C1DeTckkSElFQDU/2mpgb5U
 K/Zj6Y5xO8UKLDLOPlT7e7UQ48jfgtd7XH0/Lhwxd+aX/xP/3BYTrmxcHLN7C6FzktB1lc9nU
 sqHzMw3lZNn6/fPrXYJH3Rn6/nzP6Uf+uYlDsrQW3DpN3NKjPf8lr+ZYk9MJc9+vuD/Ty9T/6
 EHFbeseDIu6pTTz7kF/x/oC38ZEmqp9fC69Memj+MbuT++aRWL3NW2MIrvpv2B/EtTZ7g9rjU
 T/BjQkX/zIqVz3PetZt6Pl/o58600KxgH7PR+f7kFNZc8WCr/k8dezL+cmTk7J60ftOiCPYTM
 hoXl/Yt2WShaVb2keWW8o032WXM/ntf5D/vDnq9f/nUpVUnOVYV7LU0u60eL6fEUpyRaKjFXF
 ScCAAaJOD3zQMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-10.tower-406.messagelabs.com!1622650766!97801!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3653 invoked from network); 2 Jun 2021 16:19:26 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
 by server-10.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 2 Jun 2021 16:19:26 -0000
Received: from reswpmail01.lenovo.com (unknown [10.62.32.20])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by Forcepoint Email with ESMTPS id 725B7D04D375786AB60D;
 Wed,  2 Jun 2021 12:19:26 -0400 (EDT)
Received: from [10.46.208.158] (10.46.208.158) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2; Wed, 2 Jun 2021
 12:19:26 -0400
Subject: Re: [External] Re: [PATCH] ASoC: AMD Renoir - add DMI entry for
 Lenovo 2020 AMD platforms
To: Mark Brown <broonie@kernel.org>
References: <markpearson@lenovo.com>
 <20210531145502.6079-1-markpearson@lenovo.com>
 <162265045454.22459.12647691279142134758.b4-ty@kernel.org>
From: Mark Pearson <markpearson@lenovo.com>
Message-ID: <8d6916ed-af82-e9ff-7728-411a5e2a48eb@lenovo.com>
Date: Wed, 2 Jun 2021 12:19:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <162265045454.22459.12647691279142134758.b4-ty@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.208.158]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail01.lenovo.com (10.62.32.20)
Cc: stable@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Gabriel Craciunescu <nix.or.die@gmail.com>, tiwai@suse.com
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

Hi mark

On 2021-06-02 12:16 p.m., Mark Brown wrote:
> On Mon, 31 May 2021 10:55:02 -0400, Mark Pearson wrote:
>> More laptops identified where the AMD ACP bridge needs to be blocked
>> or the microphone will not work when connected to HDMI.
>>
>> Use DMI to block the microphone PCM device for these platforms.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/1] ASoC: AMD Renoir - add DMI entry for Lenovo 2020 AMD platforms
>       commit: 19a0aa9b04c5ab9a063b6ceaf7211ee7d9a9d24d
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
My apologies - I found out just now that this patch causes problems for
the microphone that I'd missed so need to revert it. I was writing the
email to pull the patch when I got your update :(

Sorry for the confusion and churn - I need to go and work with the
firmware team to solve this one.

Mark
