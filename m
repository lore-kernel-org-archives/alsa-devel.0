From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [PATCH - AAF PCM plugin 0/7] Introduce AVTP Audio
 Format (AAF) plugin
Date: Wed, 10 Oct 2018 21:19:25 +0000
Message-ID: <1539206363.3120.14.camel@intel.com>
References: <20181003234547.16839-1-andre.guedes@intel.com>
 <s5hefcyxfmm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5682664427577508035=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AD1A2678D9
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 23:19:58 +0200 (CEST)
In-Reply-To: <s5hefcyxfmm.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============5682664427577508035==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-QbjYQMIEBPQgoD1sx9u8"

--=-QbjYQMIEBPQgoD1sx9u8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 2018-10-10 at 12:25 +0200, Takashi Iwai wrote:
> On Thu, 04 Oct 2018 01:45:40 +0200,
> Andre Guedes wrote:
> >=20
> > Hi all,
> >=20
> > The AAF plugin RFC series v2 has been around on alsa-devel ML for
> > more than two
> > weeks so I'm moving forward and sending it as PATCH series now.
> >=20
> > The first 5 patches from this series are pretty much the same from
> > the previous
> > version. The news are the top 2 patches which add more
> > functionality to the
> > plugin. Patch 6/7 implements the dump() callback which has been
> > useful for
> > debugging purposes and Patch 7/7 adds support for direct read/write
> > transfers.
> >=20
> > For general context information about the AAF plugin, I'm quoting
> > below the
> > cover letter from the RFC series v1:
> >=20
> > 	"This patchset introduces the AAF plugin to the alsa-plugins
> > project
> > 	which enables TSN audio applications on Linux.
> >=20
> > 	For those not familiarized with TSN, it stands for Time-
> > Sensitive
> > 	Networking, and it's a set of IEEE technologies (enhancements
> > to IEEE
> > 	802.1Q and Ethernet protocols) that provide precise time
> > 	synchronization, bounded latency and application
> > interoperability to
> > 	bridged networks. Those technologies enable time-sensitive
> > applications
> > 	such as audio, video and control loops to run on top of bridged
> > 	networks, co-existing with regular applications. TSN
> > technologies are a
> > 	super set of Audio Video Bridging (AVB) technologies also
> > developed by
> > 	IEEE. AVTP is the protocol defined to transport data in a TSN
> > system,
> > 	and AAF is one of the formats defined by AVTP to encapsulate
> > audio
> > 	data. AAF is specified in Chapter 7 from the AVTP spec [1].
> >=20
> > 	This work is part of the effort to enable TSN technologies on
> > upstream
> > 	Linux ecosystem. All building-blocks required to enable TSN
> > audio
> > 	applications have been already developed and pushed to upstream
> > 	projects. Time synchronization features are provided by
> > linuxptp
> > 	project [2], bounded latency features are provided by Linux
> > Traffic
> > 	Control subsystem since kernel version 4.15 [3], and AVTP
> > packetization
> > 	is provided by libavtp [4]. What is currently missing in the
> > ecosystem
> > 	to enable TSN audio applications is a piece of software that
> > plumbs it
> > 	all together and interfaces with Linux Audio system properly.
> > That's
> > 	the point of the AAF plugin introduced here.
> >=20
> > 	The AAF plugin is a PCM plugin that uses AVTP protocol to
> > transmit /
> > 	receive audio data through a TSN capable network.  When
> > operating in
> > 	playback mode, the plugin reads PCM samples from the audio
> > buffer,
> > 	encapsulates into AVTP packets and transmits to the network,
> > mimicking
> > 	a typical AVTP Talker. When operating in capture mode, the
> > plugin
> > 	receives AVTP packets from the network, retrieves the PCM
> > samples, and
> > 	present them to alsa-lib layer at the presentation time,
> > mimicking a
> > 	typical AVTP Listener."
> >=20
> > For further information about what has been previously discussed,
> > please refer
> > to RFC series v1 and v2 archives in [5] and [6]. Finally, all
> > versions of this
> > series can be also found in my alsa-plugins tree in github [7].
>=20
> The codes look mostly good.  I'll post just a new nitpicking later.
>=20
> But I'd like to postpone the merge until Pierre back from his
> vacation and getting some feedback from him.

Ok, thanks for letting me know. I'll address your comments locally and
wait for his feedback before pushing the v2.

> BTW, what's the good way to test this stuff locally?

The minimal setup to test the plugin requires 2 machines connected
back-to-back. The machines should be equipped with a TSN-capable NIC
that supports PTP and FQTSS features. I'm using Intel i210 NIC.

doc/aaf.txt provides detailed instructions on how to setup the PTP and
FQTSS features from the NIC as well as how to run the plugin. If you
have any trouble with the instructions, please let me know and I'll fix
it for the next series version.

Thanks,

Andre

--=-QbjYQMIEBPQgoD1sx9u8
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
52x2a8T3uObIGnrivyxT9nr1uQVMzTOK5T+T/P26lM2Ssu8ejh9BzdJXoCesZRxFlQIDAQABo4IC
LzCCAiswHQYDVR0OBBYEFKllszC+h3dLSC4MwCuy47Ms+wOxMB8GA1UdIwQYMBaAFNpBI5xaj3Gv
V4M+INPjZdsMywvbMGUGA1UdHwReMFwwWqBYoFaGVGh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9z
aXRvcnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNy
bDCBnwYIKwYBBQUHAQEEgZIwgY8wIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmludGVsLmNvbS8w
aQYIKwYBBQUHMAKGXWh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVz
L0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNydDALBgNVHQ8E
BAMCB4AwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIhsOMdYSZ5VGD/YEohY6fU4KRwAlngd69
OZXwQwIBZAIBCTAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDDDApBgkrBgEEAYI3FQoE
HDAaMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcKAwwwSQYDVR0RBEIwQKAmBgorBgEEAYI3FAIDoBgM
FmFuZHJlLmd1ZWRlc0BpbnRlbC5jb22BFmFuZHJlLmd1ZWRlc0BpbnRlbC5jb20wDQYJKoZIhvcN
AQEFBQADggEBAFdibWbC47oT6BkRNfhu1ggBf8uW7sF8GtUrPBd3UiAslPZBA7qxaiPR37BVMCFu
BXGygMxhI1CUB6bnP58CMaSrSpUl2DrXC7FUCkXhtrfC1AbvrzLJ6fYsVPCZGKLEsDPMf4ptJsRC
SpkJ+94xWURt+/wjYTpUSi0k42+WGmenTr9+Dnbaapeui8Gvhst2HXB0oe364KkWFP1e7pP9CPw4
6yi6SveqavNkU9Zr9qk3cfC2+VUAwVJNdQM9IZ36fzauQ85v4oTW5T1/cMurIw+KAcKArtIk4rUV
GEFQBOIaWrkyVuOpxEYrdZyiBtCLaaHr4PSG1aLfPy/3qUqes2sxggIXMIICEwIBATCBkDB5MQsw
CQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJ
bnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBD
QSA0QgITMwAAVOqTIPExTt7mGQAAAABU6jAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDEwMjExOTIzWjAjBgkqhkiG9w0BCQQxFgQUyqkq
q/Jab7++XLRtL/onKaNbghMwDQYJKoZIhvcNAQEBBQAEggEALCj3HUd/3HM1QXJy8tWGxnFOuhil
UjHPcBsLqm8W3/D13hECVWX4uBW+83dyZNN7+TzmW0vjl7OR4u5hj+xiYY0b+CC+o+haSZviV7QQ
EO0VrJ4ntKXVnuYKSIFrf9XtBRhndNoafN4o7P/Q9bZ9b7WjtqFpJ5zMHejx7aUbGFnwVbBVtXp0
UFDvEG8YRVdDUO4GoxIbI13L/v8Fn6ox0ddg83I20KiTmqb8FD87kDkKXMkFlZtheUDsCwyrsUy4
HhkNaEskAOH14cKP4HJUMWCGYf2fPnCip3u284doFWTGOFsr4gtmZ8KW/PZ+a12ESCJ/bzRuJUlw
KieyOlJG0QAAAAAAAA==


--=-QbjYQMIEBPQgoD1sx9u8--

--===============5682664427577508035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5682664427577508035==--
