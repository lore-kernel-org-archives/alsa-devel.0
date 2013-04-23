From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
Date: Tue, 23 Apr 2013 10:47:44 +0200
Message-ID: <51764AB0.7020301__25522.8771632121$1366706890$gmane$org@ladisch.de>
References: <Pine.LNX.4.44L0.1304221126200.1388-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <Pine.LNX.4.44L0.1304221126200.1388-100000@iolanthe.rowland.org>
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
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, Joe Rayhawk <jrayhawk@fairlystable.org>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Alan Stern wrote:
> On Fri, 19 Apr 2013, Joe Rayhawk wrote:
>> On Fri, Apr 19, 2013 at 02:18:24PM -0400, Alan Stern wrote:
>>> On Fri, 19 Apr 2013, Clemens Ladisch wrote:
>>>> Alan Stern wrote:
>>>>> +		next = uhci->frame_number + 2;
>>>>>
>>>>> That 2 is the minimum latency, in frames (one frame per ms).
>>>>
>>>> One frame worked fine with the old driver.  What is the reason for
>>>> this regression?
>>>
>>> Perhaps that was a mistake.  Joe, you can try changing the 2 above to a
>>> 1 to see if it fixes the problem.
>>
>> Hey, that worked great! Audio's coming through continuously, now.
>
> This change could be added to the driver, but I would prefer not to.

Why do you think it is necessary to have a minimum latency of 2 ms?

Again, the old algorithm worked fine.  While such short queues are not
used by default, they are necessary to get low latencies for real-time
audio applications.  Keeping this change would keep this regression for
quite a few people.

> In any case, it would be best

What criteria are you using to evaluate the benefit of this?  Do you
want to reduce the chance of queue underruns?  Interrupts?  Power usage?

> if the usb-audio driver were changed to keep the pipeline length at
> least 2 ms at all times.

Why is having a queue of two URB with one packet each suddenly not
allowed?


Regards,
Clemens
