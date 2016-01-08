From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH 0/4] ALSA: hda - hdmi jack support for
 dynamic pcm assignment
Date: Fri, 8 Jan 2016 02:47:21 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190464D183@SHSMSX103.ccr.corp.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
 <s5hmvsjrrqo.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D190464CB4C@SHSMSX103.ccr.corp.intel.com>
 <s5hvb75he9o.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 994D5260483
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 03:47:27 +0100 (CET)
In-Reply-To: <s5hvb75he9o.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, January 07, 2016 6:32 PM
> To: Yang, Libin
> Cc: libin.yang@linux.intel.com; Lin, Mengdong; alsa-devel@alsa-
> project.org
> Subject: Re: [alsa-devel] [PATCH 0/4] ALSA: hda - hdmi jack support for
> dynamic pcm assignment
> 
> On Thu, 07 Jan 2016 02:41:13 +0100,
> Yang, Libin wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Wednesday, January 06, 2016 5:18 PM
> > > To: libin.yang@linux.intel.com
> > > Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> > > Subject: Re: [alsa-devel] [PATCH 0/4] ALSA: hda - hdmi jack support
> for
> > > dynamic pcm assignment
> > >
> > > On Thu, 31 Dec 2015 02:22:18 +0100,
> > > libin.yang@linux.intel.com wrote:
> > > >
> > > > From: Libin Yang <libin.yang@linux.intel.com>
> > > >
> > > > The patchset adds hdmi jack support for dynamic pcm assignment
> > >
> > > To which branch is this supposed to be applied?
> >
> > This is preparation for DP MST audio. And it is for hdmi-jack branch.
> 
> Do you mean my test/hdmi-jack branch?  So these are additional fixes
> on top of your former MST patches?  If yes, it should go to
> topic/hda-mst branch instead.
> 
> test/hdmi-jack branch contains two unofficial patches in addition to
> your i915 MST patches that haven't been merged yet.

Oh, I see. So it should go to topic/hda-mst branch. Thanks.

Regards,
Libin

> 
> 
> Takashi
> 
> >
> > Regards,
> > Libin
> >
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > >
> > > > Libin Yang (4):
> > > >   ALSA: Add documentation about HD-audio DP MST
> > > >   ALSA: hda - add hdmi_pcm to manage hdmi pcm related features
> > > >   ALSA: hda - hdmi jack created based on pcm
> > > >   ALSA: hda - hdmi monitor hotplug support for dynamic pcm
> > > assignment
> > > >
> > > >  Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt |  75
> > > +++++++
> > > >  sound/pci/hda/patch_hdmi.c                         | 229
> +++++++++++++++----
> > > --
> > > >  2 files changed, 243 insertions(+), 61 deletions(-)
> > > >  create mode 100644 Documentation/sound/alsa/HD-Audio-DP-
> MST-
> > > audio.txt
> > > >
> > > > --
> > > > 1.9.1
> > > >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
