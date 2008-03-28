From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: no front speaker sound with ALC262
Date: Fri, 28 Mar 2008 11:28:41 -0700
Message-ID: <1206728921.756.512.camel@razman>
References: <165af2360802221645p9fa6bb0y3a5573caa7bcdbd7@mail.gmail.com>
	<47BF84BF.702@versatile.com> <47BF8500.1050802@versatile.com>
	<7D68F908-875D-4EDE-B25D-CCBDD4E4A339@gmail.com>
	<s5h1w6zvrz4.wl%tiwai@suse.de> <47DEA53B.4030207@versatile.com>
	<1205778900.27317.160.camel@razman.gruemaster.com>
	<47DEC0BD.5090403@versatile.com>
	<1205781169.27317.165.camel@razman.gruemaster.com>
	<47DECB8E.7060007@versatile.com>
	<1205792180.27317.188.camel@razman.gruemaster.com>
	<47DFBF93.6060308@versatile.com> <s5hd4psw4fj.wl%tiwai@suse.de>
	<DDEF195D-07DA-480C-816E-DDF3BF0C7C90@gmail.com>
	<1206212954.6591.17.camel@razman>
	<D62EAF04-BD99-4844-8F07-A49991A5ECDD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id BCA4C24773
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 19:28:45 +0100 (CET)
In-Reply-To: <D62EAF04-BD99-4844-8F07-A49991A5ECDD@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Dohmen <acidjunk@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm still waiting for my demo unit from Tangent.  Latest update is they
think it may be a hardware issue (missing a resistor).  I should know
more Monday.  If this is the case, then the driver should work with very
minor modifications (subsystem ID addition).

Tobin


On Tue, 2008-03-25 at 11:40 +0100, Rene Dohmen wrote:

> 
> 
> Op Mar 22, 2008, om 8:09 PM heeft Tobin Davis het volgende geschreven:
> 
> 
> 
> > Rene, don't bother bugging Tangent.  I have a demo unit on the way.
> > My first priority is getting the driver working.
> > 
> > Tangent really won't help much - their a distributor, not the OEM.
> > This is an MSI Crystal 945 in a Tangent shell.
> > 
> > 
> 
> 
> I know that the system is actually a Crystal 945. I got the
> touchscreen working via a dev driver from salt (so not tangent)
> On the mainboard there is a conenctor: JFP1that goes to the ms4088
> board. The mainboard connects to:
> - power led
> - hdd led
> - speakers
> - main power switch
> 
> 
> I can provide you with some photoos if you like.
> 
> 
> As stated earlier: the sound is working by with very low volume
> levels 
> 
> 
> 
> 
> > 
> > If you want to try something, see if the bios can be reflashed with
> > the Crystal 945 firmware.
> > 
> > 
> 
> 
> I sound working with the original crystal? I don't think tangent has
> flshed their BIOS to another version.
> In the crystal 945 specs I found that the're using a Realtek ALC262
> with azalia codec, maybe this helps.
> 
> 
> Rene
> 
> 
> 
> 
> 
> > As to the speaker board, where on the main board is it mounted?  Is
> > the header labeled?  How many pins?  It sounds like the speakers may
> > be on the front panel header, which would make them function like
> > headphones.  Or this board is custom build for this application and
> > I don't know what I'm talking about.
> > 
> > Tobin
> > 
> > 
> > On Sat, 2008-03-22 at 18:59 +0100, Rene Dohmen wrote: 
> > 
> > > Hi Guys,
> > > 
> > > I'm glad t o read that there are other people with the same problem  
> > > on the same system.
> > > I just opened my Tangent 8000S and it has indeed a MSI mainboard:  
> > > MS7290. The speakers are connected to a small custom board: MS-4088
> > > There's no extra chip on this customboard and the board is directly  
> > > connected to the mainboard. So probably the signal leaving the  
> > > mainboard in amplified already. (or there's a amplifier builtin the  
> > > speakers)
> > > 
> > > Next week i'll have some time to put tangent under some more pressure  
> > > for info, so maybe that will speed up things a little bit.
> > > 
> > > Grz Rene
> > > 
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> > -- Tobin Davis 
> > 
> > 
> > love, n.:
> > 	When you don't want someone too close--because you're very sensitive
> > 	to pleasure.
> 
> 

-- 
Tobin Davis 


I can hire one half of the working class to kill the other half.
		-- Jay Gould
