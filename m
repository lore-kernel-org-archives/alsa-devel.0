From: Michael Pogrebinsky <michael.pogrebinsky@daqri.com>
Subject: Re: ASoC Sound Driver I2S over LPE,
 Intel Baytrail SoC. MinnowBoard Max
Date: Wed, 11 Nov 2015 09:53:56 -0800
Message-ID: <CAGOuWmuc+zbDc0j=24OxYRoSnMKRUwaK_sRU0QOE=WUuLERO6w@mail.gmail.com>
References: <CAGOuWmvw39beNdaLgdBGXk9rNWw9vwbFfQNSBw50KLYpGa_AHA@mail.gmail.com>
 <56423D44.60505@linux.intel.com>
 <CAGOuWmv6c+jOKjzYJNbAiMXQQP=vrT_4i8yWrPB9X_F6ek=h8g@mail.gmail.com>
 <CAGOuWmsw8OKOxLEF0bXGY8-JSdJRxFjvgm1WTHGrL700xSRR-g@mail.gmail.com>
 <564363BC.1010705@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0CB2605C0
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 18:53:59 +0100 (CET)
Received: by ioc74 with SMTP id 74so40810834ioc.2
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2015 09:53:56 -0800 (PST)
In-Reply-To: <564363BC.1010705@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: John Hawley <john.hawley@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,
Thank you for your reply,
Did you mean enabling and disabling LPSS and HDAudio in the BIOS or Kernel
config?
I checked in the BIOS and LPSS is enabled ( ACPI Mode). And I2C6 is enabled
as well.
Regarding the HDAudio - Do you mean South Cluster Configuration - >Audio
Configuration - >Audio Controller ? I see only 2 options there, LPE Audio
Support and
"Audio Controller
--Azalia VCi Enable
--Azalia Docking Support Enable
--Azalia PME Enable
--Azalia HDMI Codec"
I disabled it and it didn't make a difference,
LPE controller is enabled ( I tried both ACPI and PCI mode)

Regarding the dsdt_minnow.hex , I did not modify it, I simply run the
instruction and copied the hex file to include/.
The output of iasl command is :

iasl -tc dsdt_minnow.dsl


Intel ACPI Component Architecture

ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]

Copyright (c) 2000 - 2014 Intel Corporation


dsdt_minnow.dsl   2780:             Method (XDEP, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   2784:                     Name (_DEP, Package (0x01)

Remark   2089 -            Object is not referenced ^  (Name is within
method [XDEP])


dsdt_minnow.dsl   3570:                             Name (_T_0, Zero)

Remark   2011 -               Use of compiler reserved name ^  (_T_0)


dsdt_minnow.dsl   3672:                             Name (_T_0, Zero)

Remark   2011 -               Use of compiler reserved name ^  (_T_0)


dsdt_minnow.dsl   3774:                             Name (_T_0, Zero)

Remark   2011 -               Use of compiler reserved name ^  (_T_0)


dsdt_minnow.dsl   3876:                             Name (_T_0, Zero)

Remark   2011 -               Use of compiler reserved name ^  (_T_0)


dsdt_minnow.dsl   4607:             Method (_CRS, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   4643:             Method (GDEP, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   4647:                     Name (_DEP, Package (0x01)

Remark   2089 -            Object is not referenced ^  (Name is within
method [GDEP])


dsdt_minnow.dsl   7690:                 Method (_CRS, 0, NotSerialized)

Remark   2120 -                                   ^ Control Method should
be made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8194:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8205:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8216:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8300:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8311:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8322:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8407:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8418:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8429:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8513:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8524:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8535:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8659:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8670:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8681:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8765:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8776:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8787:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8913:             Method (SSCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8924:             Method (FMCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


dsdt_minnow.dsl   8935:             Method (FPCN, 0, NotSerialized)

Remark   2120 -                               ^ Control Method should be
made Serialized (due to creation of named objects within)


ASL Input:     dsdt_minnow.dsl - 9261 lines, 257789 bytes, 3258 keywords

AML Output:    dsdt.aml - 31359 bytes, 1147 named objects, 2111 executable
opcodes

Hex Dump:      dsdt_minnow.hex - 294325 bytes


Compilation complete. 0 Errors, 0 Warnings, 31 Remarks, 130 Optimizations


Thanks again for your help Pierre,


Michael



On Wed, Nov 11, 2015 at 7:50 AM, Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

> On 11/10/15 8:18 PM, Michael Pogrebinsky wrote:
>
>> Hi Pierre,
>> I downloaded 4.3 stable kernel, and I applied all the commits in the repo
>> you forwarded to me.
>> I'm running into an issue, where after doing those instructions:
>> "iasl -tc dsdt_minnow.dsl
>>
>> mv dsdt_minnow.hex include/
>>
>
> This is only needed if you modified dsdt_minnow.dsl. if you did, can you
> provide the log of iasl to make sure the .hex file generation goes well.
>
> the options following options need to be set in the .config
>> for the tables to be taken into account:
>>
>> CONFIG_ACPI_CUSTOM_DSDT_FILE=dsdt_minnow.hex
>> CONFIG_ACPI_CUSTOM_DSDT=y"
>>
>
> yes
>
> I am not able to boot the kernel.
>>
>
> did you try with the unmodified .hex file but those two options set?
>
> Another thing to look at is that you need to enable the LPSS (and
> specifically I2C6) and disable HDAudio in the boot menu.
>



-- 

[image: DAQRI] <http://daqri.com/>

Michael Pogrebinsky

Senior Android Developer - DAQRI Smart Helmet Applications

*Tel:* *844-327-7443*

michael.pogrebinsky@daqri.com <stephen.keegan@daqri.com>
DAQRI.com <http://daqri.com/>
