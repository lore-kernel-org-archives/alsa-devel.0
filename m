From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: what is exactly pcm.boundary?
Date: Fri, 6 Jan 2017 12:27:38 -0600
Message-ID: <26cd6dc6-8dc5-d333-5aba-570eae31fef3@linux.intel.com>
References: <CAAu8Fse4GcOV5PkgnWQfBSQjM3SoiEurVuhvuNgQ3zD_8TeHbw@mail.gmail.com>
 <cf5b8891-5d8e-9df1-dbfa-b4471ef32f55@sakamocchi.jp>
 <CAAu8FscDY1R7EG2GsTmV9=JUWGh3K3HEw4RdF-g8NHjzFNYO8w@mail.gmail.com>
 <922adfc9-c436-905a-466e-7fbba239439e@ladisch.de>
 <CAAu8FseE8M-6bynuphCK5HxnpqKzh_Y_bmeHEf6meTTD4bU2eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AA502677FE
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:27:41 +0100 (CET)
In-Reply-To: <CAAu8FseE8M-6bynuphCK5HxnpqKzh_Y_bmeHEf6meTTD4bU2eA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Biehl <rbpoficial@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 1/6/17 10:08 AM, Ricardo Biehl wrote:
> 2017-01-06 6:09 GMT-02:00, Clemens Ladisch <clemens@ladisch.de>:
>>
>> Are you talking about code in your driver (where you are responsible for
>> asking the hardware), or user space code (where you must not directly
>> read hw_ptr)?  What is the actual problem you're trying to solve?
>>
>
> Hello!
> I'm developing a "live microphone system over local network" which are user
> space programs (clients => server) transferring audio nearly real-time
> (human imperceptible latency).
> I need to elaborate a good solution of implementation to have everything working
> as expected -- networking, scheduling, IO management etc -- However I need at
> first make sure I can get control over audio.
>
> I decided to use ioctl() level of communication with ALSA in kernel, and what I
> need is synchronization :-)
> I must know which sample the hardware is currently processing to prevent a lot
> of losses or latency increasing.

I would hate to sound pedantic but sample-accurate control (10us at 
48kHz) is far from trivial. The hw_ptr points to the ring buffer, but 
you may have additional samples queued up in DMA transfers, FIFOS, 
codecs and last some analog delays. On a network-based solution the 
different components typically don't use the same audio clock and you 
will have to deal with drifts between source and sink.
Best of luck.
