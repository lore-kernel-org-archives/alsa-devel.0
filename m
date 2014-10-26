From: dE <de.techno@gmail.com>
Subject: Re: What are subdevices?
Date: Sun, 26 Oct 2014 15:27:32 +0530
Message-ID: <544CC58C.3080800@gmail.com>
References: <544CAD55.8070605@gmail.com> <544CBACF.2080702@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E054626068F
 for <Alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 10:58:01 +0100 (CET)
Received: by mail-pd0-f174.google.com with SMTP id p10so3879753pdj.19
 for <Alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 02:57:59 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.66.195])
 by mx.google.com with ESMTPSA id j11sm8008025pdk.76.2014.10.26.02.57.55
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 26 Oct 2014 02:57:56 -0700 (PDT)
In-Reply-To: <544CBACF.2080702@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/26/14 14:41, Clemens Ladisch wrote:
> dE wrote:
>> A device seems like the output streams the sound card supports. Like HDMI, DP, analog etc...
>>
>> So what's a subdevice?
> A subdevice is an output streams the sound card supports.
>
> Typically, a device has multiple subdevices if the card supports hardware mixing; all
> the subdevices end up at the same physical output.
>
>
> Regards,
> Clemens

Ok, so a device list is a list of different streams the card can 
supports simultaneously and they'll be output via different channels 
without mixing.

Thanks for clarifying this.

But, typically cards have a single analog device but support 
multichannel output. So how does this work at the software level? If 
ALSA can't send multiple streams of audio to one device, then how does 
ALSA send  separate output to different channels of the device?

Is the PCM sent to the sound card codified? Is this the same way how 
stereo work?
