From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [LKML] Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 16:11:52 -0600
Message-ID: <r2n51f3faa71004091511y936975en874a02f7232bb57c@mail.gmail.com>
References: <20100409202533.GA8983@phenom.dumpdata.com>
	 <Pine.LNX.4.44L0.1004091722260.1852-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1004091722260.1852-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Pedro Ribeiro <pedrib@gmail.com>, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 9, 2010 at 3:23 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
> On Fri, 9 Apr 2010, Konrad Rzeszutek Wilk wrote:
>
>> On Fri, Apr 09, 2010 at 03:34:06PM -0400, Alan Stern wrote:
>> > On Fri, 9 Apr 2010, Pedro Ribeiro wrote:
>> >
>> > > > The DMA pointers do indeed look sane. I wanted to take a deepe=
r look at
>> > > > this and set up a 64bit system today. However, I fail to see t=
he problem
>> > > > here. Pedro, how much RAM does your machine have installed?
>> >
>> > > It has 4 GB.
>> >
>> > That means DMA mapping cannot be the cause of the problem. =A0:-(
>>
>> That isn't entirely true. The BIOS usually allocates a 256 MB ACPI/P=
CI hole
>> that is under the 4GB.
>>
>> So end up with 3.7 GB, then the 256MB hole, and then right above the=
 4GB
>> you the the remaining memory: 4.3GB.
>
> How can Pedro find out what physical addresses are in use on his
> system?

If you have 4GB of RAM then almost certainly you have memory located
at addresses over 4GB. If you look at the e820 memory map printed at
the start of dmesg on bootup and see entries with addresses of
100000000 or higher reported as usable, then this is the case.
