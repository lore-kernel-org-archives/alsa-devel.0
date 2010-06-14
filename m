From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 12:29:22 +0100
Message-ID: <201006141229.22538.gineera@aspect135.co.uk>
References: <htls4d$phr$1@dough.gmane.org> <hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net
	[62.24.128.242]) by alsa0.perex.cz (Postfix) with ESMTP id 25F612468D
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 13:29:31 +0200 (CEST)
In-Reply-To: <AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

On Monday 14 June 2010 11:46, James Courtier-Dutton wrote:
> On 14 June 2010 11:22, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> > 'Twas brillig, and James Courtier-Dutton at 14/06/10 09:56 did gyre and
> >
> > gimble:
> >> If you use "alsamixer", dB values are shown so it is easy to find the
> >> 0dB "sweet spot".
> >> I think it is pulse audio that hides this information when it combines
> >> two alsa mixer controls into one pulseaudio control.
> >
> > But it doesn't hide it. It's shown very clearly in the volume control
> > GUIs as the Base Volume.
> >
> > Do you really think that most users look at the sliders to find the 0dB
> > point? Does gnome-alsa-mixer (the old one) expose this information? No.
> > Does kmix? No. So the vast, vast majority of users do not know where the
> > 0dB point is unless they use alsamixer.... and even if the user is
> > advanced enough to use alsamixer, then I'd still say a proportion of
> > users are just looking at how far up the slider is rather than looking
> > specifically for 0dB.
> >
> > So I'd argue the exact opposite of your claim. That with the base volume
> > clearly presented in the GUI, the h/w 0dB spot is much, much more
> > obvious to the vast majority of users.
> >
> > I really think this is a vast improvement over a complex balancing act
> > of getting two different sliders setup to get distortion free audio!
> >
> > Col
>
> One has very different problems with capture than one does with playback.
> With capture it is important to identify which are analog controls
> (applied to the analog part of the circuit) and which are digital
> controls (applied to the digital part of the circuit)
> So, for capture one might wish to adjust the analog control so that
> the signal going into the ADC is a suitable level, but once the signal
> is digital, one should really not adjust it further, and just record
> what you have.
> If one was to combine these two capture controls in one PA control, it
> would just be wrong.
>
> I think there is some indication with the name of the control. It
> sometimes has "Analog" or "Digital" attached to it.
> I think this would be better if alsa reported the "Analog" or
> "Digital" as meta data, like the dB Scales.
> PA could then make more informed decisions for capture. I.e. only
> display the "Analog" controls, and hide the digital ones, setting them
> to 0dB.
> That would provide the most distortion free capture.
> I think it would also be useful if the alsa driver also reported meta
> data indicating how the controls are connected together, because then
> PA would have even more information to make better decisions.
> For example, USB audio devices have this information, but it is not
> sent to user space.

I tried unsuccessfully to argue the importance of the distinction between 
analogue and digital gain controls for capture some time ago in respect of 
ice1712 based cards fitted with 24-bit AK4524 ADAC chips (or something 
similar).  The chip provides analogue gain pre-ADC, and software attenuation 
post-ADC.  They are however set via a single register, which prevents 
needless gain+attenuation.  Originally they were exposed as 2 separate (but 
interacting) controls, giving the user the ability to set true '0dB' 
no-gain-no-software-attenuation point (for pro use).  The proposal was made 
to merge into a single control, and my view against did not prevail.  Thus 
from 1.0.14 the analogue and digital controls portions are indistinguishable 
on this card, unless you happen to know the 'magic number' that is the value 
corresponding to the transition from analogue to digital on the scale.

If a mixer app were unknowingly to consider the full-scale value to be the 
normal operating point, and scale from there, the results would be poor.

Alan
