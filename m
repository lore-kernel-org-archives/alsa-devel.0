From: Anders Johansson <ajh@watri.org.au>
Subject: Re: Surround sound and volume control question
Date: Tue, 10 Oct 2006 09:54:05 +0800
Message-ID: <20061010015405.GA8676@watri.org.au>
References: <20061008222726.GA23855@nevyn.them.org>
	<s5hiritr4nm.wl%tiwai@suse.de>
	<20061009134539.GA13343@nevyn.them.org>
	<1160402124.629.16.camel@mindpipe>
	<20061009143814.GA14827@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061009143814.GA14827@nevyn.them.org>
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

Hi,

Just wanted to give you some input from a user of the more advanced
features of alsa volume controls. I am running an acoustic lab at the
University of Western Australia. I have previously helped out in alsa
to reverse engineer a sound card and fix some minor bugs. We use
alsa/jack to do sound recordings and to implement realtime audio
processing algorithms where the absolute relationship between the
volume level and the voltage level at the sound card output must be
known. Currently I have had to reverse engineer the A/D - D/A and
driver to work out this relationship and write card specific functions
to set the volume levels for the soundcard output.

If you are making changes to the volume controls, the most valuable
feature to the kind of work I am doing would be the ability to set the
volume level in volts individually for each channel. Whatever you do
please don't hide the actual analog gain settings behind software gain
settings, it would make my work very difficult.

Cheers,
//Anders



> On Mon, Oct 09, 2006 at 09:55:23AM -0400, Lee Revell wrote:
> > On Mon, 2006-10-09 at 09:45 -0400, Daniel Jacobowitz wrote:
> > > > alsactl save & restore should work for softvol.
> > > > The softvol mixer element doesn't exist only at the very fresh state.
> > > 
> > > I see, I just tried it and alsactl will create a user control just
> > > fine.  That's great.
> > > 
> > > I will give the softvol solution a try, and post the patches if it
> > > works.
> > > 
> > 
> > Isn't it inefficient to force all audio to go through a software volume
> > control just to have a master volume?  Wouldn't it be better to make a
> > ganged control in the driver (until the alsa-lib abstract mixer layer is
> > ready)?
> 
> I did consider doing it this way over the weekend.  However, being able
> to adjust the relative volumes of the different channels still seems
> useful to me.  If you have a single unified control, then you mess up
> trying to move the others.
> 
> What do you think?  Should I just slave them all together and remove
> the other volume controls?  It's probably easier; it just seems somehow
> lacking.




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
