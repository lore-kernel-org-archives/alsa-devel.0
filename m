From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI hotplug on Skylake when power well is off
Date: Fri, 17 Jul 2015 16:47:24 +0530
Message-ID: <20150717111724.GQ5086@localhost>
References: <55A62252.1050506@canonical.com> <s5hmvyxn0uh.wl-tiwai@suse.de>
 <20150716083908.GI5086@localhost> <55A77A8A.2080101@canonical.com>
 <s5hegk8l8lg.wl-tiwai@suse.de> <20150716113514.GL5086@localhost>
 <s5hy4igjns8.wl-tiwai@suse.de> <55A7B383.6020206@canonical.com>
 <s5hio9kjjdc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 362302606E0
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 13:15:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hio9kjjdc.wl-tiwai@suse.de>
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
Cc: libin.yang@intel.com, "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2015 at 03:57:03PM +0200, Takashi Iwai wrote:
> > >>> Yes.  This was supposed to work with WAKEEN bits, but this didn't work
> > >>> as expected, after all.
> > 
> > But this applies only to HDMI codecs and the power well, right? Analog 
> > controllers could go into D3 and WAKEEN would wake them up? Or did we 
> > never get that working either?
> 
> Well, the analog codec wakeup never worked in my tests.  Maybe some
> hardware works, who knows.
So essentialy both for analog and hdmi this never works reliably ?
I was under the impression taht this was working okay

> > Anyhow, I went searching in the video drivers for things to match on, 
> > inspired by your thoughts about submitting information from the graphics 
> > driver to the audio driver. See new attached patch (still writing blind 
> > drafts). Let me know what you think.
> 
> Thanks, this looks promising!
> 
> > I think "connector->name" seems what the most reasonable thing to export 
> > to userspace to indicate what gfx output is related to which audio nid, 
> > and the port being what maps 1-to-1 to a nid - we'll use that for our 
> > own lookup (this lookup might differ between hardware generations).
> 
> Yeah, this mapping is the unresolved mystery.  This mythos has to be
> revealed by Intel people.
Are you talking about nid to connctor name mapping or something else?

-- 
~Vinod
