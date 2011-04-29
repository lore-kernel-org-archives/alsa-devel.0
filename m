From: <kshemanth.vasireddi@wipro.com>
Subject: Re: Copy call back for capture substream
Date: Fri, 29 Apr 2011 16:21:04 +0530
Message-ID: <A3D770027F3D024D8AA74E0D0C630813030CAF55@PNE-HJN-MBX02.wipro.com>
References: <A3D770027F3D024D8AA74E0D0C630813030CA7E7@PNE-HJN-MBX02.wipro.com>
	<4DB93389.3060103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74]) by alsa0.perex.cz (Postfix) with ESMTP id 76CE5244FC
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 12:51:15 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <4DB93389.3060103@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Yes, I am not clear on what should be returned in pointer call back.
>From my understanding we have return available frames in buffer.

My ADC doesn't have buffer so, I maintain a ring buffer of 2 periods.

I have 2 capture channels with 1 sample width 2 bytes sampling rate is
48khz. Based on this

1 Frame = number of channels * sample_bytes  ( 2 * 2 = 4)

Let's say period size is 1024 frames ( 4096 bytes)

Buffer_size is 2 periods  ( 8192 bytes)

Accordingly I configured 
	.info =		(SNDRV_PCM_INFO_MMAP |
SNDRV_PCM_INFO_INTERLEAVED |
			  SNDRV_PCM_INFO_MMAP_VALID ),
	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
	.rates =		SNDRV_PCM_RATE_48000,
	.rate_min =		48000,
	.rate_max =		48000,
	.channels_min =		2,
	.channels_max =		2,
	.buffer_bytes_max =	8192,
	.period_bytes_min =	4096,
	.period_bytes_max =	4096,
	.periods_min =		1,
	.periods_max =		2,

In pointer call back for first time if I return 1024, copy call back is
invoked. In second pointer call if I return again 1024 it copy is not
invoked.

In second pointer call if I return 2048 copy is called. Later copy was
never called.

Can someone please help me out, what is correct value that I should
return in pointer call back so that copy is invoked.

Thanks and regards,
Kshemanth


-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Thursday, April 28, 2011 3:00 PM
To: Kshemanth Vasireddi (WT01 - Manufacturing & Hi Tech)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Copy call back for capture substream

kshemanth.vasireddi@wipro.com wrote:
> I had registered a copy call back.
> 
> all call backs are invoked, but copy call back is not
> getting invoked. Can you please let me know when will copy call  back
> shall be invoked, is there any condition for it.

It's right there in the source code.

The copy callback is called exactly when in the same circumstances when
the data of a 'normal' driver would be copied out of the device's
buffer, i.e., when some data is available.

I'd guess that your pointer callback does not return the correct values.

> The information contained in this electronic message ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.


Regards,
Clemens

Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 

www.wipro.com
