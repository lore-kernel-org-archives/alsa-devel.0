From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI hotplug on Skylake when power well is off
Date: Thu, 16 Jul 2015 14:09:08 +0530
Message-ID: <20150716083908.GI5086@localhost>
References: <55A62252.1050506@canonical.com>
 <s5hmvyxn0uh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D2852661B0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 10:37:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmvyxn0uh.wl-tiwai@suse.de>
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

On Wed, Jul 15, 2015 at 12:59:02PM +0200, Takashi Iwai wrote:
> On Wed, 15 Jul 2015 11:05:22 +0200,
> David Henningsson wrote:
> > 
> > Hi,
> > 
> > I'm trying to debug an issue here where the HDMI hotplug events are not 
> > delivered to the audio side when the power well is off. This is on a 
> > Skylake machine (running in HDA mode).
> > 
> > I'm not sure whether the problem is upstream or due to my own patches 
> > while testing, so I was wondering how this is supposed to be working, so 
> > I can troubleshoot further?
> > 
> > Should there be an IRQ on the HDA controller even if the power well is 
> > off, and if not, how should the audio driver be notified that an HDMI 
> > hotplug event has happened?
> 
> I thought this has been always a problem when the runtime PM is
> enabled, no matter whether the power well state is.
Shouldn't the hotplug action turn on the power well? Then notification for
audio side should get propagated as power well is On

> 
> IMO, a cleaner solution would be rather the notifier implementation in
> software, e.g. extend the i915 component to pass the audio side ops
> for notification.
Yes that should be added but I would prefer we have hw do that as well

-- 
~Vinod
