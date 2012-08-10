From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Fri, 10 Aug 2012 16:45:47 +0200
Message-ID: <50251E9B.5010401@ladisch.de>
References: <1C2A10B55A8EFD41B703692DB3F435E40C2321BD@G01JPEXMBYT21>
 <s5hhasb9sv5.wl%tiwai@suse.de>
 <1C2A10B55A8EFD41B703692DB3F435E40C23248A@G01JPEXMBYT21>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A7C3526533B
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 16:16:03 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EE4BA20CD1
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 10:45:48 -0400 (EDT)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id 89ADF8E01F3
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 10:45:48 -0400 (EDT)
In-Reply-To: <1C2A10B55A8EFD41B703692DB3F435E40C23248A@G01JPEXMBYT21>
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

Fujikawa, Kazutoshi wrote:
>>> 0x00123456 (MSB 0(or 0xFF) padding)
>>
>> This is the correct S24_LE representation.
>
> I record a sound file by arecord command on Ubuntu.
> (% arecord -f S24_LE -r 48000 -c 2 ubuntu_rec_S24_LE_48000.wav )
>
> Then this file was created, and it was LSB 0 padding.
> So I think that S24_LE format is LSB 0 padding.
>
> % od -t x4 ubuntu_rec_S24_LE_48000.wav
> 0000000 46464952 003a9824 45564157 20746d66
> 0000010 00000010 00020001 0000bb80 0005dc00
> 0000020 00180008 61746164 003a9800 ffffbf00
> 0000030 ffffc300 ffffc600 ffffca00 ffffd300
> 0000040 ffffd600 ffffdc00 ffffe000 ffffe000
> 0000050 ffffe400 ffffea00 ffffeb00 fffff800
> 0000060 fffffa00 00000400 00000500 00001000
> 0000070 00000f00 00001600 00001700 00001500
>
> Do you know why this file is LSB 0 padding?

What hardware (driver) was this recorded from?
Does the hardware actually support S24_LE, or was this converted?


Regards,
Clemens
