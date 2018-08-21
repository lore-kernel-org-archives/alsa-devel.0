From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Tue, 21 Aug 2018 21:58:05 +0000
Message-ID: <1534888610.4547.104.camel@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1211843805537660548=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 21121267657
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2018 00:00:19 +0200 (CEST)
In-Reply-To: <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
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

--===============1211843805537660548==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-/26lye75wbpFbbBPtVf7"

--=-/26lye75wbpFbbBPtVf7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

On Mon, 2018-08-20 at 22:37 -0500, Pierre-Louis Bossart wrote:
> > +#define CLOCK_REF		CLOCK_REALTIME
>=20
> You should probably comment on why you use CLOCK_REALTIME for
> something=20
> that is driven by a media clock that's completely unrelated to=20
> CLOCK_REALTIME?

Sure, I'll add a comment here explaining why.

Just anticipating, the AAF plugin implements a media clock itself. To
achieve that it relies on a periodic timer, which requires a clock id.
CLOCK_REALTIME was chosen because we can synchronize it against the PTP
 clock (see instructions on doc/aaf.txt) and use it to get PTP time.
PTP time is the time reference in an AVTP system e.g. time reference
utilized to set presentation time.

> > +static unsigned int alsa_to_avtp_format(snd_pcm_format_t format)
> > +{
> > +	switch (format) {
> > +	case SND_PCM_FORMAT_S16_BE:
>=20
> we usually use S16_LE? I can't recall when I last used S16_BE...

AVTP specifies that the byte order of the samples is network order
(i.e. big-endian). So, for simplicity, the plugin accepts only BE
samples (see aaf_hw_params) at the moment.

Later on, we can extend the plugin to convert LE to BE, or rely on
another plugin (e.g. linear) to do the conversion.

> > +		return AVTP_AAF_FORMAT_INT_16BIT;
> > +	case SND_PCM_FORMAT_S24_3BE:
>=20
> this means 3 bytes without padding to 32-bit word, is this your=20
> definition as well?

Yes, that's AVTP definition.

> > +static unsigned int alsa_to_avtp_rate(unsigned int rate)
> > +{
> > +	switch (rate) {
> > +	case 8000:
> > +		return AVTP_AAF_PCM_NSR_8KHZ;
> > +	case 16000:
> > +		return AVTP_AAF_PCM_NSR_16KHZ;
> > +	case 24000:
> > +		return AVTP_AAF_PCM_NSR_24KHZ;
> > +	case 32000:
> > +		return AVTP_AAF_PCM_NSR_32KHZ;
> > +	case 44100:
> > +		return AVTP_AAF_PCM_NSR_44_1KHZ;
> > +	case 48000:
> > +		return AVTP_AAF_PCM_NSR_48KHZ;
> > +	case 88200:
> > +		return AVTP_AAF_PCM_NSR_88_2KHZ;
> > +	case 96000:
> > +		return AVTP_AAF_PCM_NSR_96KHZ;
> > +	case 176400:
> > +		return AVTP_AAF_PCM_NSR_176_4KHZ;
> > +	case 192000:
> > +		return AVTP_AAF_PCM_NSR_192KHZ;
>=20
> You should align avtp_aaf definitions with ALSA, you are missing
> quite a=20
> few frequencies. e.g. 11.025, 64, 384kHz. If this is intentional add
> a=20
> comment to explain the restrictions.

This is intentional. AVTP doesn't support all frequencies. I'll add a
comment as requested.

> > +static int aaf_init_areas(snd_pcm_aaf_t *aaf)
> > +{
> > +	snd_pcm_channel_area_t *audiobuf_areas, *payload_areas;
> > +	ssize_t sample_size, frame_size;
> > +	snd_pcm_ioplug_t *io =3D &aaf->io;
> > +
> > +	sample_size =3D snd_pcm_format_size(io->format, 1);
> > +	if (sample_size < 0)
> > +		return sample_size;
> > +
> > +	frame_size =3D sample_size * io->channels;
> > +
> > +	audiobuf_areas =3D calloc(io->channels,
> > sizeof(snd_pcm_channel_area_t));
> > +	if (!audiobuf_areas)
> > +		return -ENOMEM;
> > +
> > +	payload_areas =3D calloc(io->channels,
> > sizeof(snd_pcm_channel_area_t));
> > +	if (!payload_areas) {
> > +		free(audiobuf_areas);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (unsigned int i =3D 0; i < io->channels; i++) {
> > +		audiobuf_areas[i].addr =3D aaf->audiobuf;
> > +		audiobuf_areas[i].first =3D i * sample_size * 8;
> > +		audiobuf_areas[i].step =3D frame_size * 8;
> > +
> > +		payload_areas[i].addr =3D aaf->pdu->avtp_payload;
> > +		payload_areas[i].first =3D i * sample_size * 8;
> > +		payload_areas[i].step =3D frame_size * 8;
>=20
> not sure what 8 represents here?

Number of bits per byte.

'sample_size' and 'frame_size' are in bytes. 'first' and 'step' fields
from 'snd_pcm_channel_area_t' are in bits.

> > +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
> > +{
> > +	int res;
> > +	struct timespec now;
> > +	struct itimerspec itspec;
> > +	snd_pcm_ioplug_t *io =3D &aaf->io;
> > +
> > +	res =3D clock_gettime(CLOCK_REF, &now);
> > +	if (res < 0) {
> > +		SNDERR("Failed to get time from clock");
> > +		return -errno;
> > +	}
> > +
> > +	aaf->mclk_period =3D (NSEC_PER_SEC * aaf->frames_per_pkt) /
> > io->rate;
>=20
> is this always an integer? If not, don't you have a systematic=20
> arithmetic error?

NSEC_PER_SEC is 64-bit so I don't see an arithmetic error during
calculation (e.g. integer overflow). Not sure this was your concern,
though. Let me know otherwise.

> > +static int aaf_poll_revents(snd_pcm_ioplug_t *io, struct pollfd
> > *pfd,
> > +			    unsigned int nfds, unsigned short
> > *revents)
> > +{
> > +	int res;
> > +	snd_pcm_aaf_t *aaf =3D io->private_data;
> > +
> > +	if (nfds !=3D FD_COUNT_PLAYBACK)
> > +		return -EINVAL;
> > +
> > +	if (pfd[0].revents & POLLIN) {
> > +		res =3D aaf_mclk_timeout_playback(aaf);
> > +		if (res < 0)
> > +			return res;
> > +
> > +		*revents =3D POLLIN;
> > +	}
>=20
> I couldn't figure out how you use playback events and your timer.=20

Every time aaf->timer_fd expires, the audio buffer is consumed by the
plugin, making some room available on the buffer. So here a POLLIN
event is returned so alsa-lib layer can copy more data into the audio
buffer.

> When there are two audio clock sources or timers that's usually where
> the fun begins.

Regarding scenarios with two audio clock sources or timers, the plugin
doesn't support them at the moment. This is something we should work on
once the basic functionality is pushed upstream.

Thank you for your feedback.

Regards,

Andre

--=-/26lye75wbpFbbBPtVf7
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
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwODIxMjE1NjUwWjAjBgkqhkiG9w0BCQQxFgQULz7b
WTZf/C9bYIFDyF4ZwbXNllUwDQYJKoZIhvcNAQEBBQAEggEABpMyBweH1q8Gn6Eucwx4BD4nagy1
g7OfOd7YU5FUx9tTl8H/fUUC0sWPT7WsB7l9Oxu6i+28cHlad9++4ytgSFG5v8oX5H4XzXP5sv2O
n86Rz8lKkk3rNFNJfEXj4H3DtWpfN4tR1w+xMSdUZLqvnC0MqqU4XOpaqENPuVwtDk1tf54Ed46j
aNB8GKckONcm5R0H80ABncQG4DLpnUjf4kqxK8e2sSSgjrQEEUj5OFqZn7tOVKRqC5Ib3RGfyrDP
L+dv8Sr3XTLiMjuboAh/4VJS50V6y8OgTzeWz2+0aTDhxqQBYT1oaAbr/C/bt2Q7z2q/1Cw2tYul
TVqdqzn47gAAAAAAAA==


--=-/26lye75wbpFbbBPtVf7--

--===============1211843805537660548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1211843805537660548==--
