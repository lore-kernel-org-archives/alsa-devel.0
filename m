From: David Olofson <david@olofson.net>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 10:25:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306161025.13304.david@olofson.net>
References: <3EEC9BC6.5090603@folkwang-hochschule.de> <200306152052.05435.david@olofson.net> <3EED771D.5070803@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EED771D.5070803@folkwang-hochschule.de>
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

On Monday 16 June 2003 09.51, Joern Nettingsmeier wrote:
[...]
> > What you get is plain <control, value> tuples, and that's all
> > there is to it. (Well, it's all I *want* anyway, as I don't want
> > to do stuff that's outside the MIDI spec...)
> >
> > Here's some code, which isn't heavily tested, but does seem to do
> > the job:
>
> either i have not understood the semantics of nrpm, or nrpm  events
> are not detected as such. when i move a slider, i always get four
> separate normal controller events: two on 98/99 encoding the
> control number as a 14bit value, and two on 6 and 38 encoding the
> data.

Well, that does sound like your ALSA setup isn't parsing those CCs,=20
but just letting them through. I don't get the raw CCs at all here,=20
but I do get the decoded NRPNs. (IIRC, that's why I threw the NRPN=20
code in in the first place. I have CC parsing code for it as well,=20
but those CCs never arrived.)

I've been using an Audigy card with various ALSA drivers from 0.9.0rc6=20
and up, but I'm not entirely sure this works with versions before=20
0.9.3. The ALSA sequencer support in Audiality isn't very old, so it=20
might be that I've only used it with 0.9.3.


> the case SND_EVENT_NONREGPARAM is never reached.
> now one of three things must be broken (in decreasing order of
> likelihood): me, my wacky peavey controller, or alsa-lib.

I dunno 'bout *you*, but your code makes one suspect. ;-) If the=20
controller actually sends the CCs involved in NRPNs, it *should*=20
work, if ALSA cares to decode it - and this is a generic MIDI thing,=20
so one would assume it's done in some place like alsa-lib, rather=20
than inside drivers. I'm not sure about that, though.


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
