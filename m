From: Konstantinos Georgantas <k.georgantas@samsung.com>
Subject: Audio usb switch to alternate setting 0
Date: Thu, 23 Jan 2014 20:31:04 +0100
Message-ID: <52E16DF8.8000909@samsung.com>
References: <52DBD817.8050304@samsung.com> <52DCF98A.4080509@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 80B2B2652C4
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 20:31:10 +0100 (CET)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MZV00FJSCVUL660@mailout4.w1.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 23 Jan 2014 19:31:07 +0000 (GMT)
Received: from [192.168.0.101] ([106.111.34.46])
 by eusync4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MZV00AFDCVT1OA0@eusync4.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 23 Jan 2014 19:31:05 +0000 (GMT)
In-reply-to: <52DCF98A.4080509@zonque.org>
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
List-Id: alsa-devel@alsa-project.org

Hello!

On 01/20/2014 11:25 AM, Daniel Mack wrote:
> Hi,
>
> On 01/19/2014 02:50 PM, Konstantinos Georgantas wrote:
>> I am trying to control from the client side which Alternate Setting to
>> use. Basically I would like to be able to switch from Alternate Setting
>> 0 to 1 and vice versa so that I am not receiving any set interface
>> requests in the meantime. From the audio class 2.0 documentation I
>> understand that I should be able to do something like this by using the
>> active alternate setting control, and here comes my main problem.
> I'm not quite following from which side you're looking at the system,
> IOW, who should be "receiving" requests. Are you talking about the
> device or the host side?
As I see it generating an interrupt from the device to the host should 
"force" the host to "take appropriate action to reactivate the interface 
by switching to a valid Alternate Setting".
> As the spec says (5.2.6.1.1), such a control is read-only, and it "does
> not allow an interface to change from one active Alternate Setting to
> another without Host intervention". "The main purpose of this Control is
> to notify the Host (through an interrupt) that the last
> selected Alternate Setting is no longer valid.".
>
> Active alt setting switching is done implictly by (de)activating the PCM
> streams that are associated with them.
That is right! But what if someone tries to play music for example? The 
host will try to set Alternate Setting 1 again thinking that it is still 
active but in this case my device happens to be in sleep mode so it 
cannot reply to the usb_set_interface requests. I thought that if I 
indicated that only Alternate Setting 0 is active I would avoid this 
request. Am I right? Of course when waking up I could issue another 
interrupt indicating that my device activates again the Alternate 
Setting 1. Please correct me if I misunderstand something.
>> When I generate an interrupt to the interrupt endpoint I should expect a
>> GET request which I never see in the host side (hope I am right here).
>>
>> Here comes the interrupt:
>> interrupt->bInfo          = 0x00;
>> interrupt->bAttribute  = 0x01;
>> interrupt->wValue       = 0x0100;
>> interrupt->wIndex       = 0x0004;
>>
>> Could you please tell me if such a functionality is supported and how
>> the interrupt should look like?
> This type of interrupt is currently unsupported, but it should be easy
> to add. Note, however, that the only interesting use case is to tear the
> audio stream down and send active users XRUNs.
>
> Not sure if this is what you want.
>
> As always: patches are welcome :)
>
>
> Daniel
>
Absolutely! I can come up with a patch but I just want to be sure I have 
understood the spec in the right way :) Thanks for your help!

Kostas
