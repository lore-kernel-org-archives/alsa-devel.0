From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Run-time CODEC reset
Date: Sun, 13 Nov 2011 20:52:37 -0800
Message-ID: <4EC09E95.8080907@codeaurora.org>
References: <4EBF6081.8030907@codeaurora.org>
	<201111130729.05961.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D57D245A8
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 05:52:41 +0100 (CET)
In-Reply-To: <201111130729.05961.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/12/2011 10:29 PM, Marek Vasut wrote:
>> Hi,
>>
>> I have a use case which requires CODEC to be reset at run-time. As
>> application exercises playback/capture through PCM device and mixer, my
>> understanding is that there is no interface for application to reset
>> CODEC through ALSA ASoC framework. CODEC driver would have to build
>> non-standard interface for this purpose. Is there precedence in any of
>> asoc CODEC driver which provides reset interface?
>
> Why not describe the hardware / submit a patch to support the hardware first ?
> Then you can ask the developers for help. You can be helped more if you share
> your problematic code.

Actually, there is no bug. The use case is more to do with self test
mode. After running some audio tests to verify different audio paths
(i.e handset mode), self test application would like to trigger codec 
reset interface to restore CODEC default state. I was told that there 
are already ASOC CODEC drivers offering such interface. I want to see 
how this use case is handled by other CODEC drivers especially if 
command comes during playback/capture.

Thanks
Patrick


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
