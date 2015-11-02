From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: Intel: Skylake: fix missing
 machine device creation
Date: Mon, 2 Nov 2015 21:02:29 +0530
Message-ID: <20151102153229.GP21326@localhost>
References: <20151102120727.GD20228@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A8338261703
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 16:29:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151102120727.GD20228@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Omair M Abdullah <omair.m.abdullah@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 02, 2015 at 12:07:27PM +0000, Mark Brown wrote:
> On Mon, Nov 02, 2015 at 03:41:08PM +0530, Vinod Koul wrote:
> > On Sun, Nov 01, 2015 at 11:54:38AM +0900, Mark Brown wrote:
> 
> > > > The UEFI BIOS does not create a machine entry for Linux devices
> > > > so add a table style machine registration to fix this missing
> > > > entry
> 
> > > How does this relate to the existing sst_acpi code?  This might be
> > > clearer with a user...
> 
> > It is similar but sst_machines structure is entirely different. In Skylake
> > case we only need machine entry name and rest of the information is coming
> 
> So what exactly is the "machine entry name" supposed to be here and why
> don't we use any board specific information?

For this case the machine entry name is "skl_alc286s_i2s", which is the RT
ALC 286 codec combination on Skylake.
The SKL machine driver needs this as platform device and we create it here

> +static struct sst_machines sst_skl_devdata[] = {
> +	{ "INT343A", "skl_alc286s_i2s" },
> +};

This says for SKL, with codec ID "INT343A" create "skl_alc286s_i2s" machine
platform device
For different codec combination we can use codec ACPI names to match

> I'm not sure I entirely believe that this is going to work well in
> practice TBH.

This is same way used for other Intel platfroms, but agreed this is not
elegant and I am looking at removing this with the help of topology, but not
there yet so need this one for a while :)

> > I am not sure I follow the comment on user, the SKL driver here is user in
> > this
> 
> There are no machines defined for this.

sound/soc/intel/boards/skl_rt286.c

-- 
~Vinod
