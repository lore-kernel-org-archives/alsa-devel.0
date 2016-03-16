From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [pulseaudio-discuss] ASoC and pulseaudio
Date: Wed, 16 Mar 2016 20:27:04 +0530
Message-ID: <20160316145704.GU13211@localhost>
References: <1456225994.6424.35.camel@loki>
 <B51200AC81AB024499A3C2C9A1BB90A83D3AABF9@SHSMSX101.ccr.corp.intel.com>
 <1457943567.3888.18.camel@loki>
 <20160314160654.GA2566@sirena.org.uk>
 <1458021688.8522.16.camel@loki>
 <20160315084544.GF2566@sirena.org.uk>
 <s5hmvq0glxj.wl-tiwai@suse.de> <1458035331.8522.52.camel@loki>
 <s5h8u1kgj3c.wl-tiwai@suse.de> <1458039506.8522.70.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A973265B54
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 15:52:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1458039506.8522.70.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, "han.lu" <han.lu@linux.intel.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2016 at 10:58:26AM +0000, Liam Girdwood wrote:
> On Tue, 2016-03-15 at 10:56 +0100, Takashi Iwai wrote:
> > On Tue, 15 Mar 2016 10:48:51 +0100,
> > Liam Girdwood wrote:
> > > 
> > > On Tue, 2016-03-15 at 09:55 +0100, Takashi Iwai wrote:
> > > > On Tue, 15 Mar 2016 09:45:44 +0100,
> > > > Mark Brown wrote:
> > > > > 
> > > > > On Tue, Mar 15, 2016 at 06:01:28AM +0000, Liam Girdwood wrote:
> > > > > 
> > > > > > 1) Shortname is board/machine name. This can come from DMI or device
> > > > > > tree. e.g. "Asus T100"
> > > > > 
> > > > > That seems more useful for users.
> > > > > 
> > > > > > 2) Long name is 1 + driver name + optional firmware name. (I've just
> > > > > > added the FW name here too as we can have potentially > 1 FW per driver
> > > > > > - BYT is an example) e.g. "Asus T00: byt-rt5640: IntSST1.bin".
> > > > > 
> > > > > Shouldn't we use whatever we use to figure out which firmware to load
> > > > > rather than the firmware name?  Someone might do something like try to
> > > > > replace one firmware with another and get everything confused.
> > > > 
> > > 
> > > This is not to load FW for our use case, the FW name is hard coded in
> > > driver tables. We do have several FWs for the BYT driver that all have
> > > different capabilities. Userspace could set the correct config for each
> > > FW if it knew the FW that was being used.
> > > 
> > > > I agree that a consistent name would be better.  Though, practically
> > > > seen, the long name isn't persistent with many drivers, as it often
> > > > contains the irq or port numbers that are assigned dynamically.  That
> > > > said, the consistency of long name isn't strictly required.  It's
> > > > regarded rather as a verbose information to user, which shouldn't be
> > > > used as an identifier key.
> > > > 
> > > > OTOH, the driver name is the primary id key used by alsa-lib for its
> > > > configuration.  So this must be retained through versions and unique
> > > > for each configuration.
> > > > 
> > > 
> > > Ok, so we probably need to add in the board/machine name here (from DMI
> > > or DT). We currently have several x86 machines all using the same codec
> > > + DSP + FW, but all have slightly different clocking and routing that is
> > > causing problems as userspace cannot configure correctly. 
> > > 
> > > > The short name is something between them.  The alsa-lib USB-audio
> > > > config file refers to the short name because the driver doesn't
> > > > provide a unique id for driver_name for various workarounds.  But it
> > > > should be considered as an exception.  Ideally, driver_name should be
> > > > unique enough for each different configuration.
> > > 
> > > So IIUC this would mean ?
> > > 
> > > 1) short name is optional, but could be board name.
> > 
> > Right.
> > 
> > > 2) long name is driver_name plus any other optional information for the
> > > user. Not used by applications or alsa-lib to determine sound card
> > > capabilities.
> > 
> > In most cases, long name is short name + more optional information.
> > 
> > > 3) Driver name is unique. machine driver name + (optional) board name +
> > > (optional) fw name. e.g. "byt-rt5640: Asus T100: IntSST1.bin" used by
> > > alsa-lib and userspace to determine sound card and set config.
> > 
> > But, beware that driver name is fairly short, it's a 16 bytes string.
> > The short name is 32 bytes and long name is 80 bytes.  Thus, you need
> > a special care to provide a unique driver name.
> 
> Ok, that is probably too short :(
> 
> I've quickly rechecked the userspace API and we do have the
> functionality to read back the long name amongst other strings. It may
> be that we have to use the long name to specify further information.
> 
> e.g. Pulseaudio could read the long name to determine the correct UCM
> file to load for Asus 100 (instead of loading the default BYT UCM which
> may or may not work on Asus T100). 

Okay catching up on this thread now..

So I don't think FW name would help, if required we should add dev_info
to print the firmware which is getting loaded.

Now, since we have topology we should comprehend that as well. The
topology files essentially change the DSP graph and hence would required
different UCM settings so that should be added to name too. Same
hardware with different graph will need different settings..

And while thinking for it, I think it might be good to separate the SoC
and codec settings and in UCM setting for card specify the combination.
That may avoid duplicate codec setting all over the place for different
combination. I don't know if UCM supports that...

Thanks
-- 
~Vinod
