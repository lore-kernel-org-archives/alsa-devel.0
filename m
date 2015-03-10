From: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Tue, 10 Mar 2015 07:32:36 +0000
Message-ID: <6A72E9C91650BD49A6D9B305755BC04C42D80787@mbs1.ad.jyu.fi>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>,
 <54FD5D4C.3040204@ladisch.de>
 <6A72E9C91650BD49A6D9B305755BC04C42D8067A@mbs1.ad.jyu.fi>,
 <54FE14F4.9070704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from posti6.jyu.fi (posti6.jyu.fi [130.234.4.43])
 by alsa0.perex.cz (Postfix) with ESMTP id EBDA6261534
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 08:32:39 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by posti6.jyu.fi (8.13.8/8.13.8) with ESMTP id t2A7WdGL005888
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 09:32:39 +0200
Received: from posti6.jyu.fi ([127.0.0.1])
 by localhost (posti6.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MyQeNtfaR+J7 for <alsa-devel@alsa-project.org>;
 Tue, 10 Mar 2015 09:32:39 +0200 (EET)
Received: from exmail.jyu.fi (cas1.ad.jyu.fi [130.234.8.8])
 by posti6.jyu.fi (8.13.8/8.13.8) with ESMTP id t2A7Wc1F005884
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 09:32:39 +0200
In-Reply-To: <54FE14F4.9070704@ladisch.de>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> By looking at the receiving end bytes it looks exactly like that has happened.
>
> This pretty much proves that this is a bug in the device firmware.
> 
> You might try contacting Miditech ...

I have sent an email to them, but as we all know, most probably they are not going to even answer me. 

This is a common problem with many devices across several brands of devices and influences not only Linux but also other systems (see for example a  list by wabbiguy at http://forum.highlyliquid.com/archive/index.php/t-500.html). There seems to be some user space software, which provide the same type of delay that I used to work around this problem. In my opinion this should not be done in user space, even though I tested that it works. I am going to propose something wild: What do you think about a possibility for a customized driver for this class of hardware (I mean usb compliant midi interfaces with broken output ring buffer)? If the kernel driver would use timing utilities to regulate the speed of data written to the device, this could provide a dirty fix for this type of hardware. It
  wouldn't be the first driver workaround for broken hardware. Does this sound doable? I think a relatively small amount of code could provide a fix for several different devices and therefore increa
 se their value for their users.

>>>> Is there a way to connect two programs via a virtual RawMIDI port so
>>>> that I could test without using the hardware?
>>>
>>> Load the snd-virmidi module, and connect two of its ports with aconnect.
>>
>> I did this and by using the virtual ports the behaviour is more
>> reasonable, but still not as expected. Everything works ok as long as
>> the message length is less than or equal to the buffer size (4096).
>> With message sizes larger than that the writing end still claims it
>> has sent everything, as it should do because the port is opened in
>> blocking mode. On the reading end I can see that some data is missing
>> and xruns are reported.
>
> Oops, using snd-virmidi this way also goes through the sequencer, which
> does not do blocking.
> 
> There is no other way to get a virtual RawMIDI port.
> 
> However, the driver was tested with lots of other devices, and huge
> SysEx messages have this problem only with your device.

Ok. You have me convinced.

Taneli
