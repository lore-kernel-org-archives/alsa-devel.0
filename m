From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sequencer: handling non-registered parameter
 numbers....
Date: Mon, 16 Jun 2003 18:03:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306161742010.11284-100000@pnote.perex-int.cz>
References: <200306161728.07531.david@olofson.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306161728.07531.david@olofson.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Olofson <david@olofson.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Jun 2003, David Olofson wrote:

> On Monday 16 June 2003 13.19, Jaroslav Kysela wrote:
> > On Mon, 16 Jun 2003, Jaroslav Kysela wrote:
> > > > thanks for the clarification. i'd be glad to help, but i doubt
> > > > i could meet the coding standards of alsa-lib. at least i could
> > > > help test it. do you or anyone of the alsa core developers have
> > > > plans to tackle this some time soon ? i'd love to be able to
> > > > use my controller box for the LinuxTag presentations in
> > > > mid-July.
> > >
> > > I am working on it right now, but it requires to add new states
> > > to sequencer event encoder...
> >
> > Initial code is in CVS. It is not tested, but hopefully, without
> > any major bugs.
> 
> Does this code remove the (N)RPN related CC events, or does it just 
> decode (N)RNPs in parallel? The latter will cause (N)RPNs to be 
> doubled in apps that understand both "raw" CCs and cooked (N)RPNs. 
> (Like Audiality as of a few minutes back.)
> 
> I think filtering the CCs out is the Right Thing(TM) to do when 
> (N)RPNs are actually used, but if some apps want to use the full 
> range of "raw" CCs, that won't work. Those apps won't see the (N)RPN 
> related CCs, and they won't look for (NON)REGPARAM events. (Even if 
> they did, they wouldn't be able to extract the underlying CCs 
> reliably.)
> 
> Maybe ALSA shouldn't mess with (N)RPNs at all, unless applications ask 
> for it?

I think that events are clear, so all applications using direct 
sequencer API should handle them as well.

> > It seems that we have also missing encoding of
> > CONTROL14 events.
> 
> Now *that's* fun stuff... *heh*
> 
> BTW, I think "applications might know better" applies here too. Apps 
> that want to bother with 14 bit controls might do stuff that's 
> intimately tied to the control intperpolation/smoothing. The only 
> "correct" way to implement 14 bit CCs seems to involve a timeout, 
> which will add latency to all CCs that can be 14 bit, and apps that 
> want to be smart about it to reduce latency may not be able to do so 
> without getting at the raw CCs.

Yes, Paul mentioned it and I see that the standard is not so good. Does it 
affect also XRPN encoding (some LSB or MSB bytes might be missing)?
In that case the current implementation is broken.

I see some ways to do things correctly:

1) duplicate events (deliver both raw CONTROLLER + combo events)
2) do not generate combo events at all, use only raw controller events
3) introduce timeouts (I hate this idea)

I will stay with 2) for the moment (so nothing will change).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
