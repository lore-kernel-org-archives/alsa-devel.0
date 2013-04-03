From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Handle large period size end-of-stream situation
Date: Wed, 03 Apr 2013 15:22:51 -0700
Message-ID: <515CABBB.3070509@codeaurora.org>
References: <515C459A.5070209@codeaurora.org> <515C5D7E.6000609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 2513E260321
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 00:23:07 +0200 (CEST)
In-Reply-To: <515C5D7E.6000609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 4/3/2013 9:49 AM, Clemens Ladisch wrote:
> Patrick Lai wrote:
>> Data is transferred in chunk equal to period size.
>
> Data is transferred in whatever chunk size the hardware uses.
>
> The period size specifies when the hardware raises an interrupt.
> If some application is blocking, this interrupt is the only mechanism
> by which userspace is woken up.
>
>> At the end of playback, there may not be enough audio data left in the
>> music stream to fill entire period. If remaining audio data only takes
>> up very small chunk of period, playback takes longer to stop. Given
>> that period size I have to deal with is quite large, this problem is
>> observed easily. If my understanding is correct, what is the standard/
>> recommended way of handling end of stream case?
>
> I guess you wouldn't ask if your hardware supported smaller periods? ;-)

The hardware can accept smaller period but smaller period would result
in more frequent interrupt to application processor. This leads to
higher power consumption.

>
> Use non-blocking writes, and use some other timer to wait for the actual
> data to be played.  (But if the hardware cannot report the current
> playback position accurately, ALSA won't notice that the playback has
> reached the end.)

My concern is not about blocking too long but audio playback ending 
longer than necessary. If I understand correctly, you are suggesting 
that application, once done transferring residual data, set up timer 
according to expected duration of residual data. Upon waking up from 
timer, call ALSA library API to get the current hardware pointer.
Is my understanding correct?

>
>
> Regards,
> Clemens
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
