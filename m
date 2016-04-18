From: "Tan, Seng Kai" <seng.kai.tan@intel.com>
Subject: Re: Question about Conversion to S24_LE from S24_3LE
Date: Mon, 18 Apr 2016 09:54:25 +0000
Message-ID: <61B6C8BF61481342973655BC8AB0FF355AEE24@PGSMSX101.gar.corp.intel.com>
References: <61B6C8BF61481342973655BC8AB0FF355AE2F4@PGSMSX101.gar.corp.intel.com>
 <5714A9B0.8060002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 15EAC265357
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 11:54:27 +0200 (CEST)
In-Reply-To: <5714A9B0.8060002@ladisch.de>
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

Thanks Clemens

Tan, Seng Kai wrote:
>> I am facing similar problem like this issue, hope to get your advice.
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/05424
>> 1.html

>And the answer is the same.

>> I try to turn on S24_LE support for HDMI Audio using below patch.
>Your hardware does not support S24_LE.
>24-bit samples use the S32_LE format (unless you have very exotic hardware, but HDA isn't).
We have another I2S hardware which is able to support S24L_LE and S32_LE format, 
when I use -Dplughw to play S24_3LE format the same things happen. It pad the 0 in MSB
the whole data is shift to right and the audio volume is lower. Is this the problem for alsa plugins?

>> Back end  S24_LE :  0x00123456(in 4bytes, MSB 0 padding)
>This is how S24_LE works.
S24_LE in wav file supposed to be in format  0x00123456 ( 0 pad MSB) or
0x12345600 ( 0 pad LSB) which one is correct? I am a bit confuse here, because 
When I open file with 0x12345600 ( 0 pad LSB) using audacity, it is able to view the file
But not for 0x00123456 ( 0 pad MSB).

>> Can you advice how to tell the alsa plugin to pad in LSB instead of MSB?
>Use S32_LE.
Question: is all HDMI support 24 bit must have 32bit support? My concern is it don't
And we want to maximize the quality to 24bit. 

Regards,
Seng Kai
