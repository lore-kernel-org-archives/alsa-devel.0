From: Irfan Shaikh <irfan.shaikh@sasken.com>
Subject: Re: snd_pcm_mmap_writei
Date: Thu, 18 Nov 2010 12:52:32 +0530
Message-ID: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE359@EXGMBX01.sasken.com>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE356@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta-blr1.sasken.com (mta-blr1.sasken.com [203.200.200.72])
	by alsa0.perex.cz (Postfix) with ESMTP id EDA4B1038AF
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 08:23:13 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE356@EXGMBX01.sasken.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

All adresses are also VALID
data : 0x96000 alsaparams->data :0x96000 count :4032 alsaParams->pcm_handle : 0xcfbe0

Please go through belo problem

________________________________________
From: alsa-devel-bounces@alsa-project.org [alsa-devel-bounces@alsa-project.org] On Behalf Of Irfan Shaikh [irfan.shaikh@sasken.com]
Sent: Thursday, November 18, 2010 12:44 PM
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] snd_pcm_mmap_writei

Hello All,

Replacing  snd_pcm_writei with snd_pcm__mmap_writei gives SEGFAULT in My code.
Works fine with pcm.c. Can ANyone help me on FINDING OUT WHAT MAY BE CAUSE OF SEGFAULT ?
Is any thing specific required for MMAP Write ????

/$$$ Works FINE $$$/
//while ((pcmreturn = snd_pcm_writei(alsaParams->pcm_handle, data, count)) < 0)   // ===>>>>Replaced by below LINE

/$$$ SEG FAULT$$$/
while ((pcmreturn = snd_pcm__mmap_writei(alsaParams->pcm_handle, data, count)) < 0)    // REPLACED ABOVE NORMAL WRTIE WITH MMAP WRITE
{
                /*
                  * My code
                */
}

Thanks in advance,
Best Regards






SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any 
 virus transmitted by this email.
Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
