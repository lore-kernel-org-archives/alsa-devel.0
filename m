From: "Tan, Seng Kai" <seng.kai.tan@intel.com>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Tue, 19 Apr 2016 00:57:54 +0000
Message-ID: <61B6C8BF61481342973655BC8AB0FF355AEFE5@PGSMSX101.gar.corp.intel.com>
References: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
 <5714A9B0.8060002@ladisch.de>
 <61B6C8BF61481342973655BC8AB0FF355AEE24@PGSMSX101.gar.corp.intel.com>
 <5714CCB2.1050403@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C914265173
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 02:58:06 +0200 (CEST)
In-Reply-To: <5714CCB2.1050403@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


Tan, Seng Kai wrote:
>>> Your hardware does not support S24_LE.
>>> 24-bit samples use the S32_LE format (unless you have very exotic hardware, but HDA isn't).
>>
>> We have another I2S hardware which is able to support S24L_LE and 
>> S32_LE format,

>The format on the codec's bus has almost nothing to do with the ALSA sample format.

>The Sxx_xE format describes how the samples are formatted in memory, i.e., how the DMA controller expects to read them.

I think I get what you mean. 
The input to the driver should be 0x123456 (3 byte, no padding)
And the driver supposed to arrange it to 0x12345600 (4 byte, LSB padding for left justified)
That is because the driver do not support and the value get truncate

>> S24_LE in wav file

>.wav files do no use ALSA sample formats.

>Please describe the values of the header fields in this .wav file.

qwavheaderdump -F ~/Public/workspace/aud_file/Tones/2ch_48sine_S24_LE.wav
/home/ilab/Public/workspace/aud_file/Tones/2ch_48sine_S24_LE.wav (11520044 bytes):
        riff: 'RIFF'
        riff length: 11520036
        wave: 'WAVE'
        fmt: 'fmt '
        fmt length: 16
        format: 1
        channels: 2
        sample rate: 48000
        bytes/second: 384000
        bytes/sample: 8
                 bytes/sample field should be 1, 2 or 4
                don't know which value must be set...

        bits/sample: 24
        data: 'data'
        data length: 11520000

Regards,
Clemens
