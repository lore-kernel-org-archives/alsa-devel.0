From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [Sound-open-firmware] [GIT PULL] SOF v1.3 firmware
	binaries
Date: Wed, 31 Jul 2019 11:06:36 +0100
Message-ID: <9dc8192ebb040d30f3da85f44afffaff586e00d6.camel@linux.intel.com>
References: <af2d45578f7cdf908eb83cad3371b41315b7b5c4.camel@linux.intel.com>
 <69af4cd7-f9c2-3b2b-2774-4da1063395b2@linux.intel.com>
 <82019862aec57d5d8803fdd4270f88da409fe924.camel@linux.intel.com>
 <2f700356-1b5e-94cf-4586-f8f473dc5a85@linux.intel.com>
 <CA+5PVA6L=tcRthh+5n7PBhnqGsztaRhOujSvegykOu4vCWtfAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CA+5PVA6L=tcRthh+5n7PBhnqGsztaRhOujSvegykOu4vCWtfAQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Josh Boyer <jwboyer@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Firmware <linux-firmware@kernel.org>, SOF <sound-open-firmware@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-07-30 at 17:19 -0400, Josh Boyer wrote:
> > I don't understand what you're suggesting nor how it would work
> > with the
> > way the kernel deals with directories. I tried to explain that we
> > need
> > an intel/sof-production and intel/sof directories, each with
> > generic
> > names that are symlinked to another location. This helps if you
> > want to
> > build quirks that select one or the other capabilities by just
> > changing
> > the firmware directory prefix. Pointers below.
> > 
> > https://github.com/thesofproject/linux/blob/9d7da69a1e85db2cdbbaae78dd7eda4eeaa1eb1c/sound/soc/sof/sof-pci-dev.c#L24
> > 
> > https://github.com/thesofproject/linux/blob/9d7da69a1e85db2cdbbaae78dd7eda4eeaa1eb1c/sound/soc/sof/loader.c#L269
> > 
> > https://github.com/thesofproject/linux/blob/9d7da69a1e85db2cdbbaae78dd7eda4eeaa1eb1c/sound/soc/sof/sof-pci-dev.c#L149

So the commit did support this, but it would put all "production"
signed binaries at the intel/sof/ level via soft links (to be
automatically loaded by the driver as the default).

A subsequent commit would have added the community signed images. I
planned to link community signed binaries at the intel/sof/community
level since most users would use the production signed images by
default (and would not need to use a module param to select). My
assumption was that machines using community signed by default would
have this in their default_fw_path ?

> > 
> > I guess we need to talk off-line since we are evidently not on the
> > same
> > page or something is missing for people to use this pull request.
> 
> I suggest you guys do that.  At the moment, I'm not pulling anything
> related to this until it has a signoff from both you and Liam in the
> commit logs at a minimum.

Yep, no problem - Pierre and I will refine and resend shortly. I also
need to remove links for aliases.

Thanks

Liam
