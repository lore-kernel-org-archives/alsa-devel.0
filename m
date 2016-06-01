From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Applied "ASoC: Intel: add bytct-rt5651 machine
 driver" to the asoc tree
Date: Wed, 1 Jun 2016 10:13:17 -0500
Message-ID: <c524cc06-caa7-6080-412b-041c9b1af386@linux.intel.com>
References: <1851514.XmzcdsvJt0@wks-pdc-gentoo>
 <2387755.MGqpljUrLg@wks-pdc-gentoo>
 <cba64f0e-9ca2-e4a6-5436-ea68cc1e9fcc@linux.intel.com>
 <4617455.AlsP6hqDsl@wks-pdc-gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4350326573C
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 17:13:19 +0200 (CEST)
In-Reply-To: <4617455.AlsP6hqDsl@wks-pdc-gentoo>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pietro <pxpert@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/1/16 3:38 AM, Pietro wrote:
> Hi,
>
>
>
> The Kernel error messages should be related to the Intel DRM graphics,
> so I don't care about them (at least for now).
>
>
>
> Anyway I don't know if tese warning can in some way be related to my
> problem:
>
>
>
> [ 9.565990] rt5651 i2c-10EC5651:00: ASoC: mux INL1 Mux has no paths
>
> [ 9.586586] rt5651 i2c-10EC5651:00: ASoC: mux INR1 Mux has no paths
>
> [ 9.586596] rt5651 i2c-10EC5651:00: ASoC: mux INL2 Mux has no paths
>
> [ 9.586601] rt5651 i2c-10EC5651:00: ASoC: mux INR2 Mux has no paths

probably the config is incorrect, I didn't enable capture in the UCM file

>
> [ 12.646035] sst-mfld-platform sst-mfld-platform: Slot control:
> codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
>
> [ 12.649356] sst-mfld-platform sst-mfld-platform: Slot control:
> codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
>
> [ 12.652673] sst-mfld-platform sst-mfld-platform: Slot control:
> codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
>
> [ 12.656323] sst-mfld-platform sst-mfld-platform: Slot control:
> codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
>
> [ 12.659868] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
> rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
>
> [ 12.663456] sst-mfld-platform sst-mfld-platform: Slot control: codec_in
> rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!

this last warning is fixed upstream.

> For your convenience I've extracted the DSDT from Android and Linux,
> because they seem to differ. Here they are:
>
>
>
> DSDT Linux: http://paste.ubuntu.com/16885538/
>
> DSDT Android: http://paste.ubuntu.com/16885557/

DSDT is OS independent so that doesn't make sense.
Just to be clear, is this an Android tablet on which you are installing 
ubuntu?
And did you try to use the firmware from upstream or from the Android 
distribution?
