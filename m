From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA: bebob: Use common error handling code in
 snd_bebob_stream_start_duplex()
Date: Wed, 27 Sep 2017 08:30:36 +0900
Message-ID: <09bb0e83-01fe-cd12-a084-31db3f12d663@sakamocchi.jp>
References: <85f95150-9cec-7a53-7692-837ba543e1ec@users.sourceforge.net>
 <541f0f9f-fc87-f65b-bbd8-fec5d45d5d2e@users.sourceforge.net>
 <a1dee732-f5c4-5b35-9f82-553fc8ce430d@sakamocchi.jp>
 <3afecbef-b7ac-a4e8-f439-a351916f05e5@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3afecbef-b7ac-a4e8-f439-a351916f05e5@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 24 2017 16:06, SF Markus Elfring wrote:
>> 668     if (!amdtp_stream_wait_callback(&bebob->tx_stream,
>> 669                                     CALLBACK_TIMEOUT)) {
>> 670         amdtp_stream_stop(&bebob->tx_stream);
>> 671         amdtp_stream_stop(&bebob->rx_stream);
>> 672         break_both_connections(bebob);
>> 673         err = -ETIMEDOUT;
>> 674     }
>> 675 }
>>
>> I think it better to apply your solution too in the above to keep code consistency.
> 
> How do you think about to adjust this function implementation after the other two
> update steps from the patch series would be integrated?
> 
> 
>> For the other patches, I can find no merit to apply except for reduction
>> of the number of characters included in the file.
> 
> Would you like to refer to any specific update suggestions for further clarification?

I had already read your patch comments and understand your intention
somehow, because it's a part of task for daily reviewing. Then, I did
comment.

At development for Linux kernel, there're some important points for
developers to notice. In our case, we should care of _practicality_.
Roughly speaking, our work for kernel should add advantages for
kernel/application runtime or assists the other developers' work. In
this point, some patches are welcome and the others are not. I'll show
you two examples.

In this subsystem, I have reviewed patches from Julia Lawall. The most
of her or his patches attempt to add 'const' qualifier for read-only
symbols. As a result, the symbols place to '.rodata' section of ELF
binary. This section has a hint for loaders to put these symbols to
segments with read-only attributes. This has an advantage for
compilation time and runtime. Recent compilers can detect codes to
change content of the symbols with 'const' qualifier. Even if the codes
were exposed from developers understanding or compilers' check,
segmentation would occur in runtime at early stage of development or
early days after releasing kernel. This is very helpful for developers
to find unexpected changes for contents of the symbol.

I also subscribe a mailing list of Linux Driver Project[1], which is for
various drivers. Sometimes posted patches are rejected by maintainers.
Such patches typically include minor code change without actual
advantages for runtime or developers. For instance, patches for '80
characters per line' are often posted and rejected. If this kind of
patchset were added to change history of kernel, tons of unpractical
logs are accumulated for development.  This make it worse for developers
to maintain the kernel.

By the way, ALSA BeBoB driver is just for ASIC and firmwares which
ArchWave AG (formerly BridgeCo. AG.) had produced for devices with
IEC 61883-1/6 packet streaming on IEEE 1394 bus and Time Sensitive
Network (TSN). As long as I know, the last product with this solution
was shipped at 2010. Thus the driver is under maintenance. I have some
tasks for this driver as well as drivers in ALSA firewire stack,
however basically this driver is under maintenance and might not get
further integration. I think that code cleanup for the driver don't help
the other developers. It's better to apply such cleanup to more
long-live codes such as core functionality of ALSA. (But pay enough
attention to practicality of the changes when you start this kind of
work.)

In this point of view, whether your patchset is worth to be applied
or not, Please keep enough time to think about.


[1] http://driverdev.linuxdriverproject.org/mailman/listinfo

Thanks

Takashi Sakamoto
