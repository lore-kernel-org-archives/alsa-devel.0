From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 09:59:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EED78E2.1050503@folkwang-hochschule.de>
References: <E19Rced-0005Jf-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19Rced-0005Jf-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>hello alsa gurus !
>>
>>i have bought a peavey studiomix midi controller on ebay, and it sends =

>>NRPN messages (non-registered parameter numbers). when i move a slider,=
=20
>>it sends the slider number encoded in 98 and 99 and the value in the=20
>>DATA ENTRY controllers 6 and 38. i would like to map these to ordinary =

>>midi controllers, or better yet, get nrpn support into ardour.
>>
>>how do i get nrpn controller values from the alsa sequencer without=20
>>having to parse the individual events and put them together by hand ?
>=20
>=20
> ardour doesn't use the sequencer.

i'm aware of that. i was planning to use a virmidi card, which ardour=20
could grab raw, and to write a little mapper that maps nrpns to=20
arbitrary normal controllers. this can be patched between the midi in=20
port and the virtual device with aconnect. (if i have understood virmidi =

devices correctly.)

> and i don't consider the nrpn messages any different from any other
> controller. from libmidi++'s persepective, there are 127 controller
> ID's, each with a value. whatever standard mapping they may have to
> gain, pan, or nrpn is completely ignored.

understood. the problem is, it won't work automatically with nrpn-based=20
controllers, since two nrpn "events" and two data entry events (yes,=20
both 14 bit) must be grouped together and transmogrified into one=20
[controller,value] tuple.

> 14 bit value support is almost impossible to provide: the midi spec is
> just ridiculous for that.=20

i wouldn't have dared to say so for lack of experience, but i had this=20
creeping feeling it might be the case. :)

maybe i should consider dropping 14-bit resolution (the crappy faders on =

the peavey hardly manage 127 distinct positions) and just use the MSB=20
part of the 14bit controller. ardour does perform lowpass filtering of=20
controller values, right ?

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
