From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 00/10] Enable HDA Codec support on Intel
 Platforms (Series2)
Date: Mon, 4 Dec 2017 08:52:30 +0530
Message-ID: <20171204032229.GZ32417@localhost>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hh8tajy3r.wl-tiwai@suse.de>
 <23319967-3571-9e8c-3077-94200bff813f@linux.intel.com>
 <s5ha7z2gqr6.wl-tiwai@suse.de> <20171203172037.GS32417@localhost>
 <780726ad-3587-1f05-89e4-800ad8ce7375@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E52CE26710B
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 04:18:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <780726ad-3587-1f05-89e4-800ad8ce7375@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 03, 2017 at 09:15:21PM -0600, Pierre-Louis Bossart wrote:
> On 12/3/17 11:20 AM, Vinod Koul wrote:
> >On Fri, Dec 01, 2017 at 09:03:25PM +0100, Takashi Iwai wrote:
> >>>>>FIXME:
> >>>>>- KConfig changes does not look right, but I could not think of any proper
> >>>>>    way without making changes into legacy HDA codec driver. So need some
> >>>>>    help on this topic.
> >>>>
> >>>>And this is another big issue.  As long as you don't allow build both,
> >>>>it never flies with distros, and it means no dramatic improvement of
> >>>>the situation, either.
> >>>>
> >>>>IOW, we have to make the codec driver working on both controller/bus
> >>>>implementations, and it essentially means to rewrite the HD-audio
> >>>>codec plumbing code.  Currently, it's a kind of half-baked state, and
> >>>>we need to cast to unified form.
> >>>
> >>>Before going into codec support, should we first deal with the
> >>>selection of the ASoC/Legacy mode for the controller side of things?
> >>>Even with basic HDMI/iDisp cases, we don't have a clean solution
> >>>today. When I worked on the late Joule platform, there was no fallback
> >>>mode which forced a recompilation depending on BIOS settings.
> >>>My understanding is that there is no support for multiple drivers
> >>>registering for the same PCI ID, I believe we'll have to define a
> >>>top-level wrapper which arbitrates internally based on BIOS settings
> >>>and user/distro preferences which mode is selected.
> >>
> >>True, we need to sort out that.  But the selection of the card-level
> >>driver can be relatively easily done in a manual way, either via
> >>blacklisting or by common module options.  Currently AMDGPU and radeon
> >>drivers are in such situation, for example.
> >>
> >>A common single switch, or at best the automatic arbitration would be
> >>preferred, of course, though.
> >
> >The switch is again short term as we should progress and move towards one
> >solution whilst deprecating the other, so that way this makes a simple
> >solution and helps in transition, change flag defaults and deprecate.
> 
> Sorry, I don't get your point. Are you saying the legacy would be
> deprecated? that was never my understanding, Rakesh's patches only make it
> easier to use the DSP in combination with an HDaudio codec, but if the DSP
> is not present the legacy is the fallback, no?

for now yes, but what prevents us from supporting coupled mode when DSP is
disabled :)

-- 
~Vinod
