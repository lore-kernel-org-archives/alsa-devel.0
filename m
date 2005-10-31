From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel issue/observation
Date: Sun, 30 Oct 2005 19:50:26 -0500
Message-ID: <1130719826.32101.2.camel@mindpipe>
References: <434E7646.3000507@poeticstudios.com>
	 <5bdc1c8b0510221502v28a2cbe0ybfe049be2f34e186@mail.gmail.com>
	 <200510230053.44479.Martin.Wohlleben@gmx.de>
	 <5bdc1c8b0510221655r4d28430fr7b80f5403d8daaa4@mail.gmail.com>
	 <435AF023.70903@woh.rr.com>
	 <5bdc1c8b0510221957s278a28a7n8ead2de1e0760cf6@mail.gmail.com>
	 <435B74E9.20308@woh.rr.com>
	 <20051023180312.GA4544@mobilat.informatik.uni-bremen.de>
	 <5bdc1c8b0510231123h5ed64b38nd178ce9dfcb13f87@mail.gmail.com>
	 <1130097599.11980.54.camel@mindpipe>
	 <5bdc1c8b0510231318j4e9db7b0x1106e9b240329249@mail.gmail.com>
	 <435CFC95.6000703@vt.edu> <1130170444.16563.22.camel@mindpipe>
	 <4362CBD7.8080606@vt.edu> <1130552828.32367.66.camel@mindpipe>
	 <43656175.3040303@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43656175.3040303@vt.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rick Wright <riwright@vt.edu>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-10-30 at 19:12 -0500, Rick Wright wrote:
> 
> Lee Revell wrote: 
> > On Fri, 2005-10-28 at 21:09 -0400, Rick Wright wrote:
> >   
> > > My questions are:
> > > 1) Was there an early version(s) of this card where the side channels
> > > aren't supported by the ALSA driver?
> > >     
> > 
> > Possible.
> > 
> >   
> > > 2) Could this be made to work?
> > >     
> > 
> > Yes.
> > 
> >   
> > > 3) If so, what info is needed and who needs it?
> > >     
> > 
> > Please provide lspci output for the new card (working side channels) and
> > the old one (non working side channels).
> > 
> >   
> Attached are the outputs of lspci for both working/non-working side
> channel machines.
> 
> These machines are basically clones and the Audigy2 card is in the
> same PCI slot in both machines.
> 

Sorry I should have been more specific.  I need 
"lspci -vn | grep -A1 0401" output for both machines.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
