From: Mark Knecht <markknecht@comcast.net>
Subject: Re: VT8233/A/8235 Clock Problem - good results, some
	possible bugs?
Date: Tue, 09 Dec 2003 06:57:04 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070981824.3229.3.camel@Wizard.knechthome.com>
References: <Pine.HPX.4.33n.0312081003040.24764-100000@studcom.urz.uni-halle.de>
	 <1070914615.1921.24.camel@Wizard.knechthome.com>
	 <20031208210455.GF1802@sirius.home>
	 <1070942917.1981.67.camel@Wizard.knechthome.com>
	 <20031209102125.GB835@master.mivlgu.local>
	 <1070976470.1854.10.camel@Wizard.knechthome.com>
	 <Pine.LNX.4.58.0312091435200.20863@pnote.perex-int.cz>
	 <1070977455.1862.25.camel@Wizard.knechthome.com>
	 <Pine.LNX.4.58.0312091530010.20863@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312091530010.20863@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-12-09 at 06:31, Jaroslav Kysela wrote:
> On Tue, 9 Dec 2003, Mark Knecht wrote:

> > Then how do we explain that in dxs_support=2 my sound is so bad? I'm
> > using 44.1KHz material and supposedly everything is running at 44.1KHz. 
> 
> To be honest, we don't know at the moment. It seems that our 
> initialization of the VIA bridge might be broken for some reason and VRA 
> (variable rate) communication between this bridge and VRA capable AC'97 
> codec is not 100% correct.
> 
> 						Jaroslav
> 

Jaroslav,
   I can certainly accept that we don't know the answer yet. Without
respect to either schedule or priority, is it a goal to understand why
this is happening and to eventually get this fixed?

   I can wait for a solution. The dxs=4 option is certainly working well
enough for me right now. (I think!) I just want to know that getting
this solution is at least on the TODO list and will be addressed one of
these days.

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
