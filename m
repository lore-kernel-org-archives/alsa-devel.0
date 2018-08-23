From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Thu, 23 Aug 2018 21:55:22 +0000
Message-ID: <1535061320.3323.13.camel@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
 <2845fba5-1b5a-d783-dcc5-c4e4b94d47b8@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6241283755879592877=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D02E26773B
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 23:56:14 +0200 (CEST)
In-Reply-To: <2845fba5-1b5a-d783-dcc5-c4e4b94d47b8@linux.intel.com>
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
To: "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============6241283755879592877==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-klVJcS+aS17nuwQ7S+YC"

--=-klVJcS+aS17nuwQ7S+YC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-08-23 at 13:51 -0500, Pierre-Louis Bossart wrote:
> > > > > > Every time aaf->timer_fd expires, the audio buffer is
> > > > > > consumed
> > > > > > by
> > > > > > the
> > > > > > plugin, making some room available on the buffer. So here a
> > > > > > POLLIN
> > > > > > event is returned so alsa-lib layer can copy more data into
> > > > > > the
> > > > > > audio
> > > > > > buffer.
> > > > > >=20
> > > > > > > When there are two audio clock sources or timers that's
> > > > > > > usually
> > > > > > > where
> > > > > > > the fun begins.
> > > > > >=20
> > > > > > Regarding scenarios with two audio clock sources or timers,
> > > > > > the
> > > > > > plugin
> > > > > > doesn't support them at the moment. This is something we
> > > > > > should
> > > > > > work on
> > > > > > once the basic functionality is pushed upstream.
> > > > >=20
> > > > > I was talking about adjusting the relationship between your
> > > > > CLOCK_REALTIME timer and the media/network clock. I don't
> > > > > quite
> > > > > get
> > > > > how
> > > > > this happens, I vaguely recall there should be a daemon which
> > > > > tracks
> > > > > the
> > > > > difference between local and media/network clock, and I don't
> > > > > see
> > > > > it
> > > > > here.
> > > >=20
> > > > Oh okay, I thought you were talking about something else :)
> > > >=20
> > > > I believe you are referring to the gptp daemon from Openavnu
> > > > [1].
> > > > The
> > > > AAF plugin doesn't use it. Instead, it uses linuxptp [2] which
> > > > is
> > > > distributed by several Linux distros.
> > > >=20
> > > > Linuxptp provides the phc2sys daemon that synchronizes both
> > > > system
> > > > clock (i.e. CLOCK_REALTIME) and network clock (i.e. PTP clock).
> > > > The
> > > > daemon disciplines the clocks instead of providing the time
> > > > difference
> > > > to applications. So we don't need to do any cross-timestamping
> > > > at
> > > > the
> > > > plugin.
> > >=20
> > > Humm, I don't get this. The CLOCK_REALTIME is based on the local
> > > oscillator + NTP updates. And the network clock isn't necessarily
> > > owned
> > > by the transmitter, so how do you adjust?
> >=20
> > When phc2sys is running, CLOCK_REALTIME is based on local
> > oscillator +
> > phc2sys updates. The daemon keeps adjusting CLOCK_REALTIME based on
> > PTP
> > clock via clock_adjtime syscall.
>=20
> Is this a desirable "feature"? You may want to run other non-audio=20
> applications where the NTP clock makes sense, e.g. to know when your=20
> next call is, while playing audio on an external amp. Looks to me
> that=20
> you've simplified the problem too much, or this is for custom audio-
> only=20
> solutions. What am I missing?

The plugin requires both CLOCK_REALTIME and PTP to be synchronized, and
this can add some usage scenarios limitation, indeed.

However, the scenario you described looks still feasible. For instance,
at the host running as PTP master, we could have NTP disciplining
CLOCK_REALTIME (ntp daemon) and CLOCK_REALTIME disciplining PTP
(phc2sys daemon). At the hosts running as PTP slave, we have PTP
disciplining CLOCK_REALTIME (phc2sys daemon). This way, CLOCK_REALTIME
time from all systems is NTP time while CLOCK_REALTIME and PTP clock
are in sync. Makes sense?

- Andre

--=-klVJcS+aS17nuwQ7S+YC
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
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwODIzMjE1NTIwWjAjBgkqhkiG9w0BCQQxFgQUELuV
pb5Fhw+6I9ZHviwLEt5bBHAwDQYJKoZIhvcNAQEBBQAEggEAEcrwEyULE6y6HUvqyZpAS3/vevqe
yRurs5N/Nre8ykGYwPVScfnvkR6KlF0Lb2mfjYKY03zTrgnF0VVzjLe7HtRMN5K5okX4afsuC0OP
jcxZydA5r8v2QwTMbv38u9tvfZT39wnp4Urmy5t5QrEHwac1GcleoUPf2psJClz9SMrlpUfwVbVM
4mwUbIFnxSQSSthptCYONXwldG0ecyswXH5HZj9G7rIhlxJZTUX9252wSwhHyJwF4mgMwVMqu2Rk
YzXJFvGAhU4FeisKBSnGtCZRKEI9oBZhQPbpgw8BWFOpv3txT4A9rKWgq1w5JNXoLj+5rLFZb/sw
yx8JceEkYQAAAAAAAA==


--=-klVJcS+aS17nuwQ7S+YC--

--===============6241283755879592877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6241283755879592877==--
