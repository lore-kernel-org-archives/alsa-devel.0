From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: Re: sblive 4ch output w/ jack - asoundrc magic?
Date: Sat, 07 Feb 2004 11:56:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4024C45F.2050900@folkwang-hochschule.de>
References: <40217B62.5020604@folkwang-hochschule.de> <s5had3xa7sa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, jackit-devel <jackit-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

takashi, many thanks for your helpful reply. i'm enjoying=20
four-channel output with jack now :-D

i have added your .asound hint to

http://alsa.opensrc.org/index.php?page=3DSurroundSound

in the hope that other folks will find it useful.


best regards,

jo"rn

Takashi Iwai wrote:
> At Thu, 05 Feb 2004 00:08:18 +0100,
> Joern Nettingsmeier wrote:
>=20
>>[crossposted to alsa-devel and jackit-devel]
>>
>>hi *!
>>
>>i'd like to use the rear outs of my sblive platinum with jack.
 >
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
>=20
>=20
> Takashi

--=20
"I never use EQ, never, never, never. I previously used to use mic
positioning but I've even given up on that too."
	- Jezar on http://www.audiomelody.com


Jo"rn Nettingsmeier
Kurfu"rstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxaudiodev.org (Linux Audio Developers)





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
