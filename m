From: Tarek Soliman <tarek@bashasoliman.com>
Subject: Re: [PATCH] ALSA: usb-audio: define another USB ID for
 a buggy USB MIDI cable
Date: Mon, 4 Apr 2011 09:26:52 -0500
Message-ID: <20110404142652.GA3841@zeus.olympus>
References: <20110403065122.GA10770@zeus.olympus>
	<s5h62quv0h3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by alsa0.perex.cz (Postfix) with ESMTP id EF4631037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 16:26:53 +0200 (CEST)
Received: from tsoliman by zeus.olympus with local (Exim 4.72)
	(envelope-from <tsoliman@bashasoliman.com>) id 1Q6kk0-000106-S0
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 09:26:52 -0500
Content-Disposition: inline
In-Reply-To: <s5h62quv0h3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 11:18:16AM +0200, Takashi Iwai wrote:
> At Sun, 3 Apr 2011 01:51:22 -0500,
> Tarek Soliman wrote:
> > 
> > There are many USB MIDI cables out there that have buggy
> > firmware that reports it can do more than 4 bytes in a
> > packet when they can only properly handle 4
> > 
> > This patch adds the ID of yet another one of those cables
> > 
> > Signed-off-by: Tarek Soliman <tarek@bashasoliman.com>
> > ---
> >  sound/usb/midi.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > index b4b39c0..bdf5d9d 100644
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -1299,6 +1299,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi* umidi,
> >  	case USB_ID(0x0a92, 0x1020): /* ESI M4U */
> >  	case USB_ID(0x1430, 0x474b): /* RedOctane GH MIDI INTERFACE */
> >  	case USB_ID(0x15ca, 0x0101): /* Textech USB Midi Cable */
> > +	case USB_ID(0xfc08, 0x0101): /* Unknown vendor Cable */
> >  	case USB_ID(0x15ca, 0x1806): /* Textech USB Midi Cable */
> >  	case USB_ID(0x1a86, 0x752d): /* QinHeng CH345 "USB2.0-MIDI" */
> 
> The entries are sorted in the vendor id order.
> Could you fix the point to insert and resend the patch?
> 
> 
> thanks,
> 
> Takashi

I did so. It should be a new thread in the mailing list.
-- 
Tarek
