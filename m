From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: [RFC] set up an sync channel between audio and
 display driver (i.e. ALSA and DRM)
Date: Wed, 21 May 2014 15:56:34 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C522292976@BGSMSX104.gar.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B447059@SHSMSX101.ccr.corp.intel.com>
 <1400596147.32158.36.camel@intelbox> <20140520143555.GD21128@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140520143555.GD21128@intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Koul, Vinod" <vinod.koul@intel.com>, "Deak, Imre" <imre.deak@intel.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikkanen,
 Kimmo" <kimmo.nikkanen@intel.com>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Vetter,
 Daniel" <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org

> On Tue, May 20, 2014 at 05:29:07PM +0300, Imre Deak wrote:
> > On Tue, 2014-05-20 at 05:52 +0300, Lin, Mengdong wrote:
> > > This RFC is based on previous discussion to set up a generic
> > > communication channel between display and audio driver and an
> > > internal design of Intel MCG/VPG HDMI audio driver. It's still an
> > > initial draft and your advice would be appreciated to improve the
> > > design.
> > >
> > > The basic idea is to create a new avsink module and let both drm and
> > > alsa depend on it.
> > > This new module provides a framework and APIs for synchronization
> > > between the display and audio driver.
> > >
> > > 1. Display/Audio Client
> > >
> > > The avsink core provides APIs to create, register and lookup a
> > > display/audio client.
> > > A specific display driver (eg. i915) or audio driver (eg. HD-Audio
> > > driver) can create a client, add some resources objects (shared
> > > power wells, display outputs, and audio inputs, register ops) to the
> > > client, and then register this client to avisink core. The peer
> > > driver can look up a registered client by a name or type, or both.
> > > If a client gives a valid peer client name on registration, avsink
> > > core will bind the two clients as peer for each other. And we expect
> > > a display client and an audio client to be peers for each other in a
> > > system.
> >
> > One problem we have at the moment is the order of calling the system
> > suspend/resume handlers of the display driver wrt. that of the audio
> > driver. Since the power well control is part of the display HW block,
> > we need to run the display driver's resume handler first, initialize
> > the HW, and only then let the audio driver's resume handler run. For
> > similar reasons we have to call the audio suspend handler first and
> > only then the display driver resume handler. Currently we solve this
> > using the display driver's late/early suspend/resume hooks, but we'd
> > need a more robust solution.
> >
> > This seems to be a similar issue to the load time ordering problem
> > that you describe later. Having a real device for avsync that would be
> > a child of the display device would solve the ordering issue in both
> > cases. I admit I haven't looked into it if this is feasible, but I
> > would like to see some solution to this as part of the plan.
> 
> If we are able create and mandate that HDMI display controller is parent and
> audio is child device, then this wouldn't be an issue and PM frameowrk will
> ensure parent is suspended last.
> 
If there is a scenario where HDMI audio has to active but display has to go to low power, then
parent-child device is not optimal.  There needs to be a mechanism to turn on/off individual hw blocks within
the controller.
