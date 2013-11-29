From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 13:11:53 +0000
Message-ID: <20131129131153.GF10013@opensource.wolfsonmicro.com>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de> <20131129110549.GQ27568@sirena.org.uk>
 <20131129102937.GG8834@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 685F22655B7
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 14:11:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131129102937.GG8834@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 29, 2013 at 03:59:37PM +0530, Vinod Koul wrote:
> On Fri, Nov 29, 2013 at 11:05:49AM +0000, Mark Brown wrote:
> > On Fri, Nov 29, 2013 at 10:48:29AM +0100, Takashi Iwai wrote:
> > > Jaroslav Kysela wrote:
> > 
> > > > I basically agree, but... I believe that these chunks can be divided to
> > > > the 512 limit using continuous indexes (kcontrol->count) and a simple
> > > > rule in the driver "write all to a DSP when the last control (index) is
> > > > touched" may be enough. No API extensions are required. The question is:
> > > > Do you rellay need 100+KB for coefficients? Do you expect to handle
> > > > these data in standard tools like alsactl?
> > 
> > It's certianly possible to do something like that while maintianing the
> > ABI, however if we were going to do that we'd probably want to extend
> > alsa-lib and tinyalsa to do this transparently and devise a naming
> > scheme for the controls to trigger that behaviour.  The main thing is
> > the API offered to users.
> I think this would a bit problematic for DSPs with large controls. We are
> looking at 3 digit number already and splitting to multiple calls is going to be
> bad from a already constrained latency problem.
> 
> Most of the controls will be few KBs at most with few special cases which can be
> in MBs. I think Wolfson is also headed this way!

We certainly have stuff that transfers in the region of 30kB to
the DSPs for configuration data for some algorithms, and I
certainly wouldn't rule out larger cases in the future. At the
moment this is handled by splitting this into 512 chunks, but the
numbers of controls involved does start to feel like you are
fighting the system a little.

We haven't done a lot of investigation into the latency of this
at this time but it is certainly something that is coming up in
discussions and I would expect we will be starting to worry more
about it in the near future. I will endeavour to share what
results I can as we get into this more.

> 
> I am leading more towards adding new ioctl for this along with new ones for
> enumerating controls. Then additional support for alsa-lib and tinyalsa.
> That way existing tinymix, amxier can see these as controls while not disturbing
> existing apps. I dont think we need save and restor, then alsactl need not be
> modified.
> 
> --
> ~Vinod

It does feel a little odd to have this data set through a
different interface to other existing control data, but I guess
anything we do does have to be very careful around upsetting
existing user-space code.

Thanks,
Charles
