From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: bytcr_rt5640, baytrail: trying to get audio working
Date: Tue, 29 Mar 2016 21:46:26 -0500
Message-ID: <56FB3E02.2050101@linux.intel.com>
References: <56F82886.6010002@vr-web.de> <56F9C676.6000907@linux.intel.com>
 <56FB06B5.1060900@vr-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B7E542617B8
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 04:46:29 +0200 (CEST)
In-Reply-To: <56FB06B5.1060900@vr-web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Bernhard_=c3=9cbelacker?= <bernhardu@vr-web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/29/16 5:50 PM, Bernhard =DCbelacker wrote:
> Hello Pierre-Louis,
> thank you for your answers and your efforts.
>
> Kind regards,
> Bernhard
>
> PS.: Could some info from a preinstalled Android of any help?

What would help is the schematics for your board, there are so many =

variations out there that it's hard to generalize

on Baytrail devices the SSP2 is typically connected to AIF1 and SSP0 to =

AIF2. On Baytrail-CR devices the SSP0 is connected to AIF1. SSP1 is =

usually used for BT/FM.
You may want to play with the DAI links to see if you get better luck by =

swapping the codec connections.

>
>
> Am 29.03.2016 um 02:04 schrieb Pierre-Louis Bossart:
>> If you modified the interrupt order then it's a Baytrail-CR device and
>> you will need to use the firmware that makes use of SSP0 (SSP2 is not
>> connected in this package). I am working to enable SSP0 routing directly
>> without the need for a new firmware but I haven't had time to test it.
>>
>> That said, we've not been successful so far with such Baytrail-CR
>> devices. So far the issue seem to be in the SSP0-AIF2 connection; if you
>> do a loopback within the DSP things work fine. Without access to the
>> schematics and the board information it's not straightforward to solve
>> the problem.
>> Note also that Baytrail-CR devices typically use different microphones
>> and speaker settings (differential mics, mono speakers typically) so you
>> may need to add some quirks.
>
> Just for reference if someone gets here via search engine:
>
> I have tried the firmware [1] and put it under /lib/firmware/intel/fw_sst=
_0f28.bin
> with the modified interrupt order and linux 4.5.0-rc7+, entered the
> amixer sequence and the speaker-test.
>
> I saw with that also no obvious errors in dmesg.
> Interrupts are also counted.
> The clicks on device open and close are not to hear anymore.
> But unfortunately it stays silent.
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/vkoul/firmware.git/plain=
/intel/fw_sst_0f28_ssp0.bin?h=3Dbyt
>
