From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: Declaring HDMI channel allocation to kernel
Date: Tue, 24 Jul 2012 22:10:30 -0500
Message-ID: <500F63A6.30704@ti.com>
References: <500D5D3D.2060108@gmail.com> <500DA87A.8080901@linux.intel.com>
 <500E9565.2040102@gmail.com> <500EDECF.5000902@ti.com>
 <CAPbw_hwmTGaTk0Yze=+x6njj0Kjb8OeBW-UOTstK=COayXgj0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 976C0265289
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 05:11:31 +0200 (CEST)
In-Reply-To: <CAPbw_hwmTGaTk0Yze=+x6njj0Kjb8OeBW-UOTstK=COayXgj0Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Gabriel Beddingfield <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Gabriel,
On 07/24/2012 01:55 PM, Gabriel Beddingfield wrote:
> Thanks, Ricardo.
>
> Is this just re-arranging the chanels in-place?  I'm not sure that's
> what I need.  In this case, I'm needing to be able to differentiate
> between "quad" (FL, FR, RL, RR) and "surround" (FL, FR, FC, RC) in
> order to support both.

Perhaps you could create two different devices, one for surround and 
another for quad, each having its own static reroute table. You would 
use the appropriate device for each specific use case.

Ricardo
>
> -gabriel
>
> On Tue, Jul 24, 2012 at 12:43 PM, Ricardo Neri <ricardo.neri@ti.com> wrote:
>> Hi Gabriel,
>>
>>
>> On 07/24/2012 07:30 AM, Gabriel M. Beddingfield wrote:
>>>
>>> On 07/23/2012 02:39 PM, Pierre-Louis Bossart wrote:
>>>>
>>>> On 7/23/2012 9:18 AM, Gabriel M. Beddingfield wrote:
>>>>>
>>>>>
>>>>> Is there an established way for me (from userspace) to pass the HDMI
>>>>> Channel Allocation (1 byte) to the driver?  If not, can you recommend
>>>>> an approach?
>>>
>>> [snip[
>>>>
>>>> I believe this is one of the topics that will be presented by Takashi at
>>>> LPC, we need the ability to specify a arbitrary sink-specific channel
>>>> mapping.
>>>
>>>
>>> OK, thanks!  So then, to do this today I need to add my own special sauce.
>>
>>
>> FWIW, in the past I could use the route plugin to achieve arbitrary channel
>> mapping. This was done by SW, though. The details are here:
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-April/051573.html
>>
>> Ricardo
>>>
>>>
>>> -gabriel
>>>
>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
