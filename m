From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [PATCH - AAF PCM plugin 3/7] aaf: Implement
 Playback mode support
Date: Thu, 11 Oct 2018 19:53:46 +0000
Message-ID: <1539287618.3419.31.camel@intel.com>
References: <20181003234547.16839-1-andre.guedes@intel.com>
 <20181003234547.16839-4-andre.guedes@intel.com>
 <s5ha7nmxf80.wl-tiwai@suse.de> <1539206847.3120.20.camel@intel.com>
 <s5htvltc52e.wl-tiwai@suse.de>
 <d1524938-2bb1-89ab-a03f-0822908c71f5@sakamocchi.jp>
 <s5hr2gwdib8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0536176025810340307=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 15DFC2678FE
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 21:57:58 +0200 (CEST)
In-Reply-To: <s5hr2gwdib8.wl-tiwai@suse.de>
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
To: "o-takashi@sakamocchi.jp" <o-takashi@sakamocchi.jp>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============0536176025810340307==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-oKDnbElGpVl0bibydMZp"

--=-oKDnbElGpVl0bibydMZp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-10-11 at 10:00 +0200, Takashi Iwai wrote:
> On Thu, 11 Oct 2018 09:45:07 +0200,
> Takashi Sakamoto wrote:
> >=20
> > On Oct 11 2018 16:31, Takashi Iwai wrote:
> > > On Wed, 10 Oct 2018 23:27:29 +0200,
> > > Guedes, Andre wrote:
> > > >=20
> > > > On Wed, 2018-10-10 at 12:34 +0200, Takashi Iwai wrote:
> > > > > > +static int aaf_set_hw_constraint(snd_pcm_aaf_t *aaf)
> > > > > > +{
> > > > > > +     int res;
> > > > > > +     snd_pcm_ioplug_t *io =3D &aaf->io;
> > > > > > +     const unsigned int accesses[] =3D {
> > > > > > +             SND_PCM_ACCESS_RW_INTERLEAVED,
> > > > > > +     };
> > > > > > +     const unsigned int formats[] =3D {
> > > > > > +             SND_PCM_FORMAT_S16_BE,
> > > > > > +             SND_PCM_FORMAT_S24_3BE,
> > > > > > +             SND_PCM_FORMAT_S32_BE,
> > > > > > +             SND_PCM_FORMAT_FLOAT_BE,
> > > > > > +     };
> > > > > > +     const unsigned int rates[] =3D {
> > > > > > +             8000,
> > > > > > +             16000,
> > > > > > +             24000,
> > > > > > +             32000,
> > > > > > +             44100,
> > > > > > +             48000,
> > > > > > +             88200,
> > > > > > +             96000,
> > > > > > +             176400,
> > > > > > +             192000,
> > > > > > +     };
> > > > >=20
> > > > > Use static arrays for the above.
> > > >=20
> > > > It isn't clear to me what is the point in allocating these
> > > > variables in
> > > > the global scope. May I ask what is the benefit in adding the
> > > > 'static'
> > > > modifier to these local variables?
> > >=20
> > > Yes.
> >=20
> > In this case, it's not relevant to access scope.
> >=20
> > Just with 'const' qualifier, the symbol allocates in .text section
> > of ELF binary. With additional 'static' qualifier, the symbol
> > allocates in .rodata section.
> >=20
> > In loading, symbol in .rodata section locates in segments of VMA
> > with 'read-only' flag. This brings safety from several bugs such as
> > buffer over-run.

My understanding is that the arrays are allocated in the stack frame,
not in .text section, and the 'const' qualifier here has no influence
on that. But I get your point in moving the arrays to .rodata.

> OK, then scratch my comments.

I checked other plugins and it seems having 'static' to these variables
is the "norm" so I'm adding it for the sake of consistency.

Thanks,

Andre

--=-oKDnbElGpVl0bibydMZp
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
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDExMTk1MzM4WjAjBgkqhkiG9w0BCQQxFgQU1Y0/
bGUNGche+MA1j6teO3YQOQowDQYJKoZIhvcNAQEBBQAEggEAqr2gMGm4qliouSo/ANo3gkSTZkyV
ItAlrYfjEPwKSn+8dQIHoKA3aKGzCwUNMz5hUzzHbN6zUSjWW7u4YVhssHH4qUgAKXXZyt7PMx9Y
jaXurBG/wii3QwtpLwuUXKGn35pNy+2M0PEAk90wotAa/6HBiUKMvGacmWK5yDUMJxM68F+ZC+t6
Hbt9+DWAeVPRlrg2CnbxoxmfIM5KHFG6X2uRblsudN5+n+7u3tcfRThpPPRnZnT/DDDIWq4O0Eci
Axt22vLvDwys3il80DdkM2RPf+4hgSF27Sh2kmVBFpB92W3yThPe2RPP7KvsRyaU9/Bhht630+JG
eA5pGrnoHQAAAAAAAA==


--=-oKDnbElGpVl0bibydMZp--

--===============0536176025810340307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0536176025810340307==--
