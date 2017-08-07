From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 08/11] ALSA: vsnd: Add timer for period
 interrupt emulation
Date: Mon, 7 Aug 2017 15:11:49 +0200
Message-ID: <4ce45eec-8657-66c4-c8c7-b851250da46a@ladisch.de>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <1502091796-14413-9-git-send-email-andr2000@gmail.com>
 <ba0dd78b-8853-5cf9-197f-bed3b9f4bdb8@ladisch.de>
 <f2f54b55-3145-2533-c74a-9c3ea803739e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2f54b55-3145-2533-c74a-9c3ea803739e@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Oleksandr Andrushchenko wrote:
> On 08/07/2017 01:27 PM, Clemens Ladisch wrote:
>> You have to implement period interrupts (and the .pointer callback)
>> based on when the samples are actually moved from/to the backend.
>
> Do you think I can implement this in a slightly different way,
> without a timer at all, by updating
> substream->runtime->hw_ptr_base explicitly in the frontend driver?

As far as I am aware, hw_ptr_base is an internal field that drivers
are not supposed to change.

Just use your own variable, and return it from the .pointer callback.

> So, that way, whenever I get an ack/response from the backend that it has
> successfully played the buffer

That response should come after every period.

How does that interface work?  Is it possible to change the period size,
or at least to detect what it is?


Regards,
Clemens
