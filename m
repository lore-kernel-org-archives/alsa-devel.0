From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
	mode support
Date: Fri, 7 Sep 2018 01:40:55 +0000
Message-ID: <1536284453.5394.35.camel@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
 <d553d212-d3ce-ec5f-86f3-062cd51d50ec@sakamocchi.jp>
 <1535504395.3198.7.camel@intel.com>
 <0b596f65-d71d-0999-c817-3fb76f055e95@sakamocchi.jp>
 <1535757482.23424.19.camel@intel.com>
 <163823ec-3f37-afa8-91c3-dabbe9fe31f2@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0055907756209501253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 405C4267812
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2018 03:42:15 +0200 (CEST)
In-Reply-To: <163823ec-3f37-afa8-91c3-dabbe9fe31f2@sakamocchi.jp>
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
To: "o-takashi@sakamocchi.jp" <o-takashi@sakamocchi.jp>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============0055907756209501253==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-daMzkBMW8jhwhr2sN4C5"

--=-daMzkBMW8jhwhr2sN4C5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, 2018-09-03 at 10:24 +0900, Takashi Sakamoto wrote:
> Hi,
>=20
> On Sep 1 2018 08:18, Guedes, Andre wrote:
> > > I have another concern of buffering in a perspectives of delay of
> > > task
> > > scheduling.
> > >=20
> > > The interval of task scheduling for this plugin is decided mainly
> > > by
> > > the value of 'frames_per_pkt', given by users. In your
> > > documentation,
> > > the value is 6[1]. Of cource this is an example but in this case
> > > the
> > > interval is calculated as 125us at 48.0kHz. In my opinion, task
> > > scheduling in Linux kernel brings deadline misses for the
> > > interval,
> > > in most cases such as major Linux distribution on usual personal
> > > computers. When considering about the fact that recent
> > > motherboards
> > > implements Intel I210/220 series, it's better to care for the
> > > low-
> > > level
> > > realtime systems, in my opinion.
> >=20
> > Agreed.
> >=20
> > To mitigate this scheduling issue, a follow-up patchset will extend
> > the
> > plugin to leverage the ETF qdisc [1] which will be available on
> > next
> > kernel release. The idea is: instead of sending one AVTP packet at
> > every interval, the plugin will send several AVTP packets at once,
> > configuring their Tx time accordingly, so it can "sleep" for longer
> > periods of time. The goal is to ease on task scheduling by
> > offloading  packet transmissions to the NIC.
>=20
> A feature to queue packets with a transmission timing is mandatory
> for
> applications to implement this kind of time-awareness packet
> transmission protocol on general purpose operating system which has
> less
> guarantees of its real-time capability.
>=20
> In a case of IEC 61882-1/6 on IEEE 1394 bus, controllers of 1394
> OHCI[1]
> allows applications to queue several packets to corresponding
> isochronous cycle. As a result, the controller can transfer each
> packet
> at each isochronous cycle.
>=20
>  From my curiousity, would I ask you to explain about usage of the
> ETF 'qdisk' for this kind of applications?

That patchset introduces the SO_TXTIME sockopt which enables user-space=20
applications to specify when a given packet should be transmitted. The
ETF qdisc ensures that packets from multiple user-space applications
are sent to the network controller in the right order (earlest txtime
first). The controller then sends packets to the network at the txtime
configured by the user.

In the AAF plugin case, it will prepare several AVTPDUs, configure
their txtime so the transmission interval is respected, and offload
them to the kernel/NIC.

> How relevant hardware
> guarantees timing of transmission for queued packets?

In [1] you can find some performance measurements. The highlight is
"Using so_txtime, the peak to peak jitter is about 100 nanoseconds,
independent of the period."

> Or network stack
> on Linux kernel govern the transmission timing in the proposed
> patchset?[2].

If the NIC doesn't support the scheduled transmission feature, yes, the
kernel govern the transmission.

Hope this clarifies.

Regards,

Andre

[1] https://patchwork.ozlabs.org/cover/814802/=09
--=-daMzkBMW8jhwhr2sN4C5
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
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwOTA3MDE0MDUzWjAjBgkqhkiG9w0BCQQxFgQUX/bg
I1F+8SBZgIY3xTYswwVlhWEwDQYJKoZIhvcNAQEBBQAEggEAQDogTx20WYCJE0PBzDucfWsCW196
ADQ2dAcTtYNsGiruys6b25KFOXPVdPVBYwrskp6jYf26gcdOlmpuIqkrTiwQ9U94UZV/BFHiNukR
rYVpeldsLkyONsTVTXqWN5dMOLiv70McHkDXYoy73s5/LSbAnhuLDvamld3YcsHRZoKfuyXAy/kx
3XAWsyGuMKQmLlERpda7v0+dn9eEF/writIKtuB4a7J0MqaoSQpmYDLq2EJIraOK/JrlixUfyqCI
4VWFlOFc+1ZUfMtd1E8/kaEx91f7cawfKLvzKRnWo/H+NB5ItyGS/m+E+ULy0CJAFtOrB6xRCv3c
Lm7BmZUaBQAAAAAAAA==


--=-daMzkBMW8jhwhr2sN4C5--

--===============0055907756209501253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0055907756209501253==--
