From: Tim <terminator356@users.sourceforge.net>
Subject: Re: ice1712 IPGA and ADC controls
Date: Sat, 27 Jan 2007 00:42:48 +0000 (UTC)
Message-ID: <loom.20070127T010503-757@post.gmane.org>
References: <loom.20070120T001557-202@post.gmane.org>
	<s5hbqkrf96d.wl%tiwai@suse.de>
	<loom.20070126T022638-883@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alan Horstmann <gineera <at> aspect135.co.uk> writes:

> On Friday 26 January 2007 01:28, Tim wrote:
> > What happened to all the input gain controls (IPGA) in the ice1712 driver?
> 
> I was intending to raise this matter myself.  In the changelog 1.0.12 to 
> 1.0.13 I noticed this:-
> 
>   + AK4XXX AD/DA converters
>     - ak4xxx - Remove bogus IPGA controls
> 
>       Remove IPGA volume controls and merge the IPGA range to ADC volume
>       controls.  These two volumes are not really independent but connected
>       simply in different ranges 0-0x7f and 0x80-max.  It doesn't make sense
>       to provide two controls.
> 
>       Since both 0x7f and 0x80 specify 0dB, a hack is needed for IPGA range
>       to skip 0x80 (increment one) for such controls.
> 
> But I could not find the changeset on Hg and was intending to ask about it.
> 
> >From an analogue electronics POV this may not be a wise change.  Adding gain 
> usually worsens singal-to-noise ratio and other signal parameters, and 
> attenuation may mean avoidable gain elsewhere. So the best operating point in 
> general is with no gain or attenuation at the converter.  Then the minimum of 
> either would be used if necessary, in conjuction with controls on the source 
> equipment.
I was going to mention this but left it out:
Sure, I agree it is important to be aware that one control is for ADC 
 attenuation and the other for input gain, but we can achieve the same
 thing with one control as long as it is labelled properly.
With the control in the exact middle (or some defined 0 reference point), 
 we would have 0db of gain (or attenuation). From there the user can adjust 
 up or down as desired.
I think the problem is poor labelling. I mean how exactly are we
 supposed to figure out the amount of gain or attenuation when
 the controls simply display "0-127" and "0-30" (or whatever it was). 
(The Windows version is the same). It should be labelled in db. 
That would be much clearer to everyone - above 0db and you're 
 introducing gain, below 0db and you're attenuating.

> Thus to achieve best performance I would think it is important to be aware of 
> both these controls separately.  That is what the Terratec 'Windows' driver 
> for my ice1712 sound card does.  If gain is needed, for example, it may be 
> better to add it elsewhere than at the converter.  The 'strange' behaviour of 
> the two controls in 1.0.12 is in fact entirely correct and neccessary when 
> the underlying electronics is considered -it is vitally important to avoid 
> gain and attenuation together even though the effect seems the same.
Actually it wouldn't let you have "gain and attenuation together", since 
 operating the IPGA controls forced the ADC controls to max, and operating 
 the ADC controls forced the IPGA controls to zero. This is why I say it
 DOES make PERFECT sense to merge them. If they allowed independent 
 adjustment, then merging would NOT be a good idea.

> 
> Remember that the ice1712 creates essentially a semi-pro sound system, so the 
> users should be aware of technical and signal performance tradeoffs 
> throughout their equipment (eg mixing desk, effects units), and be able to 
> make intelligent decisions about the best settings of them all.  User 
> friendliness should not override technical quality issues in this case.  It 
> is not really a domestic piece of kit (eg delta 1010, ews88, dsp24).
Yeah, tell me about it. I used to plug my guitar straight into my
 rackmount effects unit. Then I bought the 1010LT so I could use my effects
 unit in a send-return arrangement. Which means I now plug the guitar into
 the 1010 (thru a very $$$ Jensen-xformer-based DI box!), then send to the 
 effects unit, then return back to the 1010.
But all those little buffer and amplifier and adjustment stages on the 1010
 mean more noise by the time the signal gets to the effects unit, where
 the overdrive/distortion reeeally amplifies the extra noise. It has been 
 tough getting all the levels correct, with an acceptable noise level, but
 I have found a "happy" medium, and I'm enjoying it.

Cheers. Tim.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
