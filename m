From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 09:51:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EED771D.5070803@folkwang-hochschule.de>
References: <3EEC9BC6.5090603@folkwang-hochschule.de> <200306152052.05435.david@olofson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306152052.05435.david@olofson.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Olofson <david@olofson.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello david !

thanks for your reply.

David Olofson wrote:
> On Sunday 15 June 2003 18.16, Joern Nettingsmeier wrote:
> [...]
>=20
>>         /*{SND_SEQ_EVENT_NONREGPARAM, extra_decode_nrpn},*/
>>         /*{SND_SEQ_EVENT_REGPARAM, extra_decode_rpn},*/
>>};
>>
>>which makes me think it might not yet be implemented....
>=20
>=20
> I'm using NRPNs to control the mixer in the current development=20
> version of Audiality, and they appear to be working just fine, and=20
> just like one would expect.
>=20
>=20
>=20
>>any hints or fine manuals around ?
>=20
>=20
> Do you need one? :-)

where did i make the impression that i have *any* clue about progamming=20
?  yes i do :)

> What you get is plain <control, value> tuples, and that's all there is =

> to it. (Well, it's all I *want* anyway, as I don't want to do stuff=20
> that's outside the MIDI spec...)
>=20
> Here's some code, which isn't heavily tested, but does seem to do the=20
> job:

either i have not understood the semantics of nrpm, or nrpm  events are=20
not detected as such. when i move a slider, i always get four separate=20
normal controller events: two on 98/99 encoding the control number as a=20
14bit value, and two on 6 and 38 encoding the data.

the case SND_EVENT_NONREGPARAM is never reached.
now one of three things must be broken (in decreasing order of=20
likelihood): me, my wacky peavey controller, or alsa-lib.

?

--=20
All Members shall refrain in their international relations from
the threat or use of force against the territorial integrity or
political independence of any state, or in any other manner
inconsistent with the Purposes of the United Nations.
	-- Charter of the United Nations, Article 2.4


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)






-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
