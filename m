From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
	mode support
Date: Wed, 29 Aug 2018 01:00:14 +0000
Message-ID: <1535504395.3198.7.camel@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
 <d553d212-d3ce-ec5f-86f3-062cd51d50ec@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7640105514323236155=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C6D5026781F
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 03:00:27 +0200 (CEST)
In-Reply-To: <d553d212-d3ce-ec5f-86f3-062cd51d50ec@sakamocchi.jp>
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

--===============7640105514323236155==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-2oRUSx/EaYWhjOTSywfE"

--=-2oRUSx/EaYWhjOTSywfE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Sat, 2018-08-25 at 17:13 +0900, Takashi Sakamoto wrote:
> On Aug 24 2018 03:32, Guedes, Andre wrote:
> > On Wed, 2018-08-22 at 21:25 -0500, Pierre-Louis Bossart wrote:
> > > On 08/22/2018 07:46 PM, Guedes, Andre wrote:
> > > > On Tue, 2018-08-21 at 17:51 -0500, Pierre-Louis Bossart wrote:
> > > > > > > > +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
> > > > > > > > +{
> > > > > > > > +	int res;
> > > > > > > > +	struct timespec now;
> > > > > > > > +	struct itimerspec itspec;
> > > > > > > > +	snd_pcm_ioplug_t *io =3D &aaf->io;
> > > > > > > > +
> > > > > > > > +	res =3D clock_gettime(CLOCK_REF, &now);
> > > > > > > > +	if (res < 0) {
> > > > > > > > +		SNDERR("Failed to get time from
> > > > > > > > clock");
> > > > > > > > +		return -errno;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	aaf->mclk_period =3D (NSEC_PER_SEC * aaf-
> > > > > > > > > frames_per_pkt) /
> > > > > > > >=20
> > > > > > > > io->rate;
> > > > > > >=20
> > > > > > > is this always an integer? If not, don't you have a
> > > > > > > systematic
> > > > > > > arithmetic error?
> > > > > >=20
> > > > > > NSEC_PER_SEC is 64-bit so I don't see an arithmetic error
> > > > > > during
> > > > > > calculation (e.g. integer overflow). Not sure this was your
> > > > > > concern,
> > > > > > though. Let me know otherwise.
> > > > >=20
> > > > > No, I was talking about the fractional part, e.g with 256
> > > > > frames
> > > > > with
> > > > > 44.1kHz you have a period of 5804988.662131519274376 - so
> > > > > your
> > > > > math
> > > > > adds
> > > > > a truncation. same with 48khz, the fractional part is .333
> > > > >=20
> > > > > I burned a number of my remaining neurons chasing a <100 ppb
> > > > > error
> > > > > which
> > > > > led to underruns after 10 hours, so careful now with
> > > > > truncation...
> > > >=20
> > > > Thanks for clarifying.
> > > >=20
> > > > Yes, we can end up having a fractional period which is
> > > > truncated.
> > > > Note
> > > > that both 'frames' and 'rate' are configured by the user. The
> > > > user
> > > > should set 'frames' as multiple of 'rate' whenever possible to
> > > > avoid
> > > > inaccuracy.
> > >=20
> > > It's unlikely to happen. it's classic in audio that people want
> > > powers
> > > of two for fast filtering, and don't really care that the periods
> > > are
> > > fractional. If you cannot guarantee long-term operation without
> > > timing
> > > issues, you should add constraints to the frames and rates so
> > > that
> > > there
> > > is no surprise.
> >=20
> > Fair enough. So for now I'll add a constraint on frames and rates
> > to
> > unsure no surprises. Later we can revisit this and implement the
> > compesation mechanism you described below.
>=20
> In my understanding, transmission timing of 'AVTP Audio format' in
> IEEE
> 1722:2016 is similar to 'blocking transmission' of IEC 61883-6.
> Packets
> have fixed size of data in its payload, thus include the same number
> of
> PCM frames. Talkers are expected to fill data till the size, then
> transmit the packet. Receivers are expected to perform buffering till
> presentation timestamp is elapsed, with one (or more) AVTPDUs.

I'm not familiar with the 'blocking transmission' of IEC 61883-6 but
from the description above, yes, it looks similar indeed.

> In clause 7.7 'AAF and SRP', I can see below sentence:
> '... A 44.1-kHz stream with 6 samples per AAF AVTPDU and an FQTSS
> observation interval of 125 us also has an SRP reservation of 1
> frame=20
> per observation interval even though there will periodically be an
> observation interval where no AAF AVTPDU will be transmitted since
> it has a transmission interval of 136.054 us as can be seen in the
> example given in Figure 36.' This means that packet transmission is
> not always periodically. There's a blank cycle per several cycles;
> like
> IEC 61883-1/6.

My understanding of the periodicity of packet transmission is
different. I believe it is always periodic. Let me elaborate on this.

The first paragraph from Section 7.7 states that "AAF transmission
interval is defined by the clock rate of the media rather than the
FQTSS observation interval." Since the clock is periodic, the AAF
transmission interval is periodic too. For instance, if we take the
44.1 kHz example from Figure 36, we can see the AAF transmission
interval is always ~136us. So, from AAF perspective (i.e. the plugin
perspective), the packet transmission is always periodic.

The AAF transmission interval isn't necessarily equal to the FQTSS
observation interval. Again, if we take a look at the 44.1 kHz example,
we can see the AAF transmission interval is ~136us while the FQTSS
observation interval is 125us.  This, however, isn't an issue since the
plugin is not expected to operate in terms of FQTSS observation
interval, but in terms of AAF transmission interval as stated in the
first paragraph from Section 7.7.

> In my opinion, it's better calculate proper interval of timerfd to
> create the black interval, without truncate the fraction. Then, give
> proper constrains to SND_PCM_IOPLUG_HW_PERIOD_BYTES to prevent
> applications from underrun.

If the above understanding is correct, I'm not sure this approach would
work. Let me know otherwise.

> Furthermore, in your proposal, the number of PCM frames in one AVTPDU
> is
> decided according to plugin parameter. However, if compliant to
> specification, it's better to decide the number according to 'FQTSS
> observation interval'. I can see recommendations in two cases;
> FQTSS =3D 125 us and 256 us, in Table 17 and 18 of IEEE 1212:2016.

It was designed that way on purpose. Let me share the rationale.

The values in Table 17 and 18 are just recommendations. From the plugin
perspective, we should enable users to configure the number of frames
according to their needs. This way, users are free to configure the
values recommended by the spec or other values optimized to their AVTP
application.

Besides that, as stated in the NOTE right below Table 18, 125us and
250us are not the only possible FQTSS observation intervals.

Thank you for your input.

Regards,

Andre

--=-2oRUSx/EaYWhjOTSywfE
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
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwODI5MDA1OTU1WjAjBgkqhkiG9w0BCQQxFgQUK4yV
lEUczcYdmUfYmiqCmslXV2UwDQYJKoZIhvcNAQEBBQAEggEAAVz4VkfmQlB5cDVk7yrtyApIgsev
x2dOnTx4rAj/xRC5wMaQLmvTSCHGLF5RTNjV+FQjNLtB4eQcyU60hslyHnG+6zs4SJdP7Sqn8546
rkK5hqXAwmlW4b2pC6pTk5FPx4qRUm7rxfQAwfFoxodam4BFqJE7xwlcmcyM6C+dDEKXUGg5Hwl9
zU4mjtw/B697qYe4c/VBkn0lV+K7d2mVw1uMCGyPw2/5MOmO/qi3oXKAINiBBnmFNaNBYpEj48zy
p5LQfPILQmNZvGHcU5Hc4mH5hQk1cBHeyzCxJX2QZpsmZGslw3qSHmgLhaCGoihUCk+AqnTM6kCp
8op/z08m7QAAAAAAAA==


--=-2oRUSx/EaYWhjOTSywfE--

--===============7640105514323236155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7640105514323236155==--
