From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: ice1712 IPGA and ADC controls
Date: Sat, 27 Jan 2007 12:38:07 +0000
Message-ID: <20070127123807.GA2662@localhost.localdomain>
References: <loom.20070120T001557-202@post.gmane.org>
	<s5hbqkrf96d.wl%tiwai@suse.de>
	<loom.20070126T022638-883@post.gmane.org>
	<200701262325.33755.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200701262325.33755.gineera@aspect135.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 26, 2007 at 11:26:55PM +0000, Alan Horstmann wrote:
> In his mailing-
> 'Re: [Alsa-devel] Need help: My .asoundrc no longer works.'
> 
> On Friday 26 January 2007 01:28, Tim wrote:
> 
> > ---------------------------------
> > There is one more important issue:
> > What happened to all the input gain controls (IPGA) in the ice1712 driver?
> > With alsa-1.0.14rc2 they are gone! They don't show up in envy24control,
> >  or any other mixer I try which shows ALL alsa controls.
> > If this is an attempt to unify the IPGA and ADC controls, I agree. Carry
> > on. Anyone who has used the envy24control knows it is a bit strange.
> > If you operate the ADC controls, the IPGA controls are forced to zero,
> >  likewise if you operate the IPGA controls, the ADC controls are forced
> >  to max. Unification of the two controls would make a lot of sense.
> > But I could not seem to get them to work properly with this alsa-1.0.14rc2
> >
> > Tim.
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

I agree. The correct place to set input levels is in the output stage
of the preceding equipment, eg. mic preamp or mixing desk output.
Users of this type of equipment can reasonably be expected to know
that.

> Thus to achieve best performance I would think it is important to be aware of 
> both these controls separately.  That is what the Terratec 'Windows' driver 
> for my ice1712 sound card does.  If gain is needed, for example, it may be 
> better to add it elsewhere than at the converter.  The 'strange' behaviour of 
> the two controls in 1.0.12 is in fact entirely correct and neccessary when 
> the underlying electronics is considered -it is vitally important to avoid 
> gain and attenuation together even though the effect seems the same.
> 
> Remember that the ice1712 creates essentially a semi-pro sound system, so the 
> users should be aware of technical and signal performance tradeoffs 
> throughout their equipment (eg mixing desk, effects units), and be able to 
> make intelligent decisions about the best settings of them all.  User 
> friendliness should not override technical quality issues in this case.  It 
> is not really a domestic piece of kit (eg delta 1010, ews88, dsp24).

Yes, absolutely. The last thing this kind of card needs is for the
input signal to be degraded by changing the gain of the ADC. 
The user really needs to have separate control over this.
Hardware mixing is a slightly different matter as it's usually only used
for zero-latency monitoring when recording overdubs (ie. the mixed signal
never gets recorded so a slight degradation doesn't matter).

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
