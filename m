From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Mon, 18 Apr 2016 14:01:54 +0200
Message-ID: <5714CCB2.1050403@ladisch.de>
References: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
 <5714A9B0.8060002@ladisch.de>
 <61B6C8BF61481342973655BC8AB0FF355AEE24@PGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 148632650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 14:01:56 +0200 (CEST)
In-Reply-To: <61B6C8BF61481342973655BC8AB0FF355AEE24@PGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Tan, Seng Kai" <seng.kai.tan@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Tan, Seng Kai wrote:
>> Your hardware does not support S24_LE.
>> 24-bit samples use the S32_LE format (unless you have very exotic hardware, but HDA isn't).
>
> We have another I2S hardware which is able to support S24L_LE and S32_LE format,

The format on the codec's bus has almost nothing to do with the ALSA
sample format.

The Sxx_xE format describes how the samples are formatted in memory,
i.e., how the DMA controller expects to read them.

> S24_LE in wav file

.wav files do no use ALSA sample formats.

Please describe the values of the header fields in this .wav file.

> Question: is all HDMI support 24 bit must have 32bit support?

That depends on the DMA controller.  Most use 32-bit alignment for
24-bit samples.


Regards,
Clemens
