From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH - 1/1] patch_nvhdmi.c: Add missing codec
 IDs, unify names
Date: Fri, 10 Sep 2010 08:56:59 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FF9E2FE3@HQMAIL01.nvidia.com>
References: <1281415300-4372-1-git-send-email-swarren@nvidia.com>
	<s5hfwymylbt.wl%tiwai@suse.de>
	<74CDBE0F657A3D45AFBB94109FB122FF02FF9E2A8D@HQMAIL01.nvidia.com>
	<s5hsk1u1nlu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 088C8244F9
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 17:57:06 +0200 (CEST)
In-Reply-To: <s5hsk1u1nlu.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 31 Aug 2010 11:22:38 -0700,
> Stephen Warren wrote:
> >
> > Takashi Iwai wrote:
> > >
> > > At Mon,  9 Aug 2010 22:41:40 -0600,
> > > Stephen Warren wrote:
> > > >
> > > > * Add missing codec IDs.
> > > > * Modify some existing codec names for discrete GPUs to match newly
> > > >   added IDs. Note: existing names were a mixture of marketing and
> > > >   engineering GPU names. Equally, there's no reason that codec IDs
> > > >   have to be specific to a particular GPU or board, so identify
> > > >   codecs in a less marketing-oriented fashion.
> > > > * Reformat codec ID table so it's easier to read, for me at least.
> > > >
> > > > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > >
> > > Applied now as is.  It doesn't exceed too much over 80 columns ;)
> >
> > Does such a change automatically go into previous stable kernels as well as the
> > current development kernel?
> 
> If the patch contains Cc to stable@kernel.org, it'll be fed to stable
> kernel automatically.  See Documentation/stable_kernel_rules.txt.
> 
> > Or, do I/you need to specifically request this?
> 
> If you think it's mandatory for stable kernel, go ahead.
> 
> > I'm
> > hoping to get the patches for this and the previous old_pin_detect fix widely
> > distributed to solve the issues some end-users are seeing.
> 
> Honestly, If you wanted to put to stable kernel tree, you shouldn't
> have mixed the changes for codec id strings but simply added the new
> id numbers.  This would have made the changes much simpler and easier
> to  apply, so I could have put a CC to stable kernel tree by myself.
> But, merging several things into a single patch hesitated me for
> doing it.

Thinking about this some more, I'd like to see this patch in the stable
kernels; together with the "old_pin_detect" fix that's already there, it'll
solve the most pressing of current end-user issues, and provide an easy
widespread distribution of the fix.

Would it help if I resubmitted a patch intended just for the stable kernels
that simply adds the new entries and doesn't touch existing ones? If so,
which kernel should I base this off; 2.6.35.4?

Thanks for all your help.

> > > > diff --git a/pci/hda/patch_nvhdmi.c b/pci/hda/patch_nvhdmi.c
> > > > index a281836..77e2b40 100644
> > > > --- a/pci/hda/patch_nvhdmi.c
> > > > +++ b/pci/hda/patch_nvhdmi.c
> > > > @@ -540,26 +540,32 @@ static int patch_nvhdmi_2ch(struct hda_codec *codec)
> > > >   * patch entries
> > > >   */
> > > >  static struct hda_codec_preset snd_hda_preset_nvhdmi[] = {
> > > > ...
> > > > +	{ .id = 0x10de0002, .name = "MCP77/78 HDMI",  .patch = patch_nvhdmi_8ch_7x },
> > > > +	{ .id = 0x10de0003, .name = "MCP77/78 HDMI",  .patch = patch_nvhdmi_8ch_7x },
> > > > +	{ .id = 0x10de0005, .name = "MCP77/78 HDMI",  .patch = patch_nvhdmi_8ch_7x },
> > > > +	{ .id = 0x10de0006, .name = "MCP77/78 HDMI",  .patch = patch_nvhdmi_8ch_7x },
> > > > +	{ .id = 0x10de0007, .name = "MCP79/7A HDMI",  .patch = patch_nvhdmi_8ch_7x },
> > > > +	{ .id = 0x10de000a, .name = "GPU 0a HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de000b, .name = "GPU 0b HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de000c, .name = "MCP89 HDMI",     .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de000d, .name = "GPU 0d HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0010, .name = "GPU 10 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0011, .name = "GPU 11 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0012, .name = "GPU 12 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0013, .name = "GPU 13 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0014, .name = "GPU 14 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0018, .name = "GPU 18 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de0019, .name = "GPU 19 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de001a, .name = "GPU 1a HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de001b, .name = "GPU 1b HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > +	{ .id = 0x10de001c, .name = "GPU 1c HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
> > > > ...

--
nvpublic
