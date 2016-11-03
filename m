From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Difference between boundary and buffer_size
Date: Thu, 3 Nov 2016 23:56:06 +0100
Message-ID: <e0c27dac-e27d-e3cb-12da-611f19b01272@metafoo.de>
References: <581AFF28.5060500@IEE.org>
 <4ed8e3d2-0597-e41c-ea49-91dd9a361ffa@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id CE6F9266B8C
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2016 23:56:10 +0100 (CET)
In-Reply-To: <4ed8e3d2-0597-e41c-ea49-91dd9a361ffa@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <Alan.Young@IEE.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/03/2016 05:45 PM, Lars-Peter Clausen wrote:
> On 11/03/2016 10:11 AM, Alan Young wrote:
>> The code in the kernel, in /pcm_lib.c/ and /pcm_native.c/, uses fields
>> buffer_size and boundary in struct snd_pcm_runtime. As far as I can see,
>> there are always initialized to the same value. In what circumstance might
>> they be different? There is clearly some relationship to hw_ptr_base, as
>> illustrated by this repeated snipped from snd_pcm_update_hw_ptr0()
>>
>>         hw_base += runtime->buffer_size;
>>         if (hw_base >= runtime->boundary) {
>>             hw_base = 0;
>>             crossed_boundary++;
>>         }
>>         new_hw_ptr = hw_base + pos;
> 
> boundary is actually set to the largest possible power-of-two multiple of
> buffer_size. This is done so that the hw_ptr that is reported to userspace
> is continuously increasing (up to boundary) and does not wrap around after
> just one buffer_size has elapsed. This is done so you can measure the
> distance between two hw_ptr that were captured at different points in time,
> but are more than half a buffer_size away from each other.

And the pointer that is reported to userspace is called appl_ptr, sorry for
the confusion.
