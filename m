From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Mon, 06 Apr 2015 10:26:33 +0100
Message-ID: <1428312393.2616.19.camel@loki>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
 <CAN8cciaYWDECp0cP+E0i-rMbfJKn=WiEZXe0YvS9q48MmB89Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 11030260867
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2015 11:26:37 +0200 (CEST)
In-Reply-To: <CAN8cciaYWDECp0cP+E0i-rMbfJKn=WiEZXe0YvS9q48MmB89Ng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2015-04-04 at 13:39 +0800, Raymond Yau wrote:
> > >> >
> > >> > I've added a few others on the CC that would be interested.
> > >> >
> > >> > > My understanding is that a UCM device can represent a thing
> that has
> > >> > > both input and output (I don't particularly like that, but
> it's too late
> > >> > > to complain).
> > >> >
> > >> > Yes, but it can also represent simplex devices too e.g.
> > >> > "Headset-Speakers" and "Headset-Mic". There are not any hard
> rules here,
> > >> > but most examples are using duplex devices as historically UCM
> came from
> > >> > the phone ecosystem use cases.
> > >> >
> > >> > > How likely do you think that there are or there will be
> > >> > > some drivers that expose separate input and output jack
> kcontrols for a
> > >> > > headset jack, to differentiate between
> headphones/headset/microphone? My
> > >> > > understanding is that jack kcontrols store only booleans, so
> there's no
> > >> > > way to distinguish between headphones and a headset with just
> one kcontrol.
> > >> > >
> > >> >
> > >> > This sounds like we need to extend the jack kcontrol so that we
> can
> > >> > differentiate between Headphones and Headset unless the
> kcontrol naming
> > >> > was intended to differentiate and define the jack type ?
> > >>
> > >> I guess it's now clear that all jack kcontrols will be booleans,
> and
> > >> headset jacks will require two jack kcontrols.
> > >>
> > >> > > The current UCM "spec" doesn't support specifying multiple
> kcontrols,
> > >> > > since there's only one "JackControl" value. (Perhaps the
> "JackDev" value
> > >> > > suffers from this problem too, but I don't know if jack input
> devices
> > >> > > already support reporting the state separately for input and
> output.)
> > >> > >
> > >> >
> > >> > I think in this case we could define simplex UCM devices and
> attach a
> > >> > JackControl value to each device.
> > >>
> > >> So is your preference that UCM configuration authors are forced
> to
> > >> define simplex devices to deal with headset jacks, rather than
> using
> > >> duplex devices and defining "PlaybackJackControl" and
> > >> "CaptureJackControl" separately? (I don't personally mind either
> way.)
> > >
> > > I don't really mind either, but what's easier for audio servers
> like
> > > pulseaudio that will be the main UCM clients ? I guess that
> pulseaudio,
> > > CRAS, and other audio servers probably deal with simplex PCM
> streams
> > > internally so mapping to simplex jacks/devices might be better ?
> >
> > There is an advantage to having a separate device for the headphone
> and mic
> > even if they are connected to the same jack.  The user can enable
> one and not
> > the other, most commonly to use the headphones but record from the
> built-in mic,
> > ignoring the headset mic.  Because of this we require all ChromeOS
> devices to
> > support separate reporting and selection of headphone/mic on the
> headset jack.
> > There is always one UCM device and one user-visible i/o node per
> jack.
> >
> > >
> 
> How do these kind of jack handle by UCM ?
> 
> http://www.dell.com/support/home/us/en/19/product-support/product/inspiron-15-3537/manuals
> 
> 6 Headset port Connect a headphone, a microphone, or a headphone and
> microphone combo (headset).
> 

UCM is not really needed for this device as Pulseaudio handles the
standardised HDA jacks and routing (there is nothing stopping a UCM
config being defined though). So for each input/output endpoint above
you would list it's jack kcontrol in the endpoint device section. e.g.
sound server reads jack input and type, checks UCM config and matches
the device before setting routing according to UCM device.

UCM is mainly needed for non HDA devices that have different jack pins,
volume controls and routing controls. Sound servers have no way of
guessing the correct mixers and volume controls to use for non HDA
devices as they are all very different HW. 

Liam
