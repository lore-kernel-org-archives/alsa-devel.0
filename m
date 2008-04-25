From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] asoc tlv320aic3x: add
	more	routing	controls
Date: Fri, 25 Apr 2008 11:34:40 +0100
Message-ID: <1209119680.3286.167.camel@localhost.localdomain>
References: <20080425091809.GA18518@buzzloop.caiaq.de>
	<s5hod7yl265.wl%tiwai@suse.de>
	<20080425093040.GB18558@buzzloop.caiaq.de>
	<s5hk5iml18d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE92A24763
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 12:34:41 +0200 (CEST)
In-Reply-To: <s5hk5iml18d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-04-25 at 11:42 +0200, Takashi Iwai wrote:
> At Fri, 25 Apr 2008 11:30:40 +0200,
> Daniel Mack wrote:
> > 
> > On Fri, Apr 25, 2008 at 11:22:10AM +0200, Takashi Iwai wrote:
> > > > Add more routing controls to AIC3x chips to allow things like routing
> > > > the left PGA input to right line out.
> > > > 
> > > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > 
> > > It should be implemented rather with stereo mixer switches in
> > > general...
> > 
> > Not necessarily as left and right inputs of let's say the line input can
> > be used for entierly different things. Same is counts for the outputs. 
> > This is the case in my setup and I guess for mobile phone (what the chip
> > is made for) there will be more cases.
> > 
> > Controlling them with stereo mixers would just cause more confusion in
> > the already over-engineered chip, I fear.
> 
> Well, for such a complex system, switches don't suite well as the end
> point representation.  A switch is the easiest way to implement in a
> driver, but you'll have a mess in the end if there are too many
> switches.
> 
> We can hide these in an higher abstraction layer (e.g. alsa-lib mixer
> interface) if it were implemented.  Otherwise, think about a more
> reasonable (can be less-flexible though) setup, e.g. using enum
> controls to represent the hardware configuration intead of combination
> of lots of switches.
> 

I'm not too keen on using custom enums to represent the use cases on
embedded devices - I don't think it's very application independent. I'd
rather provide all the controls in the codec and have user space
abstract the use cases (as above) in a standard device neutral API. 

The main problem I think we have on phones is that the audio routing is
incredibly complex compared to a PC. i.e. a lot of mixers/controls have
to be changed when we have a use case change.

> Honestly, in the case of existing asoc drivers, I don't care much, and
> likely I'll let it be.  But, this is an issue we need to reconsider
> for the future development.

Fwiw, the ALSA scenario/use case library (future/current development to
handle the above abstractions) now has a public git. The code compiles,
although doesn't do much atm except parsing and storing the current
sound card state. :-/

I'm looking for some help in completing the library as it's quite low on
my todo list atm. Imo it's probably only about a couple of days work
involved (by someone knowledgeable with alsa-lib) to get something basic
working. I can give git commit access if required. Any takers ?


Liam
