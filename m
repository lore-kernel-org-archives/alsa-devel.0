From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel Cherry Trail -- No sound in linux
Date: Mon, 16 Nov 2015 19:54:17 -0600
Message-ID: <564A88C9.7020008@linux.intel.com>
References: <000a01d11b93$38632860$a9297920$@com>
 <56423EBB.8010108@linux.intel.com> <201511121444557079740@pcasl.com>
 <5644CA6C.5000302@linux.intel.com> <20151116154335174375283@pcasl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EA1F2260523
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 02:54:42 +0100 (CET)
In-Reply-To: <20151116154335174375283@pcasl.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tuzhihe@pcasl.com
List-Id: alsa-devel@alsa-project.org


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
