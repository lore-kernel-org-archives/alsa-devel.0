From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sblive 4ch output w/ jack - asoundrc magic?
Date: Thu, 05 Feb 2004 20:26:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402298D2.706@folkwang-hochschule.de>
References: <40217B62.5020604@folkwang-hochschule.de> <s5had3xa7sa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had3xa7sa.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 05 Feb 2004 00:08:18 +0100,
> Joern Nettingsmeier wrote:
>=20
>>[crossposted to alsa-devel and jackit-devel]

[removed jackit-devel from cc:]

>>
>>hi *!
>>
>>i'd like to use the rear outs of my sblive platinum with jack.
>>
>>the following works:
>># aplay some.wav -Dfront &
>># aplay someother.wav -Drear
>>both signals end up at my mixer as expected, so it seems the devices=20
>>are independent.
>>
>>front is hw:0,0 which is a duplex device.
>>rear is hw:0,3 and is playback only.
>=20
> =20
> hmm?  hw:0,3 isn't for the rear output...

not?

then what is it?

and is hw:0,0 a four-channel out, two channel in device?

i've had this card for a couple of years now, and i still don't=20
understand a fraction of it...

is the relationship of in and out jacks, mixer strips and alsa=20
devices documented somewhere?


regards,

j=F6rn


--=20
"I never use EQ, never, never, never. I previously used to use mic
positioning but I've even given up on that too."
	- Jezar on http://www.audiomelody.com


J=F6rn Nettingsmeier
Kurf=FCrstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxaudiodev.org (Linux Audio Developers)





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
