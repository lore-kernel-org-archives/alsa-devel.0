From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [DAPM question] DAPM support for single input
	multiple outputs
Date: Mon, 9 Mar 2015 19:16:18 +0800
Message-ID: <54FD8102.7020503@marvell.com>
References: <54FD5C1D.9030909@marvell.com> <54FD5F9E.3080606@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A2112605C6
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 12:16:22 +0100 (CET)
In-Reply-To: <54FD5F9E.3080606@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 03/09/2015 04:53 PM, Lars-Peter Clausen wrote:
> On 03/09/2015 09:38 AM, Qiao Zhou wrote:
>> Hi Mark,
>>
>> I have one question and need your suggestion. Thanks in advance.
>>
>> In our DSP, one stream path is like this: There is one bit controlling
>> whether a signal A goes to A_out or B_out. That's the reverse case of
>> DAPM_MUX(multiple inputs, single output).
>>
>> One way is to use two switches but it seems not good since two switches
>> control the same bit. It's strange. Do you have any opinion about such
>> requirement support?
>
> There is currently no support for a demux. But it shouldn't be too hard to
> add one in the DAPM core, if you want to take a try at it.
>
> A demux would behave very similar to a mux, except that you'd reverse
> sources and sinks. The only thing that is a bit tricky is that we only have
> one control element per path and currently it always belongs to the sink.
> For a demux it needs to be long to the source. This means you can't have a
> mixer directly connected to the same path as a demux and the core needs to
> make sure that that doesn't happen.
I'll have a try to specially handle demux type. Thanks for the 
suggestions. BTW, is there plan to add demux support?
>
> - Lars
>


-- 

Best Regards
Qiao
