From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: hardware channel mixing [EMU10K1 DMA]
Date: Mon, 06 Sep 2004 21:09:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094519360.3727.13.camel@localhost>
References: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
	 <1094254221.6575.94.camel@krustophenia.net>
	 <1094260793.3727.19.camel@localhost>
	 <1094408916.4445.13.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409061347340.8854@linux.local>
	 <1094503299.29921.78.camel@krustophenia.net>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1094503299.29921.78.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,



On Mon, 2004-09-06 at 16:41, Lee Revell wrote: 
> > > It seems like if this were the case, then it would require a workaround
> > > similar to the extra voice hack.  Does this seem plausible?
> > 
> > Maybe. But it forces us to use only two periods per ring buffer.
> 
> But this is how the hardware was designed to work.  It is ALSA that is
> unusual in supporting more than 2 periods per buffer after all.  Is this
> really the only reason for the extra voice?  It is good that ALSA
> supports this, but forcing it on hardware that was not designed for it
> doesn't make sense here.

If the most effective way is to use 2 DMA subbuffers, there are software
means to emulate more periods. AFAIK, there is a Crystal CS42xx driver
using that scheme, and the Aureal driver does this too (despite the
latter supports upto 4 subbuffers).

> Supporting more than 2 periods per buffer is useless on the emu10k1
> anyway because it only works in the playback direction, which means JACK
> can only use 2 periods per buffer.  Also I was under the impression that
> more than 2 periods should only be used if 2 periods is problematic due
> to buggy hardware or system latency issues.  With the latest emu10k1
> ALSA driver and Ingo's patches these are not an issue.

IMHO, 2 periods are necessary. With only one, things get though, if not
impossible. Most hardware does not allow to manipulate the DMA registers
of a subbuffer which running.

> >  It can be
> > easy to add an extra check for this case and don't allocate extra voice
> > for it. It still might be that it won't work correctly (I think that emu
> > chips interrupt a bit earlier and not all samples are transferred via PCI
> > bus at the time).
> 
> I have only heard of this causing problems in combination with certain
> buggy VIA chipsets (KT266 and KT333).  There is a workaround available
> for Windows (google for "george breese pci latency").  It should be
> simple enough to do the same if it becomes an issue.
> 
> >  Also note that the current code uses a ccis correction
> > for the extra voice (I don't know what this is - probably some cache or
> > interpolation correction). Without complete specs describing the exact
> > hardware behaviour, it's difficult to do a proper driver design.
> 
> The OSS driver apparently does not need the extra voice.  Neither does
> the kX driver.  Presumably because both only support 2 periods per
> buffer.
> 
> Anyway, I will take a shot at fixing this and see how it works.  Worst
> case scenario I can reverse engineer kX ASIO, which I would rather not
> do because I think I have almost figured out how to get the same
> functionality from the ALSA driver without any reverse engineering.  
> 
> Eliminating the extra voice is the last major hurdle.

Well, have luck. Its never hurts to have some.

Best Regards

Manuel Jander



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
