From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 11:40:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EED90A3.3010009@folkwang-hochschule.de>
References: <Pine.LNX.4.44.0306161025340.11284-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161025340.11284-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 16 Jun 2003, Joern Nettingsmeier wrote:
>=20
>=20
>>either i have not understood the semantics of nrpm, or nrpm  events are=
=20
>>not detected as such. when i move a slider, i always get four separate =

>>normal controller events: two on 98/99 encoding the control number as a=
=20
>>14bit value, and two on 6 and 38 encoding the data.
>>
>>the case SND_EVENT_NONREGPARAM is never reached.
>>now one of three things must be broken (in decreasing order of=20
>>likelihood): me, my wacky peavey controller, or alsa-lib.
>=20
>=20
> The driver code and alsa-lib does not handle nonreg and reg parameters.=

> They simply pass them like standard controllers, so the four event=20
> sequence is ok. I think that we may add this piece code to seq_midi_eve=
nt.c.
>=20
 > 						Jaroslav

thanks for the clarification. i'd be glad to help, but i doubt i could=20
meet the coding standards of alsa-lib. at least i could help test it.
do you or anyone of the alsa core developers have plans to tackle this=20
some time soon ? i'd love to be able to use my controller box for the=20
LinuxTag presentations in mid-July.

best,

j=F6rn


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
