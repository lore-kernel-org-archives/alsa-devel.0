From: dE <de.techno@gmail.com>
Subject: Re: What are subdevices?
Date: Tue, 28 Oct 2014 08:47:26 +0530
Message-ID: <544F0AC6.5030806@gmail.com>
References: <544CAD55.8070605@gmail.com> <544CBACF.2080702@ladisch.de>
 <544CC58C.3080800@gmail.com> <544EA125.80909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 353CD2615F3
 for <Alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 04:17:55 +0100 (CET)
Received: by mail-pa0-f44.google.com with SMTP id bj1so3229011pad.3
 for <Alsa-devel@alsa-project.org>; Mon, 27 Oct 2014 20:17:52 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.143.167])
 by mx.google.com with ESMTPSA id c2sm175785pdf.52.2014.10.27.20.17.49
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 27 Oct 2014 20:17:51 -0700 (PDT)
In-Reply-To: <544EA125.80909@ladisch.de>
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

On 10/28/14 01:16, Clemens Ladisch wrote:
> dE wrote:
>> typically cards have a single analog device but support multichannel
>> output. So how does this work at the software level? If ALSA can't
>> send multiple streams of audio to one device, then how does ALSA send
>> separate output to different channels of the device?
> The channels are not separate.  For a stereo devices, the samples are
> arranged like LRLRLRLRLR...; for more channels, there are more
> interleaved values: 123456123456123456123456...
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

So it's with the encoding of the PCM.

Thank you so much for the response! I'll blog about this in my ALSA doc.
