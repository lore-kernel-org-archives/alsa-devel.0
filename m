From: Christopher Seifert <seifert@ims.uni-hannover.de>
Subject: ASoC driver for multi-codec sound device
Date: Fri, 07 Feb 2014 18:52:58 +0100
Message-ID: <52F51D7A.1050109@ims.uni-hannover.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.uni-hannover.de (mailout2.uni-hannover.de
 [130.75.2.114]) by alsa0.perex.cz (Postfix) with ESMTP id 7E1C7265454
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 18:52:59 +0100 (CET)
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

Hi all,

we are currently working on an ASoC driver for a multi-codec sound 
device. The kernel we use is version 3.10.

Each codec has it's own I2C address and are connected via I2S to a 
single CPU DAI. We'd like to use the codecs in TDM mode later on, so we 
can use them as a single multi channel ALSA device. Currently we can use 
one codec in stereo mode with playback and capturing working using a 
device tree. We were able to get a second codec working (using the 
snd_soc_aux_dev structure in our driver) in so far we can see and use 
the codec's controls via alsamixer, however the codec seems to ignore 
the commands or does not receive any at all.

What we'd like to know:

1) How to we achieve proper initialisation of all codecs? More 
specifically, which function (ALSA side) or callback (codec side) is 
used to set up the codecs clocks (via I2C)?

2) As far as we know the driver we are building upon does not implement 
own PCM or DMA drivers. Is it necessary to do this on our own to get the 
codecs working in TDM mode? Also when working in I2S (stereo) mode on 
ALSA side, is it possible to tell ALSA to use more than 2 channels of 
the sound buffer? We currently have interleaved audio samples from more 
than one codec in our sound buffer (transferred by DMA) and we'd like to 
select a subset of these depending on how the sound device was opened 
(for example "arecord -c 2" vs. "arecord -c 4" and so on). Which are the 
audio sample order ALSA supports or expects, specifically in the case of 
more than 2 audio channels? (Interleaved "L0, L1, L2, ..., Ln, R0, R1, 
..., Rn" vs. "L0, R0, L1, R1, ..., Ln, Rn")

3) If there is no custom DMA driver implemented how does the ALSA 
framework use the DMA controller? In which case do we need to write our 
own DMA driver? Are there possibilities to use the ALSA framework's 
internal DMA handling for our purposes?

4) How are PCM and DMA correlated in ALSA framework? Specifically, do 
the implementations depend on each other or are they independent, so we 
can for example implement a DMA driver and use ALSA's default PCM?

We're stuck with this, so we appreciate any kind of help pointing us in 
the right direction. If there are any required informations missing 
please don't hesitate to ask.

Thanks,
Achim and Christopher
