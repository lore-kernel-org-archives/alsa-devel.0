From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Wed, 20 Feb 2013 22:40:55 +1030
Message-ID: <20130220121055.GA23804@marvin.atrad.com.au>
References: <s5hvcb7ohly.wl%tiwai@suse.de>
 <20130113043936.GA8822@marvin.atrad.com.au>
 <s5h8v7xjw4f.wl%tiwai@suse.de>
 <20130210114707.GA26574@marvin.atrad.com.au>
 <s5hzjzbql3a.wl%tiwai@suse.de>
 <20130216112505.GE4164@marvin.atrad.com.au>
 <s5h8v6ncpcp.wl%tiwai@suse.de>
 <20130217125316.GA25824@marvin.atrad.com.au>
 <s5h1ucedgge.wl%tiwai@suse.de> <s5hzjyzi8a5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 692C42625D8
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 13:11:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzjyzi8a5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 20, 2013 at 11:33:54AM +0100, Takashi Iwai wrote:
> > > > > Things which don't work or are missing:
> > > > > 
> > > > >  * "Headphone Jack Mode" lacks options to enable various "mic" or "line in"
> > > > >    modes (all of which are possible on this system)
> > > > 
> > > > Yes, it is still unimplemented.  So, it's expected not to be there
> > > > yet.  If you can hack it by yourself, let me know.
> > > 
> > > I may be able to give this a go, but from what I recall there was some
> > > debate as to how this should be implemented.  Has that been resolved yet?
> > 
> > No, we need to try to implement something and discuss later.
> > I think simply implementing two things would work: providing the vref
> > setup in Headphone Jack Mode enum, and add a pin to the Input Source.
> > User would require two setups, but it's less conflicting with giving
> > implicit dependency with each other, IMO.
> 
> FYI, sound-unstable git tree test/hda-hp-mic branch contains the new
> patches.  Pass model=fujitsu-jwse option, and all features will be
> enabled.
> 
> The patch isn't complete, but it should be somehow workable 

Sounds good - I will test in the next day or so and report back.  What's the
most efficient way to get hold of this tree / branch given that I have the
for-next branch of sound.git?  Can I somehow leverage this, or do I need to
do a completely separate checkout?  Apologies if this is a basic question -
I'm still coming to terms with git.

OOI, what's "jwse" stand for?

Regards
  jonathan
