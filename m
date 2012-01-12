From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: [PATCH 4/4] snd-usb-6fire: add analog input volume
	control
Date: Thu, 12 Jan 2012 10:17:24 +0100
Message-ID: <134d13514f7.-5018115515449834943.-612702814653695676@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id D2151103B54
	for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2012 10:17:27 +0100 (CET)
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

> >  static struct __devinitdata snd_kcontrol_new elements[] = {
> > @@ -442,6 +497,15 @@
> >  		.get = usb6fire_control_digital_thru_get,
> >  		.put = usb6fire_control_digital_thru_put
> >  	},
> > +	{
> > +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> > +		.name = "Input 1/2 Capture Volume",
> > +		.index = 0,
> 
> If this is the only volume element, you don't need to add "1/2", no?

The problem is, that there is only an input control for 2 out of 4
analog input channels since channel 3 and 4 use a different ADC and
there doesn't seem to be a volume control on that chip. Since this
control only changes volume of channel 1 and 2, I wanted to have an
indication about that.

Thanks,
Torsten
