From: ZH Tu <tuzhihe@pcasl.com>
Subject: Re: Intel Cherry Trail -- No sound in linux
Date: Sat, 12 Dec 2015 16:25:46 +0800
Message-ID: <2015121216254115203520@pcasl.com>
References: <000a01d11b93$38632860$a9297920$@com>,
 <56423EBB.8010108@linux.intel.com>,
 <201511121444557079740@pcasl.com>,
 <5644CA6C.5000302@linux.intel.com>,
 <20151116154335174375283@pcasl.com>,
 <564A88C9.7020008@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.pcasl.com (mail.pcasl.com [211.154.131.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 149CB26061E
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 09:47:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

As Pierre suggestions:

try to enable a DSP loopback to see if the data isn't garbled by the driver
amixer cset "name='pcm1_out mix 0 pcm0_in" on

But we all know that the stream path is power on automaticlly, so even I do the mixer setting, the pcm1_out wighet still is in power off state. 

So is there way to do the loopback?


Now every time I do the test:
aplay test.wav

I get the error message:
[drm:intel_pipe_update_end [i915]] *ERROR* Atomic update failure on pipe C (start=46633 end=46634)

And there're no more errors.

>From the message I guess the pipe used by intel drm is blocked, so as to the pipe used by SST firmware,   that's why I cannot get data from DACDAT pin. 

This bug confused me for  a long time,  can anyone give some suggestions?

Thanks


Zhihe Tu
 
From: Pierre-Louis Bossart
Date: 2015-11-17 09:54
To: alsa-devel@alsa-project.org; tuzhihe@pcasl.com
Subject: Re: [alsa-devel] Intel Cherry Trail -- No sound in linux
 
On 11/16/2015 01:43 AM, ZH Tu wrote:
> Hi Pierre-Louis, thanks for your reply.
> 
> Maybe I am not make myself clear. 
> 
> Actually I refer some configure from baytrail platform:
> amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
> amixer -c0 sset 'media0_out mix 0 media1_in' on
> amixer -c0 sset 'media1_in Gain 0' 80% 
> amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'media1_in Gain 0' off
> amixer -c0 sset 'pcm0_in Gain 0' 80% 
> amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
> amixer -c0 sset 'pcm0_in Gain 0' off
> amixer -c0 sset 'codec_out0 Gain 0' 80%
> amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
> amixer -c0 sset 'codec_out0 Gain 0' off
> 
> Also there're some settings for the RT5672 codec, but I do not remember now.
 
it seems that the link is active with no data? Couple of suggestions:
 
1. try to enable a DSP loopback to see if the data isn't garbled by the driver
amixer cset "name='pcm1_out mix 0 pcm0_in" on
 
2. try a loopback from capture to playback to see if the data sampled by the codec can be played out.
amixer -c0 sset 'codec_out0 mix 0 codec_in0' on
amixer -c0 sset 'codec_out0 mix 0 codec_in1' on
 
3. replicate all the data on codec_out1 to make sure you have data on all 4 slots
 
amixer -c0 sset 'codec_out1 mix 0 pcm0_in' on
amixer -c0 sset 'codec_out1 Gain 0' 80%
amixer -c0 sset 'codec_out1 Gain 0 Ramp Delay' 50
amixer -c0 sset 'codec_out1 Gain 0' off
 
 
 
__________ Information from ESET Smart Security, version of virus signature database 4468 (20090929) __________
 
The message was checked by ESET Smart Security.
 
http://www.eset.com
 
 
 
