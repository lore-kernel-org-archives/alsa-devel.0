From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: [Alsa-devel] sblive 4ch output w/ jack - asoundrc magic?
Date: Thu, 05 Feb 2004 20:10:12 +0100
Sender: jackit-devel-admin@lists.sourceforge.net
Message-ID: <40229514.8000600@folkwang-hochschule.de>
References: <40217B62.5020604@folkwang-hochschule.de> <s5had3xa7sa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5had3xa7sa.wl@alsa2.suse.de>
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 05 Feb 2004 00:08:18 +0100,
> Joern Nettingsmeier wrote:
>=20
>>[crossposted to alsa-devel and jackit-devel]
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
>=20
> there is already a standard definition for 4.0 output, "surround40".
> so, something like below would be better:
>=20
> 	ctl.jtest {
> 		type hw
> 		card 0
> 	}
>=20
> 	pcm.jtest {
> 		type asym
> 		playback.pcm {
> 			# route for mmap workaround
> 			type route
> 			slave.pcm surround40
> 			ttable.0.0 1
> 			ttable.1.1 1
> 			ttable.2.2 1
> 			ttable.3.3 1
> 		}
> 		capture.pcm {
> 			# 2 channels only
> 			type hw
> 			card 0
> 		}
> 	}
>=20
> and run jack with -d jtest -i 2 -o 6 options.

you probably meant "-o 4", right?

works like a charm so far, many thanks!
jackd spits out a warning, though:

ALSA lib pcm.c:1168:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed:=20
Operation already in progress


i'll play with it for a while, and then i'll send it to patrick for=20
inclusion in the alsa docs...


time to play :-D

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
