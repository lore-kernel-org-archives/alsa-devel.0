From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: bytcr_rt5651 on wintron 7.0
Date: Tue, 2 Feb 2016 11:07:08 +0530
Message-ID: <20160202053707.GF11744@localhost>
References: <56AE114E.7060108@tbspace.de> <56AF72D9.6090200@linux.intel.com>
 <56AF9621.5090406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF86B26147E
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 06:33:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56AF9621.5090406@linux.intel.com>
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
Cc: Tobias =?iso-8859-1?Q?M=E4del?= <alsa-devel@tbspace.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2016 at 11:30:09AM -0600, Pierre-Louis Bossart wrote:
> On 02/01/2016 08:59 AM, Pierre-Louis Bossart wrote:
> >  =

> > On 01/31/2016 07:51 AM, Tobias M=E4del wrote:
> >> Hello,
> >>
> >> we're currently trying to get the new bytcr_rt5651 driver to run on a
> >> TrekStor SurfTab wintron 7.0 (x86 tablet).
> >>
> >> Unlike the previous driver for the rt5640 chipset, the new bytcr_rt5651
> >> driver actually detects the card out-of-the-box.
> > =

> > Good to know.
> > =

> >>
> >> This is the dmesg output on the device:
> >> bytcr_rt5651: snd-soc-dummy-dai <-> media-cpu-dai mapping ok
> >> bytcr_rt5651: snd-soc-dummy-dai <-> deepbuffer-cpu-dai mapping ok
> >> bytcr_rt5651: Invalid direction for compress P 0, C 0
> >> bytcr_rt5651: ASoC: can't create compress Compress
> >> bytcr_rt5651: ASoC: failed to instantiate card -22
> >> bytcr_rt5651: devm_snd_soc_register_card failed -22
> >> bytcr_rt5651: probe of bytcr_rt5651 failed with error -22
> >>
> >> So -- apparently it is successfully initializing 2 of the DAIs, but it
> >> can't find the Compress-DAI. My first guess would just be to try and
> >> disable the Compress DAI in the code just for debugging, but I'm sure
> >> that there's a better way.
> >>
> >> I'm running a bleeding edge kernel build from the main linux git tree,
> >> build from yesterday's github.com/torvalds/linux.git repo.
> >>
> >> Does anyone have any ideas on how to get alsa to detect the card prope=
rly?
> >>
> >> Here's the complete dmesg output:
> >> https://gist.github.com/Manawyrm/70d90e95e9c578a7fb26
> > =

> > This is weird. I checked the DSDT tables and couldn't see anything blat=
antly wrong.
> > If there was a problem with the compress DAI it would show on other pla=
tforms as well.
> > It could also be a configuration issue with bad controls, I put my UCM =
configuration on github plbosssart/UCM/, you may want to look into this as =
well.
> =

> The same issues happens with an Asus t100 with 4.5-rc2, I get the same
> message of invalid direction so it's not a codec issue but a regression on
> all Atom platforms.  The code for this direction check was added by commit
> " ASoC: compress: Fix compress device direction check"
> a1068045883ed4a18363a4ebad0c3d55e473b716pe by Vinod Koul (cc:ed), somehow
> the logic must be wrong or missing something.

No the logic is perfectly right. What we are missing is the right DAI
initialization in the driver.

While debugging recently we found that compress core code was not doing
proper justice to figure out the direction, so we fixed it up based on PCM
approach which relies on dai setting channel_min properly. We seem to have
missed that bit in driver code, so this regression.

I see Pierre has already sent a patch for this, so this should be fixed now

Thanks
-- =

~Vinod
