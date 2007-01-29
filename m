From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ice1712 IPGA and ADC controls
Date: Mon, 29 Jan 2007 17:07:34 +0000
Message-ID: <200701291657.10266.gineera@aspect135.co.uk>
References: <loom.20070120T001557-202@post.gmane.org>
	<200701282259.52583.gineera@aspect135.co.uk>
	<s5h7iv61116.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7iv61116.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 29 January 2007 12:16, you wrote:
> At Sun, 28 Jan 2007 22:59:52 +0000,
>
> Alan Horstmann wrote:
> > On Saturday 27 January 2007 12:38, John Rigg wrote:
> > > On Fri, Jan 26, 2007 at 11:26:55PM +0000, Alan Horstmann wrote:
> > > > From an analogue electronics POV this may not be a wise change. 
> > > > Adding gain usually worsens singal-to-noise ratio and other signal
> > > > parameters, and attenuation may mean avoidable gain elsewhere. So the
> > > > best operating point in general is with no gain or attenuation at the
> > > > converter.  Then the minimum of either would be used if necessary, in
> > > > conjuction with controls on the source equipment.
> > >
> > > I agree. The correct place to set input levels is in the output stage
> > > of the preceding equipment, eg. mic preamp or mixing desk output.
> > > Users of this type of equipment can reasonably be expected to know
> > > that.
> > >
> > > > Thus to achieve best performance I would think it is important to be
> > > > aware of both these controls separately.  That is what the Terratec
> > > > 'Windows' driver for my ice1712 sound card does.  If gain is needed,
> > > > for example, it may be better to add it elsewhere than at the
> > > > converter.  The 'strange' behaviour of the two controls in 1.0.12 is
> > > > in fact entirely correct and neccessary when the underlying
> > > > electronics is considered -it is vitally important to avoid gain and
> > > > attenuation together even though the effect seems the same.
> > > >
> > > > Remember that the ice1712 creates essentially a semi-pro sound
> > > > system, so the users should be aware of technical and signal
> > > > performance tradeoffs throughout their equipment (eg mixing desk,
> > > > effects units), and be able to make intelligent decisions about the
> > > > best settings of them all.  User friendliness should not override
> > > > technical quality issues in this case. It is not really a domestic
> > > > piece of kit (eg delta 1010, ews88, dsp24).
> > >
> > > Yes, absolutely. The last thing this kind of card needs is for the
> > > input signal to be degraded by changing the gain of the ADC.
> > > The user really needs to have separate control over this.
> > > Hardware mixing is a slightly different matter as it's usually only
> > > used for zero-latency monitoring when recording overdubs (ie. the mixed
> > > signal never gets recorded so a slight degradation doesn't matter).
> > >
> > > John
> >
> > (Adding to my previous posting)
> > What John and I are saying is that the driver should retain these two as
> > separate controls as they perform distinct hardware functions, inspite of
> > the similar nominal effect on gain.  There is no way for the driver to
> > ensure that any user GUI labels the dual function of a combined control
> > or will mark the '0dB' (no gain, no ADC attenuation) level of any
> > fader/control.  In this case, the two controls need to be there to tell
> > the user about the hardware, and the choices to be made about the
> > settings, rather than hiding this.  Thus I advocate reverting to the
> > 1.0.12 behaviour.
> >
> > Having separate driver controls still permits a dedicated mixer app or
> > similar to create a combined slider with suitable markings etc if that
> > were appropriate to it's target user group, though as already said, these
> > are mostly semi-pro system cards.
>
> Well, the ice1712 hardware is somehow strange.  On this chip, both the
> analog attenuation and the IPGA are connected with each other, and can
> _not_ be controlled separately.  That is, when you set analog
> attenuation to non-zero, you cannot set IPGA at all.  Similarly, if
> you set IPGA non-zero, analaog attenuation must be zero.  Hence,
> recent implementation is the straightforward implementation from the
> hardware perspective.
>
> If you want to have really separate volume bars, we can implement it
> on envy24control.  IOW, it's rater a usability issue, and putting such
> a complicated linking of two controls in the driver simply messes.

The hardware is not actually strange to an electronics engineer (or when the 
reason is understood).  The AK4524 datasheet shows that there is an analogue 
gain block first, with a minimum setting of 0dB = x1; ie it can only provide 
boost.  This drives the convertor which is followed by a digital attenuator 
(DATT), ie it can only reduce the gain.  But using post-convertor attenuation 
worsens headroom, bit-depth etc.  The manufacturers know that to use gain and  
DATT is bad, so they make sure in the chip it is prevented.  Seeing as it is 
then only possible to have one or the other but not both, the values can 
conveniently share a register.  That does not mean they consider the two 
equivalent.

I can understand that without audio hardware experience it seems a reasonable 
improvement to merge them in favour of usability.  However, those of us who 
have involvement in pro-audio are saying please don't merge these controls 
even if it makes software easier or more straightforward.  The behaviour of 
1.0.12 and previous was exactly right in helping the user be aware of 
important hardware issues (partly through the cross-coupling effect), right 
at the driver level so that it applies to any mixer used.

On these cards, the zero-gain/zero-DATT setting would be the one to use all 
the time unless unavoidable.  It needs to be not simply somewhere in the 
middle of a control range.

BTW did the change actually make it into 1.0.13?


Alan


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
