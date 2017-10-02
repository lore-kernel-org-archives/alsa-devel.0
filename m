From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC Sound Driver I2S over LPE,
 Intel Baytrail SoC. MinnowBoard Max
Date: Mon, 2 Oct 2017 13:22:05 -0500
Message-ID: <d2a80c3a-9624-4c71-63ef-d60d1141c2cf@linux.intel.com>
References: <56423D44.60505@linux.intel.com>
 <fff69ce9-69f5-9e44-820a-c6c29ca2898f@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id E4085267056
 for <alsa-devel@alsa-project.org>; Mon,  2 Oct 2017 20:22:08 +0200 (CEST)
In-Reply-To: <fff69ce9-69f5-9e44-820a-c6c29ca2898f@emutex.com>
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
To: Nicola Lunghi <nicola.lunghi@emutex.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/02/2017 11:14 AM, Nicola Lunghi wrote:
> Dear Pierre Louis
>
> We are having problems enabling I2S output with the UP board.
>
> We have currently two boards one based on Cherry Trail Platform and 
> one on the Apollo Lake.
>
> We want for now enable only I2S output without codec on kernel 4.9/4.10.
>
> Can you give us some hint about the required ACPI asl code to add in 
> the ACPI and if there's something else required in the Linux kernel?

in theory all you need to do is enable the NOCODEC option, make sure 
that all other machine drivers are removed from the build and only add 
in ASL the bare minimum to make the audio DSP enumerate (as in make sure 
that all codecs are removed from the BIOS as well).

On Minnowboard MAX, I used this code
https://github.com/plbossart/MinnowBoardMaxFirmware/blob/master/AudioSsdtUpdate/LPEX.asl

You would need to compare with the existing BIOS since there might be 
some differences with CHT.

I have not done this work on APL and it's likely different since it's 
based on PCI.
