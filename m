From: David Olofson <david@olofson.net>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 17:28:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306161728.07531.david@olofson.net>
References: <Pine.LNX.4.44.0306161315300.11284-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161315300.11284-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 16 June 2003 13.19, Jaroslav Kysela wrote:
> On Mon, 16 Jun 2003, Jaroslav Kysela wrote:
> > > thanks for the clarification. i'd be glad to help, but i doubt
> > > i could meet the coding standards of alsa-lib. at least i could
> > > help test it. do you or anyone of the alsa core developers have
> > > plans to tackle this some time soon ? i'd love to be able to
> > > use my controller box for the LinuxTag presentations in
> > > mid-July.
> >
> > I am working on it right now, but it requires to add new states
> > to sequencer event encoder...
>
> Initial code is in CVS. It is not tested, but hopefully, without
> any major bugs.

Does this code remove the (N)RPN related CC events, or does it just=20
decode (N)RNPs in parallel? The latter will cause (N)RPNs to be=20
doubled in apps that understand both "raw" CCs and cooked (N)RPNs.=20
(Like Audiality as of a few minutes back.)

I think filtering the CCs out is the Right Thing(TM) to do when=20
(N)RPNs are actually used, but if some apps want to use the full=20
range of "raw" CCs, that won't work. Those apps won't see the (N)RPN=20
related CCs, and they won't look for (NON)REGPARAM events. (Even if=20
they did, they wouldn't be able to extract the underlying CCs=20
reliably.)

Maybe ALSA shouldn't mess with (N)RPNs at all, unless applications ask=20
for it?


> It seems that we have also missing encoding of
> CONTROL14 events.

Now *that's* fun stuff... *heh*

BTW, I think "applications might know better" applies here too. Apps=20
that want to bother with 14 bit controls might do stuff that's=20
intimately tied to the control intperpolation/smoothing. The only=20
"correct" way to implement 14 bit CCs seems to involve a timeout,=20
which will add latency to all CCs that can be 14 bit, and apps that=20
want to be smart about it to reduce latency may not be able to do so=20
without getting at the raw CCs.


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- The Return of Audiality! --------------------------------.
| Free/Open Source Audio Engine for use in Games or Studio. |
| RT and off-line synth. Scripting. Sample accurate timing. |
`-----------------------------------> http://audiality.org -'
   --- http://olofson.net --- http://www.reologica.se ---



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
