From: "Guedes, Andre" <andre.guedes@intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Wed, 12 Sep 2018 23:45:21 +0000
Message-ID: <1536795920.3147.7.camel@intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5324681672071138449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EEA92676EB
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 01:46:07 +0200 (CEST)
In-Reply-To: <1535049162.3323.5.camel@intel.com>
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

--===============5324681672071138449==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-1;
	protocol="application/x-pkcs7-signature"; boundary="=-rpK6DYxkwy4WLStUam0f"

--=-rpK6DYxkwy4WLStUam0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

On Thu, 2018-08-23 at 11:32 -0700, Andre Guedes wrote:
> On Wed, 2018-08-22 at 21:25 -0500, Pierre-Louis Bossart wrote:
> > On 08/22/2018 07:46 PM, Guedes, Andre wrote:
> > > On Tue, 2018-08-21 at 17:51 -0500, Pierre-Louis Bossart wrote:
> > > > > > > +static int aaf_mclk_start_playback(snd_pcm_aaf_t *aaf)
> > > > > > > +{
> > > > > > > +   int res;
> > > > > > > +   struct timespec now;
> > > > > > > +   struct itimerspec itspec;
> > > > > > > +   snd_pcm_ioplug_t *io =3D &aaf->io;
> > > > > > > +
> > > > > > > +   res =3D clock_gettime(CLOCK_REF, &now);
> > > > > > > +   if (res < 0) {
> > > > > > > +           SNDERR("Failed to get time from clock");
> > > > > > > +           return -errno;
> > > > > > > +   }
> > > > > > > +
> > > > > > > +   aaf->mclk_period =3D (NSEC_PER_SEC * aaf-
> > > > > > > > frames_per_pkt) /
> > > > > > >=20
> > > > > > > io->rate;
> > > > > >=20
> > > > > > is this always an integer? If not, don't you have a
> > > > > > systematic
> > > > > > arithmetic error?
> > > > >=20
> > > > > NSEC_PER_SEC is 64-bit so I don't see an arithmetic error
> > > > > during
> > > > > calculation (e.g. integer overflow). Not sure this was your
> > > > > concern,
> > > > > though. Let me know otherwise.
> > > >=20
> > > > No, I was talking about the fractional part, e.g with 256
> frames
> > > > with
> > > > 44.1kHz you have a period of 5804988.662131519274376 - so your
> > > > math
> > > > adds
> > > > a truncation. same with 48khz, the fractional part is .333
> > > >=20
> > > > I burned a number of my remaining neurons chasing a <100 ppb
> > > > error
> > > > which
> > > > led to underruns after 10 hours, so careful now with
> > > > truncation...
> > >=20
> > > Thanks for clarifying.
> > >=20
> > > Yes, we can end up having a fractional period which is truncated.
> > > Note
> > > that both 'frames' and 'rate' are configured by the user. The
> user
> > > should set 'frames' as multiple of 'rate' whenever possible to
> > > avoid
> > > inaccuracy.
> >=20
> > It's unlikely to happen. it's classic in audio that people want
> > powers=20
> > of two for fast filtering, and don't really care that the periods
> > are=20
> > fractional. If you cannot guarantee long-term operation without
> > timing=20
> > issues, you should add constraints to the frames and rates so that
> > there=20
> > is no surprise.
>=20
> Fair enough. So for now I'll add a constraint on frames and rates to
> unsure no surprises. Later we can revisit this and implement the
> compesation mechanism you described below.

I've been thinking about this potential underrun situation you
described, and I'd like to get your input on the following assessment.

In a typical scenario using real audio hardware, we have one thread
producing data to the audio buffer (application thread) and another
thread consuming data from the buffer (driver thread). If the consuming
thread is slightly faster than the producing one, we end up having an
underrun error.

In the AAF plugin scenario, however, we have only one thread
(application thread) that is responsible for both producing and
consuming data to/from the buffer. Once the buffer is full, the thread
consumes data from the buffer, trasmits an AVTP packet, copies more
data to the buffer, and blocks until the next transmission time. Since
it is single threaded, the potential underrun situation you described
doesn't look real (even if the consumption rate is slightly faster than
the nominal rate due to the period truncation).

Does the above make sense to you?

BTW, I have been running an experiment with 44.1 kHz and 6 frames for
72+ hours and haven't seen any xrun error so far.

Regards,

Andre

--=-rpK6DYxkwy4WLStUam0f
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
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwOTEyMjM0NTIwWjAjBgkqhkiG9w0BCQQxFgQUtw9e
krgTcNqtxjM5Y0khAX3IkwAwDQYJKoZIhvcNAQEBBQAEggEAK0CHW4UxmH4KIunT/DP/KflA3PF5
gcnOWiMsddLtcsB8NjygjgwgdzZOe1nwdv4t3amwYXmq6JJzRSH2Kq/F2SXT/pVJ0jrXv12uRMu2
s2KQDoetUKlLIWV6kG0Q/sMQLqVgtY/vpug9ffnc1hDJW3KUMxi36i6XU9BzuNDuzp4LDOvDWyby
5e9j080L1a5dpZ/9dNK9KP+2kCkDGhg+fTcrs+k6J0BJiRFl8e7pdMYNvDCcFDRChCLzCZ11xhQU
3wdFNrEBFp7H8kAhuxjMO9H6He+z7KLi/cwNaUwmEeT1waB6LmY+TpxpiX4nryo00V3lfovbSIxE
OolcJakuZwAAAAAAAA==


--=-rpK6DYxkwy4WLStUam0f--

--===============5324681672071138449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5324681672071138449==--
