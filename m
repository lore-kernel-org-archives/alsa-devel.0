From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Wed, 01 Apr 2015 13:27:04 +0100
Message-ID: <1427891224.2711.31.camel@loki>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9327226518B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 14:27:09 +0200 (CEST)
In-Reply-To: <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Han Lu <han.lu@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-03-31 at 19:49 +0300, Tanu Kaskinen wrote:
> Reviving this thread...
> 
> On Thu, 2015-03-19 at 09:15 +0000, Liam Girdwood wrote:
> > On Wed, 2015-03-18 at 21:41 +0200, Tanu Kaskinen wrote:
> > > Hi Liam and alsa-devel,
> > > 
> > 
> > I've added a few others on the CC that would be interested.
> > 
> > > My understanding is that a UCM device can represent a thing that has 
> > > both input and output (I don't particularly like that, but it's too late 
> > > to complain). 
> > 
> > Yes, but it can also represent simplex devices too e.g.
> > "Headset-Speakers" and "Headset-Mic". There are not any hard rules here,
> > but most examples are using duplex devices as historically UCM came from
> > the phone ecosystem use cases.
> > 
> > > How likely do you think that there are or there will be 
> > > some drivers that expose separate input and output jack kcontrols for a 
> > > headset jack, to differentiate between headphones/headset/microphone? My 
> > > understanding is that jack kcontrols store only booleans, so there's no 
> > > way to distinguish between headphones and a headset with just one kcontrol.
> > > 
> > 
> > This sounds like we need to extend the jack kcontrol so that we can
> > differentiate between Headphones and Headset unless the kcontrol naming
> > was intended to differentiate and define the jack type ?
> 
> I guess it's now clear that all jack kcontrols will be booleans, and
> headset jacks will require two jack kcontrols.
> 
> > > The current UCM "spec" doesn't support specifying multiple kcontrols, 
> > > since there's only one "JackControl" value. (Perhaps the "JackDev" value 
> > > suffers from this problem too, but I don't know if jack input devices 
> > > already support reporting the state separately for input and output.)
> > > 
> > 
> > I think in this case we could define simplex UCM devices and attach a
> > JackControl value to each device.
> 
> So is your preference that UCM configuration authors are forced to
> define simplex devices to deal with headset jacks, rather than using
> duplex devices and defining "PlaybackJackControl" and
> "CaptureJackControl" separately? (I don't personally mind either way.)

I don't really mind either, but what's easier for audio servers like
pulseaudio that will be the main UCM clients ? I guess that pulseaudio,
CRAS, and other audio servers probably deal with simplex PCM streams
internally so mapping to simplex jacks/devices might be better ?

Liam
