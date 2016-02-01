From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: bytcr_rt5651 on wintron 7.0
Date: Mon, 1 Feb 2016 08:59:37 -0600
Message-ID: <56AF72D9.6090200@linux.intel.com>
References: <56AE114E.7060108@tbspace.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1427726060C
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2016 15:59:40 +0100 (CET)
In-Reply-To: <56AE114E.7060108@tbspace.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Tobias_M=c3=a4del?= <alsa-devel@tbspace.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 =

On 01/31/2016 07:51 AM, Tobias M=E4del wrote:
> Hello,
> =

> we're currently trying to get the new bytcr_rt5651 driver to run on a
> TrekStor SurfTab wintron 7.0 (x86 tablet).
> =

> Unlike the previous driver for the rt5640 chipset, the new bytcr_rt5651
> driver actually detects the card out-of-the-box.

Good to know.

> =

> This is the dmesg output on the device:
> bytcr_rt5651: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
> bytcr_rt5651: snd-soc-dummy-dai <-> deepbuffer-cpu-dai mapping ok
> bytcr_rt5651: Invalid direction for compress P 0, C 0
> bytcr_rt5651: ASoC: can't create compress Compress
> bytcr_rt5651: ASoC: failed to instantiate card -22
> bytcr_rt5651: devm_snd_soc_register_card failed -22
> bytcr_rt5651: probe of bytcr_rt5651 failed with error -22
> =

> So -- apparently it is successfully initializing 2 of the DAIs, but it
> can't find the Compress-DAI. My first guess would just be to try and
> disable the Compress DAI in the code just for debugging, but I'm sure
> that there's a better way.
> =

> I'm running a bleeding edge kernel build from the main linux git tree,
> build from yesterday's github.com/torvalds/linux.git repo.
>
> Does anyone have any ideas on how to get alsa to detect the card properly?
> =

> Here's the complete dmesg output:
> https://gist.github.com/Manawyrm/70d90e95e9c578a7fb26

This is weird. I checked the DSDT tables and couldn't see anything blatantl=
y wrong.
If there was a problem with the compress DAI it would show on other platfor=
ms as well.
It could also be a configuration issue with bad controls, I put my UCM conf=
iguration on github plbosssart/UCM/, you may want to look into this as well.
-Pierre
