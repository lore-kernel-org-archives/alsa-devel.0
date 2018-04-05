From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Thu, 5 Apr 2018 12:08:33 +0530
Message-ID: <20180405063832.GA6014@localhost>
References: <1522229918-4748-1-git-send-email-vinod.koul@intel.com>
 <1522229918-4748-9-git-send-email-vinod.koul@intel.com>
 <355ca9b5-d6c4-9423-8cf6-a1c73fbdc695@sakamocchi.jp>
 <20180330060325.GA9729@kroah.com>
 <f8f97f3a-3447-5d6d-eeb6-9140ce299e06@sakamocchi.jp>
 <s5hr2nwijk5.wl-tiwai@suse.de>
 <25fffedb-4dea-e688-4005-b4ca8647d305@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B31D7267660
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 08:34:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <25fffedb-4dea-e688-4005-b4ca8647d305@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 02:03:31PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> On Apr 3 2018 21:03, Takashi Iwai wrote:
> >>>>It's better for this kind of code to be incline function in any header. In
> >>>>general, new symbols increase maintenance cost of binary of kernel-related
> >>>>stuffs. It's preferable to avoid the addition if possible, IMO.
> >>>
> >>>I don't understand, functionally it's the same, there should not be any
> >>>increased maintenance either way.  Please explain how this makes things
> >>>"harder"?
> >>
> >>Hm, if so it might be my misunderstanding to reasons for typical usage
> >>of inline functions in kernel source, sorry.
> >>
> >>In my understanding, exported symbols are put into some sections of
> >>ELF binary. Addition of new symbols increases size of the
> >>section. Additionally, after linking vmlinux, kbuild scans built-in
> >>symbols and make a file with entries of them. The addition increases
> >>time of this step. Furthermore, at the end of building kernel, kmod is
> >>called to generate some map files for exported symbols in loadable
> >>module. In a view of distributors, these files are maintained by
> >>binary packages of any type carefully because some incompatibilities
> >>can be delivered such as version mismatch.
> >>
> >>For these reasons, I think thing goes harder when people carelessly
> >>add new symbols for functions with a few codes; e.g. accessing to a
> >>member of structure, then simply check an return it. Actually I can
> >>see some examples in upstreamed headers.
> >
> >The advantage of inline function isn't about the maintenance cost.
> >It's mostly for performance, as well as the binary size reduction.
> >
> >Actually, when a kernel live-patching comes into play, an inline
> >function is worse from the maintenance POV.  Then we'd have to patch
> >every place that is expanded instead of a single place.
> >
> >However, this doesn't discourage the use of inline function, either.
> 
> I'm OK for this view, and let me add it to my criteria for my daily
> reviewing work. Thanks for sharing the view.

For us the motivation to keep as proposed was prior art. Currently all of
the snd_soc_dai_set_* APIs are doing similar functionally of setting
something on DAIs and not inlined.

Said that I agree this can be inlined so we shall do so.

> >Overall, the performance is still the most important factor for major
> >cases.  So I agree with that this particular case can be well inlined,
> >supposing that no complex code is planned to be added in future.
> 
> I agree with it as well. When developers add more complexity to content
> of the inline function, then let them convert it to exported symbols.
> 
> 
> Thanks
> 
> Takashi Sakamoto

-- 
~Vinod
