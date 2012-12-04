From: Cyril GERMAINE <c.germaine@elno.fr>
Subject: Re: Support request for codec WM8731 porting
Date: Tue, 4 Dec 2012 14:54:51 +0100
Message-ID: <50BE00AB.50509@elno.fr>
References: <50B8E1AB.6000006@elno.fr> <50B8EA28.5060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id A8796264F09
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 14:55:08 +0100 (CET)
Received: from mail152-co9 (localhost [127.0.0.1])	by
 mail152-co9-R.bigfish.com (Postfix) with ESMTP id 3556F18012A	for
 <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 13:55:07 +0000 (UTC)
Received: from CO9EHSMHS018.bigfish.com (unknown [10.236.132.253])	by
 mail152-co9.bigfish.com (Postfix) with ESMTP id 8D35E200058	for
 <alsa-devel@alsa-project.org>; Tue,  4 Dec 2012 13:55:05 +0000 (UTC)
In-Reply-To: <50B8EA28.5060208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you Daniel for your reply.

I found out what was the problem.

I was trying to use the WM8731 in I2S mode (porting from another board), 
but davinci CPU doesn't support true I2S. Switching to DSP mode resolved 
my problems.

Cyril

On 30/11/2012 18:17, Daniel Mack wrote:
> On 30.11.2012 17:41, Cyril GERMAINE wrote:
>> Hello,
>>
>> I work on a board based from DM365EVM baseboard, but with the WM8731
>> codec instead of the TLV320AIC3x.
>> I tried with several linux kernels (one is the 3.6.6 release). Now the
>> playback works but not the capture, and I'm not able to debug this
>> issue. I have many "0" frames in the captured data, although data and
>> rate on I2S bus is OK.
> Do you see the audio gaps in I2S as well? This is the first thing to
> investigate on, because if they aren't, your problem is unrelated to the
> Codec.
>
> What are the differences between your board and the DM365EVM regarding
> the SoC and the clocks ratios? Does the DM365EVM work with 3.6.6? How do
> your board support files and ASoC machine driver differ?
>
> Too many open questions here that need to be addressed.
>
>
> Daniel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
