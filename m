From: Craig McQueen <craig.mcqueen@beamcommunications.com>
Subject: Re: Low sample rates for SGTL5000 on i.MX28
Date: Fri, 14 Nov 2014 09:36:51 +1100
Message-ID: <54653283.5070404@beamcommunications.com>
References: <546450E5.9090203@beamcommunications.com>
 <CAOMZO5BAaL8cP+7NetvNyEiGfokiyLWdpXw3r=AJspLj1dfzxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-HK1-obe.outbound.protection.outlook.com
 (mail-hk1on0053.outbound.protection.outlook.com [134.170.140.53])
 by alsa0.perex.cz (Postfix) with ESMTP id A25692661AE
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 23:37:03 +0100 (CET)
In-Reply-To: <CAOMZO5BAaL8cP+7NetvNyEiGfokiyLWdpXw3r=AJspLj1dfzxw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 13/11/14 23:32, Fabio Estevam wrote:
> On Thu, Nov 13, 2014 at 4:34 AM, Craig McQueen
> <craig.mcqueen@beamcommunications.com> wrote:
>> I'm testing the 3.18 kernel for i.MX28 EVK, which has an SGTL5000 CODEC. I
>> notice that audio cannot be output at 8 kHz or 11.025 kHz, although the
>> SGTL5000 data sheet table 8 indicates this should be possible.
>>
>> If I try to play or record at 8 kHz or 11.025 kHz, I get an error message:
>>
>>      # aplay test_8k.wav
>>      [ 6168.910201] mxs_evk_startup: Skipped programming wolfson codec
> Is this really a mainline kernel? I don't see any 'mxs_evk_startup' in mainline.

You're right, I cut-and-pasted that from my original work on a custom 
audio driver on a 3.14 kernel. Sorry about that. But still, I get the 
same error on the 3.18-rc4 kernel. Here is a sample:

     # aplay -D hw:0,0 stereo_8k.wav
     Playing WAVE 'stereo_8k.wav' : Signed 16 bit Little Endian, Rate 
8000 Hz, Stereo
     [ 3718.857813] sgtl5000 0-000a: Invalid mclk frequency: 4.096MHz
     [ 3718.865460] mxs-sgtl5000 sound: ASoC: machine hw_params failed: -22
     aplay: set_params:1297: Unable to install hw params:
     ACCESS:  RW_INTERLEAVED
     FORMAT:  S16_LE
     SUBFORMAT:  STD
     SAMPLE_BITS: 16
     FRAME_BITS: 32
     CHANNELS: 2
     RATE: 8000
     ...

>>      Playing WAVE 'test_8k.wav' : Signed 16 bit Little Endian, Rate 8000 Hz,
>> Mono
>>      [ 6168.941211] sgtl5000 0-000a: Invalid mclk frequency: 4.096MHz
>>      [ 6168.947047] mxs-sgtl5000 sound.11: ASoC: machine hw_params failed:
>> -22
>>      aplay: set_params:1145: Unable to install hw params:
>>      ...
>>
>> For an 8 kHz sample rate, I get
>>
>>      Invalid mclk frequency: 4.096MHz
> I am not able to reproduce this bug here. I can play 8kHz file on the mx28evk:
>
> root@freescale /home$ aplay mono_8k.wav
> Playing WAVE 'mono_8k.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

If you're playing a mono file successfully, then you must be going 
through an ALSA plugin that does some sort of rate/format/channel 
conversion. That depends on what's in asoundrc. Please try it with the 
-D hw:0,0 parameter and a stereo file.

-- 
Craig McQueen
