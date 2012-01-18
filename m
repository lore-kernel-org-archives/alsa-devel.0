From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: [PATCH 4/4] snd-usb-6fire: add analog input volume
	control
Date: Wed, 18 Jan 2012 12:55:13 +0100
Message-ID: <20120118125513.d54ff1761593f50e74475351@zoho.com>
References: <134d13514f7.-5018115515449834943.-612702814653695676@zoho.com>
	<s5h1ur5jmn2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id A12662415F
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:55:21 +0100 (CET)
In-Reply-To: <s5h1ur5jmn2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jan 2012 10:28:01 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 12 Jan 2012 10:17:24 +0100,
> Torsten Schenk wrote:
> > 
> > > >  static struct __devinitdata snd_kcontrol_new elements[] = {
> > > > @@ -442,6 +497,15 @@
> > > >  		.get = usb6fire_control_digital_thru_get,
> > > >  		.put = usb6fire_control_digital_thru_put
> > > >  	},
> > > > +	{
> > > > +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> > > > +		.name = "Input 1/2 Capture Volume",
> > > > +		.index = 0,
> > > 
> > > If this is the only volume element, you don't need to add "1/2",
> > > no?
> > 
> > The problem is, that there is only an input control for 2 out of 4
> > analog input channels since channel 3 and 4 use a different ADC and
> > there doesn't seem to be a volume control on that chip. Since this
> > control only changes volume of channel 1 and 2, I wanted to have an
> > indication about that.
> 
> Well, then the question is whether you need to give a stereo control
> there.  If all I/O are supposed to be individual mono streams, it'd be
> natural to provide a mono volume control with a proper index number
> corresponding to each stream.

In fact they are paired up into stereo channels but there is no
explicit name since the inputs have different connectors,
depending on which plug is actually connected. Input 1/2 has two
cinch connectors, a microphone connector and a guitar/bass connector.
Input 3/4 has two cinch connectors (line) and two cinch connectors
(phono). Therefore I think it's not useful to separate these
into mono channels.

Torsten
