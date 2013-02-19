From: Wang xingchao <xingchao.wang@linux.intel.com>
Subject: Re: [PATCH 0/3] Make HDMI ELD usable with hotplug
Date: Tue, 19 Feb 2013 10:39:55 +0800
Message-ID: <20130219023954.GA7400@wxc-intel>
References: <1361193073-7199-1-git-send-email-david.henningsson@canonical.com>
 <s5h4nh9hhi6.wl%tiwai@suse.de> <512231B9.6000408@canonical.com>
 <20130218223942.GB3605@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9629E265191
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 04:02:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130218223942.GB3605@sci.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 19, 2013 at 12:39:42AM +0200, Ville Syrj=E4l=E4 wrote:
> On Mon, Feb 18, 2013 at 02:50:49PM +0100, David Henningsson wrote:
> > On 02/18/2013 02:35 PM, Takashi Iwai wrote:
> > > At Mon, 18 Feb 2013 14:11:10 +0100,
> > > David Henningsson wrote:
> > >>
> > >> I'm experimenting with using ELD information in PulseAudio and found
> > >> that it didn't work very well with hotplugging.
> > >> Neither the proc file nor the ELD kcontrol was cleared correctly aft=
er
> > >> unplug, and there was no way (except polling) to find out when ELD
> > >> has become available.
> > >
> > > Did you try Xingchao's patch for drm/i915?  It's queued in
> > > drm-intel-next:
> > >
> > >      commit 7b9f35a6dd72f89452c58bbdbaf063027bf857ec
> > >      Author: Wang Xingchao <xingchao.wang@intel.com>
> > >      Date:   Tue Jan 22 23:25:25 2013 +0800
> > >
> > >      drm/i915: HDMI/DP - ELD info refresh support for Haswell
> > =

> > Thanks for the hint. I'm currently developing not on a Haswell machine, =

> > but an (I think) Arrandale that I bought a few years ago. So I guess =

> > this patch does not have any effect on my hw?
> =

> While reviewing that patch I asked whether we need something like that
> on other platforms. Unfortunately I didn't get a real answer. The logic
> in the patch would seem to apply equally to all platforms, not just HSW.
> We also seem to be doing silly things like flipping the ELD valid bit

Yes i agree it's a common issue should be fixed not only for HSW. In fact
i started to fix the hotplug issue when it's reported from Chromeos, and the
hardware is for Ivybridge/Sandybridge only. Later we find HSW has same prob=
lem
and we fix it too.
I donot have Arrandle HW for test/verify, but if it's same issue, i can
continue to fix it.

thanks
--xingchao
> in the register on and off a few times when we update the ELD. But I'm
> not all that familiar with the topic so take my ramblings with a pinch
> of salt.
> =

> But in any case, if you're seeing a problem with the behaviour of i915
> you should definitely report it.
> =

> -- =

> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
