Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E2EC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 07:04:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C626186A
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 07:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C626186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3539F166C;
	Tue,  2 Mar 2021 08:03:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3539F166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614668655;
	bh=78+rQhfhDtXk08ncbnOI6dDhADsEzqrNs7lCprcmRLU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZijaEJCtRWMTFnDsdKxhLxnOfIHR1r5wJRiFUkL+KwartqokZ2eAkbiVgmlzNJSL1
	 ItDhh+WPnQcIQMKDxF7QnuS9ZgijwPlGCJho/t1bpxaOr+S2EQN0FSVtjDS5ku91jy
	 zlUuCscNrUQkBEhMkUOzgkQ5IHBn3DY80KFs16sM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABF7EF8025B;
	Tue,  2 Mar 2021 08:03:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41ABDF80269; Tue,  2 Mar 2021 08:03:23 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D4EDF8012D
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 08:03:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D4EDF8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="LLRZtTv1"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603de32e0001>; Mon, 01 Mar 2021 23:03:10 -0800
Received: from [10.25.103.152] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 07:03:07 +0000
Subject: Re: [RFC PATCH 3/5] ASoC: audio-graph-card: Add bindings for sysclk
 and pll
To: Rob Herring <robh@kernel.org>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
 <1614276364-13655-4-git-send-email-spujar@nvidia.com>
 <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <0ea5b885-2610-8f12-569d-15a8eff50c10@nvidia.com>
Date: Tue, 2 Mar 2021 12:33:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614668590; bh=mtH3d+wKblfOn6NGGlgdJ6FIympBFVhrzgmGLQmLWbs=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=LLRZtTv1H9RTl+yAYiBhRtJwAxwJ/aDjcHCbLRGLD9/OflQs4B/3Znyi1X+Uoxe9d
 qeBFOdLIBMz6zVF0BCinxrZGh6L5MTdXnzTtILf0n7+xFkU6OyHhGf1rDXevCZ0wDH
 RRi0r2+KGv09ATJ3lwlWt+wup6LDiaPMqNYbt65jnNkupzaxPV39S7+R3DvUeBtROx
 iezCuNx2B36jlT+b3xqncuQgZMuEffxb5yUDntI7+RTOuEzC4oZZlM5zrQ8opkrntH
 I5flCEmPFwZHRpdPbvxpVzjQWMRQPwzCw9j9trFnKMHXb1nVc1nV6otfYBLHdJY+HX
 EXqMjJxKQ8Adw==
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
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



On 3/2/2021 7:40 AM, Rob Herring wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 25, 2021 at 12:06 PM Sameer Pujar <spujar@nvidia.com> wrote:
>> ASoC core provides callbacks snd_soc_dai_set_sysclk() and
>> snd_soc_dai_set_pll() for system clock (sysclk) and pll configurations
>> respectively. Add bindings for flexible sysclk or pll configurations
>> which can be driven from CPU/Codec DAI or endpoint subnode from DT.
>> This in turn helps to avoid hard codings in driver and makes it more
>> generic.
>>
>> Also add system-clock related bindings, "system-clock-direction-out"
>> and "system-clock-frequency", which are already supported.
> This all looks like duplication of what the clock binding can provide.
> We don't need 2 ways to describe clocks in DT.

This was targetted for external audio codecs. Their internal clock 
management is not exposed with the clock framework. Instead ASoC 
provides callbacks to set this up on Codec side. There are many 
references where this is followed with some hardcoded settings in the 
drivers.

Are you suggesting to instead expose codec internal clocks and manage 
via generic clock bindings? Would this mean each codec driver has to 
implement these clock APIs (for ex: set_rate()) and program registers 
accordingly?
For a platform, different audio cards can be plugged in. In that case, 
each codec has to be updated to follow this. Wouldn't it be simpler to 
use available ASoC callbacks?
