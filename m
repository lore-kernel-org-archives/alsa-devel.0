From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Audio codec volume control
Date: Thu, 20 Sep 2012 15:38:25 +0530
Message-ID: <505AEB19.7080205@st.com>
References: <505ACC37.3060209@st.com> <505AE8C6.3040001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
 [207.126.144.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 3999D2652B7
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 12:08:34 +0200 (CEST)
In-Reply-To: <505AE8C6.3040001@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Peter

On 9/20/2012 3:28 PM, Peter Ujfalusi wrote:
> On 09/20/2012 10:56 AM, Rajeev kumar wrote:
>> Hello Mark,
>>
>> We have three volume control in audio codec.
>> 1. Master volume: control both left and right channel volume
>> 2. left volume: control left channel vol
>> 3. right volume: control right channel vol.
>>
>> So we can provide interfaces for all volume control to the user. Please
>> find below the control I can provide to the user space
>>
>> case 1:
>> 1. Provide master volume control
>> 2. Provide Left channel volume control.
>> 3. Provide Right channel volume control.
>>
>> case 2:
>>
>> 1. Provide master volume control
>> 2. Instead of providing separate control for left and right channel,
>> combined it and provide a single control to user space. so that left and right
>> volume is always in sync.
>
> case 3:
> 1. Provide master volume control
> 2. stereo volume control for the left/right channel
>

You mean to say
Left and Right should be a single stereo control which can be provided 
with SOC_DOUBLE. Actually case 2 corresponds to the same setting which 
you are suggesting.

But why this is better option?

In case user wants a separate left/right volume control then how this 
setting is going to help.

Best Rgds
~Rajeev
