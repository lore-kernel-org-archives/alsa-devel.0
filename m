From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Controlling the Tascam FW-1884
Date: Fri, 28 Sep 2018 12:44:02 +0900
Message-ID: <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B352678C4
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 05:44:07 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id j8-v6so3327874pff.6
 for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2018 20:44:07 -0700 (PDT)
In-Reply-To: <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sbahling@suse.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Scott,

On Sep 24 2018 18:32, Scott Bahling wrote:
> On Mon, 2018-09-17 at 23:36 +0900, Takashi Sakamoto wrote:
>> I prepare branches in two remote repositories:
>>    -
>>
> https://github.com/takaswie/snd-firewire-improve/tree/topic/tascam-userspace
>>   
>> (a384019c0f78)
>>    - https://github.com/takaswie/libhinawa/tree/topic/tascam-userspace
>> (a5994ec2165f)
>>
>> Installing the patched driver, you can read the status and control
>> message in userspace by mmap(2).
>>
>> Patched libhinawa produces HinawaSndTscm GObject class. This class is
>> also available with gobject introspection. For example with PyGobject:
>>
> ...
> Thanks! I finally had some time to try it out.
> 
> My test system is running a 4.12 kernel from openSUSE Leap 15.0. I
> backported the patches but had to remove your GFP_KERNEL patch for it to
> work on my kernel. With the GFP_KERNEL patch, user space was not seeing
> updates to the data stream. With it removed, I had a constant update.
> 
> The kernel was unstable and the system hard locked frequently with the
> patches enabled (with and without the GFP_KERNEL patch). But I was able
> to map out all the controller functions to the bits in the first 16
> quadlets. I will write up my findings and send them later.

I'm sorry but I have applied wrong changes to the remote branch for
kernel patch. It includes three issues:

1. call vfree() to memory object allocated by kmalloc()
2. bring kernel oops due to double free corruption of 'tscm->status'
3. invalid page mapping of 'tscm->status' to process' VMA

I pushed additional three patches. Would you please test with them?

  - 1777454 firewire-tascam: fix kernel oops to call vfree() to memory 
object allocated by kmalloc
  - e11d941 firewire-tascam: fix double free corruption
  - 5e7fef9 firewire-tascam: use one page for mmap(2)ed data

Espeially, when allocating in kernel logical space instead of kernel
virtual space, I should have kept one page for 'tscm->status' because
kmalloc() allocates memory object unaligned to page boundary by kernel
SLAB/SLOB/SLUB allocaters. This is a cause which you cannot see updated
data. A page mapped to process' VMA doesn't include region of
'tscm->status' data correctly.

Again, I'm sorry to lost your time due to this kind of my stupid
codes...

>>> I noticed that we are able to control the LEDs from the host via the
>>> asynchronous link. Do you you think the faders are also controlled
>>> that way
>>> or would that also go via isochronous packets to the FW-1884?
>>
>> The rx isochronous packets from system to the unit include no data to
>> control the unit[2]. If the faders are movable from system software,
>> it should be achieved by asynchronous transactions, like blighting
>> LEDs.
> 
> I guess without an analyzer that will be difficult to track down.

Thanks

Takashi Sakamoto
