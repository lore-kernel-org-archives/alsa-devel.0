From: David Olofson <david@olofson.net>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Wed, 18 Jun 2003 15:41:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306181541.28163.david@olofson.net>
References: <Pine.LNX.4.44.0306161742010.11284-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161742010.11284-100000@pnote.perex-int.cz>
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

On Monday 16 June 2003 18.03, Jaroslav Kysela wrote:
[...]
> > Maybe ALSA shouldn't mess with (N)RPNs at all, unless
> > applications ask for it?
>
> I think that events are clear, so all applications using direct
> sequencer API should handle them as well.

Yes, that's a point... However, if ALSA intercepts the underlying CCs=20
for (N)RPNs, there is no way to use them as normal CCs by just=20
looking at the (NON)REGPARAM events. For examyple, if something sends=20
only CC 98 ("NRPN fine"), the app will get nothing.


[...14 bit controls...]
> Yes, Paul mentioned it and I see that the standard is not so good.
> Does it affect also XRPN encoding (some LSB or MSB bytes might be
> missing)?

Well, the "Data Entry" CC pair *is* one of those ugly 14 bit things.


> In that case the current implementation is broken.

That goes for Audiality too. Dunno if I care, because I can't really=20
do anything useful with 7 bit values anyway. I just store the other=20
CC values and act on CC 38 ("Data Entry (fine)").

I think people would expect ALSA to do the Right Thing, though -=20
whatever that is....


> I see some ways to do things correctly:
>
> 1) duplicate events (deliver both raw CONTROLLER + combo events)
> 2) do not generate combo events at all, use only raw controller
> events
> 3) introduce timeouts (I hate this idea)

Unless I'm mistaken about the (N)RPNs being normal 14 bit controllers,=20
1) would require timeouts as well - although it would allow=20
applications to bypass them by grabbing the raw CCs instead.

Either way, if that timeout isn't part of the spec, there is no way of=20
implementing this correcly. You can't wait forever, and it's not safe=20
to set it short and let occasional wrong values through. :-/


> I will stay with 2) for the moment (so nothing will change).

Ok.


BTW, what about apps sending (NON)REGPARAM events? Is it possible, and=20
if so, are they converted into CCs even when passed directly to other=20
ALSA sequencer apps?


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- The Return of Audiality! --------------------------------.
| Free/Open Source Audio Engine for use in Games or Studio. |
| RT and off-line synth. Scripting. Sample accurate timing. |
`-----------------------------------> http://audiality.org -'
   --- http://olofson.net --- http://www.reologica.se ---



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
