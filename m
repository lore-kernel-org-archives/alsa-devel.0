From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: VT8233/A/8235 Clock Problem - good results, some
 possible bugs?
Date: Tue, 9 Dec 2003 15:31:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312091530010.20863@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
  <1070914615.1921.24.camel@Wizard.knechthome.com>  <20031208210455.GF1802@sirius.home>
  <1070942917.1981.67.camel@Wizard.knechthome.com>  <20031209102125.GB835@master.mivlgu.local>
  <1070976470.1854.10.camel@Wizard.knechthome.com>
 <Pine.LNX.4.58.0312091435200.20863@pnote.perex-int.cz>
 <1070977455.1862.25.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1070977455.1862.25.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Dec 2003, Mark Knecht wrote:

> On Tue, 2003-12-09 at 05:35, Jaroslav Kysela wrote:
> > On Tue, 9 Dec 2003, Mark Knecht wrote:
> > 
> > > I am disappointed that there is no option to set the PCM ADC to 44100 in
> > 
> > ADC is for capture not for playback.
> 
> Well, of course you are right about this. Is it 5:30AM where you are
> like it is here? (I should do more thinking!) ;-)
> 
> Thanks Jaroslav.
> 
> Then how do we explain that in dxs_support=2 my sound is so bad? I'm
> using 44.1KHz material and supposedly everything is running at 44.1KHz. 

To be honest, we don't know at the moment. It seems that our 
initialization of the VIA bridge might be broken for some reason and VRA 
(variable rate) communication between this bridge and VRA capable AC'97 
codec is not 100% correct.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
