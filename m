From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: mapping externally allocated Scatter Gather DMA
 buffers
Date: Tue, 9 Nov 2010 13:51:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 208BD103853
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 13:51:07 +0100 (CET)
In-Reply-To: <AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manu Abraham <abraham.manu@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Nov 2010, Manu Abraham wrote:

> On Tue, Nov 9, 2010 at 5:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Tue, 9 Nov 2010, Manu Abraham wrote:
>>
>>> testbox ~ # arecord -Dhw:2,0
>>> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>
>>> Any idea, why saa7231_hw_params is not getting invoked ?
>>
>> Your hw probably does not support directly 8-bit sample at 8000Hz, one
>> channel. Use 'plughw:2,0' device instead 'hw:2,0' to let alsa-lib do all
>> stream format conversions.
>
> That didn't make any difference at all.

Check your code. You probably created wrong hw_ops, looking to your code:

 	.buffer_bytes_max	= 512 * 4096,
 	.period_bytes_min	= 8192,
 	.period_bytes_max	= 8192,
 	.periods_min		= 8192,
 	.periods_max		= 8192,

It's definitely an empty configuration space.

You have buffer_bytes_max 2097152, but restricted number of periods to 
8192 and period_bytes to 8192.

8192 * 8192 = 67108864 which is not less than 2097152 (and I'm not 
counting the bytes for channels and formats). Bingo, the ALSA PCM 
code does not know what to configure.

Decrease periods_min and probably also periods_max.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
