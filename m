From: Melvin Vermeeren <mail@mel.vin>
Subject: Re: [PATCH] ALSA: dice: add stream format parameters
	for Mytek devices
Date: Mon, 21 May 2018 17:09:37 +0200
Message-ID: <6661723.mKedtcoM4l@melvin-pc>
References: <20632004.ST2tKRhYS0@melvin-pc> <2438583.1KDy1DEBS4@melvin-pc>
 <1cef1eca-3a06-e05e-765f-dfe984091085@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5832736216881679357=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 46F9F267623
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 17:09:44 +0200 (CEST)
In-Reply-To: <1cef1eca-3a06-e05e-765f-dfe984091085@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============5832736216881679357==
Content-Type: multipart/signed; boundary="nextPart11951987.5gMNFgCaIX"; micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart11951987.5gMNFgCaIX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

Sorry for the wait. Have been busy a bit.

On Saturday, 19 May 2018 10:23:30 CEST Takashi Sakamoto wrote:
> This is my first time to have discussion about transmission of PDM
> sample by IEC 61883-1/6[1][2] via IEEE 1394 bus. You can see details
> of this protocol in a document published by 1394TA[3]. For
> implementation detail, please refer to my un-upstreamed documents[4][5].

Thank you, these help a lot. I just did some quick reading and will read more 
thoroughly in the coming days as time permits. Contact with Mytek is going 
well by the way, I am expecting details from their engineer soon.

> Unfortunately, at present, IEC 61883-1/6 engine in ALSA firewire stack
> is designed for PCM samples and MIDI messages with ALSA PCM/MIDI
> interface. I removed support 16 bit PCM sample at a commit a02cb8f8def6
> ('ALSA: firewire: remove support for 16 bit PCM samples in playback
> substream')[6] in this point, because as long as I know all of
> supported models have no features to switch bit width of
> transferred/received PCM samples and my previous implementation for
> 16 bit sample brings zero-padding 24 bit PCM sample to the device.
> (Drivers in ALSA firewire stack support SNDRV_PCM_FMTBIT_S32 with
> 24 bit constraint[7].)

The commit makes perfect sense, indeed displaying only actual hardware 
capabilities instead of padding in the driver. Curiosity satisfied. :)

> In my opinion, it's hard to achieve it with quick hack to the engine
> and ALSA Dice driver. Especially for your case, one data block for
> outgoing packet to target device should include two kind data; PCM
> and PDM samples. I can see output from '/proc/asound/DSD/dice' in
> your previous message[8] includes below:
> 
> ```
> rx 0:
>    iso channel: 1
>    sequence start: 0
>    audio channels: 4
>    midi ports: 0
>    names: ANALOG L\ANALOG R\DSD1281\DSD1282\\
>    ac3 caps: 00000000
> ```
> 
> If the 'ANALOG L/R' represent data channels for two PCM samples
> and the 'DSD1281/2' represent data channels for two PDM samples,
> I can assume that one data block includes two kind of samples,
> thus two data streams of PCM/PDM samples should be multiplexed into
> one data stream of IEC 61883-1/6 packets.
> 
> For this case, I need to implement ALSA dice driver to add two PCM
> substreams in Linux system; one is for transmission of PCM samples,
> another is for transmission of PDM samples for DoP-compliant
> application. Unfortunately, current IEC 61883-1/6 engine in ALSA
> firewire stack is not designed for this case.
> 
> As an another solution, reservation of data transmission of
> IEC 61883-1/6 packet either data stream of PCM samples or data
> stream of PDM samples. In this case, implementation change can be
> smaller than multiplexing/demultiplexing these two data stream for
> data stream of IEC 61883-1/6 packets. In this solution, from
> userspace applications, two PCM substreams are available exclusively.

As you say, what may help with implementation is that, as far as I have seen 
on the market, all devices are either in PCM or PDM mode. Thus there indeed 
doesn't need to be support for sending PCM and PDM at the same time. Perhaps 
there do exist some really big units which are multiple DAC/ADC in one box 
where some streams are PCM and others are PDM at the same time, but I have not 
yet heard of such a device.

If I understand correctly, the substreams are what show up in "aplay -l" as 
subdevice. Such that "hw:DAC,0" and "hw:DAC,1" would open substream #0 and #1 
respectively. From userspace point of view I think it makes sense to expose a 
single 2-channel substream with both PCM and PDM capabilities which is then 
used in either 2ch PCM or 2ch PDM at any time, but not 1ch PCM + 1ch PDM. This 
is similar to how USB DoP DACs work I believe.

This way a playlist in music software (MPD) containing both PCM and PDM tracks 
will work on the same output. MPD can configure "allowed formats" in the 
output, but it will always convert PDM to PCM for all enabled outputs that do 
not support PDM. In case of two substreams the PCM and PDM substreams will 
then be used at the same time unless the user manually switches active input 
before and after PDM tracks. I suspect many other userspace music software 
have similar behaviour.

Also, I am not yet sure whether this specific DAC supports DoP over IEEE 1394. 
Possibly there is another format in use for PDM playback over IEEE 1394. 
Expect more details on this within the next few days.

I have not yet hacked MPD to attempt to experiment with channel mappings. I 
may still do this in the coming weeks however.

Regards,

Melvin Vermeeren
--nextPart11951987.5gMNFgCaIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETnzUjuV5O+rCrz6nRiwQnTrHuFkFAlsC4TEACgkQRiwQnTrH
uFmOLg/8DpR6bIQsJJlgkgiTjjzyNxlOcI6VPitoczx01Ti+j4RduvjROJoLAbVt
8VlKjcVn1VX9MB3I7eYU0w0cv7AbJ1hS3yfLnJQ2NF1gn2i0GBJJw4+OeEMaswGB
2mjPrCz74VFnTgwa03nxp8tO0xG+x8/WHrAqZiQG7pi/EiCwUY8E1GOg8mbINS0C
vfOnm2TfLb4eDUcQfps6p+4nbMVoTs1anawtJLBKv3DgAuo4zUfpA9RzKTha/ZOZ
DrlvbrhPcsx2AmyedaQF0sTfT74Ull1fAwmyN+sxBAyUD5EkdNzP1rQq8IhknPno
V6+tAq0OEtL4Mid/9DY9uAYi22xfXAywT5B8oDW/72OaM58NKR6z1s2Sk31H1GC/
gJPm/Xj+2MagcNBA62woi+NLdFKGaO/75Myn1e9aeqRkc+T3SYXGsAswLBNBTK0u
oashWZ/dLvCxb5s/DuA/9egO2fTkV4sMMBpv9euMeZyQBSn+in/wDs9Bpnkvf/AV
vpJwS8kPpvpPcxzYzAoNmkrQyz4S+GKvAnuQzAhNg4dXZGBUOfl1848DKYDRia8E
0SJAbQSpq4MVUreg12w39k2GNrQQnaiWS+Q2eVynZklmnVG4EJSqZ46/ybqYWXh3
fGVZJuGSe3zjS7vCCXPOIbfMqPZwKdCLKdQBq1lWrw1pCyvRl4A=
=A4Bv
-----END PGP SIGNATURE-----

--nextPart11951987.5gMNFgCaIX--




--===============5832736216881679357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5832736216881679357==--
