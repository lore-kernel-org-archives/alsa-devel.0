From: IOhannes m zmoelnig <zmoelnig@iem.at>
Subject: Re: crash with assertion (?)
Date: Wed, 08 Sep 2010 10:41:02 +0200
Message-ID: <4C874C1E.8040007@iem.at>
References: <4C8662AD.1040607@iem.at> <4C8670FD.5020906@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5004146096519382743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.iem.at (iem.kug.ac.at [193.170.191.180])
	by alsa0.perex.cz (Postfix) with ESMTP id BEA212442A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 10:41:03 +0200 (CEST)
In-Reply-To: <4C8670FD.5020906@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a cryptographically signed message in MIME format.

--===============5004146096519382743==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="------------ms000403010707020508060102"

This is a cryptographically signed message in MIME format.

--------------ms000403010707020508060102
Content-Type: multipart/mixed;
 boundary="------------090805020500080807020104"

This is a multi-part message in MIME format.
--------------090805020500080807020104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 2010-09-07 19:06, Clemens Ladisch wrote:
> IOhannes m zmoelnig wrote:
>> i'm requesting my "plughw" device with 44100Hz
>> the request is done with something like:
>>  rate=3D44100;
>>  err =3D snd_pcm_hw_params_set_rate_min(handle, params, &rate, 0);
>=20
> This requests a sample rate of at least 44100 Hz.

yes. this is good enough for me.
(it shouldn't crash though)

>=20
>> [...]
>>  err =3D snd_pcm_hw_params(handle, params);
>>
>> what happens:
>> in the snd_pcm_hw_params(), my program exits with:
>> "interval_inline.h:52: snd_interval_single: Assertion
>> `!snd_interval_empty(i)' failed."
>=20
> You called snd_pcm_hw_params with an invalid params structure.
> I'd guess that snd_pcm_hw_params_set_rate_min (or some other
> snd_pcm_hw_params_set_*) returned an error.

i wish you were right.
however, it seems like i am blindfolded.

i noticed however, that i need to set both the rate (i use
snd_pcm_hw_params_set_rate_min()) and the period size (i use
snd_pcm_hw_params_set_period_size_near()), in order to make it crash.

attached is an example code that triggers the crash.
please someone shed some light...

gmasdr
IOhannes


PS: that's how i use the sample program:
$ gcc -o alsatest alsatest.c $(pkg-config --cflags --libs alsa)
$ ./alsatest
trying to open 'hw:0' as CAPTURE
configuring device succeeded
CAPTURE configured
trying to open 'hw:0' as PLAYBACK
configuring device succeeded
PLAYBACK configured
trying to open 'plughw:0' as CAPTURE
configuring device succeeded
CAPTURE configured
trying to open 'plughw:0' as PLAYBACK
alsatest: interval_inline.h:55: snd_interval_single: Assertion
`!snd_interval_empty(i)' failed.
Aborted

so it seems to work fine with "hw:0" but not with "plughw:0".

you can specify the device to be opened on the cmdline:
$ ./alsatest hw:2

--------------090805020500080807020104
Content-Type: text/x-csrc;
 name="alsatest.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="alsatest.c"

#include <stdio.h>
#include <alsa/asoundlib.h>

#define ENABLE_SETPARAMS_RATE 1
#define ENABLE_SETPARAMS_PERIOD 2

/* neither set_rate_min() nor set_period_size_near() is ok (but trivial) =
*/
//#define ENABLE_SETPARAMS 0

/* only set_rate_min() is ok */
//#define ENABLE_SETPARAMS  ENABLE_SETPARAMS_RATE

/* only set_period_size_near() is ok as well */
//#define ENABLE_SETPARAMS  ENABLE_SETPARAMS_PERIOD

/* both set_rate_min() and set_period_size_near() -> CRASH */
#define ENABLE_SETPARAMS  ENABLE_SETPARAMS_RATE | ENABLE_SETPARAMS_PERIOD=


int pcm_configure(snd_pcm_t *pcm) {
  unsigned int rate=3D44100;
  snd_pcm_uframes_t uframes =3D 64;

  snd_pcm_hw_params_t* hw_params;
  int err;

  snd_pcm_hw_params_alloca(&hw_params);
  err =3D snd_pcm_hw_params_any(pcm, hw_params);
  if(err<0){fprintf(stderr, "snd_pcm_hw_params_any failed: %s\n",  snd_st=
rerror(err));return err;}

#if ENABLE_SETPARAMS & 1
  err =3D snd_pcm_hw_params_set_rate_min(pcm, hw_params, &rate, 0);
  if(err<0){fprintf(stderr, "snd_pcm_hw_params_set_rate_min failed: %s\n"=
,  snd_strerror(err));return err;}
#endif

#if ENABLE_SETPARAMS & 2
  err =3D snd_pcm_hw_params_set_period_size_near(pcm, hw_params, &uframes=
, 0);
  if(err<0){fprintf(stderr, "snd_pcm_hw_params_set_period_size failed: %s=
\n",  snd_strerror(err));return err;}
#endif

  err =3D snd_pcm_hw_params(pcm, hw_params);
  if(err<0){fprintf(stderr, "snd_pcm_hw_params failed: %s\n",  snd_strerr=
or(err));return err;}

  printf("configuring device succeeded\n");
  return 0;
}

void pcm_open(char*name) {
 int err=3D0;
 snd_pcm_t *pcmIn=3D0, *pcmOut=3D0;

  printf("trying to open '%s' as CAPTURE\n", name);
  err =3D snd_pcm_open(&pcmIn, name, SND_PCM_STREAM_CAPTURE, SND_PCM_NONB=
LOCK);
  if(err<0){fprintf(stderr, "snd_pcm_open(CAPTURE) failed: %s\n",  snd_st=
rerror(err));goto closeit;}
  err=3Dsnd_pcm_nonblock(pcmIn, 1);
  if(err<0){fprintf(stderr, "snd_pcm_nonblock failed: %s\n",  snd_strerro=
r(err));goto closeit;}
  pcm_configure(pcmIn);
  fprintf(stderr, "CAPTURE configured\n");

  printf("trying to open '%s' as PLAYBACK\n", name);
  err =3D snd_pcm_open(&pcmOut, name, SND_PCM_STREAM_PLAYBACK, SND_PCM_NO=
NBLOCK);
  if(err<0){fprintf(stderr, "snd_pcm_open(PLAYBACK) failed: %s\n",  snd_s=
trerror(err));goto closeit;}
  err=3Dsnd_pcm_nonblock(pcmOut, 1);
  if(err<0){fprintf(stderr, "snd_pcm_nonblock failed: %s\n",  snd_strerro=
r(err));goto closeit;}
  pcm_configure(pcmOut);
  fprintf(stderr, "PLAYBACK configured\n");

 closeit:
  if(pcmIn)snd_pcm_close(pcmIn);
  if(pcmOut)snd_pcm_close(pcmOut);
}


int main(int argc, char**argv) {
  int i=3D0;
  if(argc>1) {
    for(i=3D1; i<argc; i++) {
      pcm_open(argv[i]);
    }
  } else {
      pcm_open("hw:0");
      pcm_open("plughw:0");
  }
  fprintf(stderr, "bye bye\n");
  return 0;
}

--------------090805020500080807020104--

--------------ms000403010707020508060102
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKYjCC
BS0wggMVoAMCAQICAwYpcDANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wODEy
MTUxNjM3MDdaFw0xMDEyMTUxNjM3MDdaMDsxGTAXBgNVBAMUEElPaGFubmVzIHpt9mxuaWcx
HjAcBgkqhkiG9w0BCQEWD3ptb2VsbmlnQGllbS5hdDCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAKLQhgkPj0tjKYXWT4jMXaIwxPXxsI1jQat4/FQxYNKWwSKPi2p+mqrKgoTc
qBszVGhBzhU9QndtpAeygvc0O5QVhyqnpndYoPu4kI5DhHemdwE6VvWiMFgEeOTywiOQJoUt
zulhHovz6xa9fSPqgO5c174CKsD3ekfOQ+m1xmZ6xd3hHDgm30186abxCsGOOXSadh+bnlGG
pCXLKbZiRvF5WfOL6Y3myb3IinYErrerpjROshxC5ibd9KdlGXJ3MDEZGirM7tW75iiU7yz7
umZDGNmcIrWCNs65YuRFfe42W2JOXqYvdiLKeK5iSNbuX/R5JZDrTvJU56cFmUy6hocCAwEA
AaOB+zCB+DAMBgNVHRMBAf8EAjAAMFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQgeW91ciBvd24g
Y2VydGlmaWNhdGUgZm9yIEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0Lm9y
ZzBABgNVHSUEOTA3BggrBgEFBQcDBAYIKwYBBQUHAwIGCisGAQQBgjcKAwQGCisGAQQBgjcK
AwMGCWCGSAGG+EIEATAyBggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3Nw
LmNhY2VydC5vcmcwGgYDVR0RBBMwEYEPem1vZWxuaWdAaWVtLmF0MA0GCSqGSIb3DQEBBQUA
A4ICAQBS/kdsg+n5pCKqUOVrRYM2TlGXY38/5TyEmfvhlvjDHDs8s4Cc/TtxLyyHrHYKpH4Z
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
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGKXAwCQYFKw4DAhoF
AKCCAegwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTAwOTA4
MDg0MTAyWjAjBgkqhkiG9w0BCQQxFgQUn6H4e7lKDgAm6p3sXJyHEiFMiw4wXwYJKoZIhvcN
AQkPMVIwUDALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGRBgkrBgEEAYI3EAQxgYMwgYAw
eTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIw
IAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBw
b3J0QGNhY2VydC5vcmcCAwYpcDCBkwYLKoZIhvcNAQkQAgsxgYOggYAweTEQMA4GA1UEChMH
Um9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBD
ZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5v
cmcCAwYpcDANBgkqhkiG9w0BAQEFAASCAQAs8vCxz15w5ZhXkpObdUGDgpztQOT5JXq+LjZR
Fq+5h2zb5iFfLSbkIsnabzKZUImv1RtMHRbS/JcQwqkIMzFUyCYd6Uw+OR7H8c3mM/FzmZAP
djgzasPpkfnxCi+ZQKgGwQs02l3KdfHbS5tuntnCPnNhYhtM1wRRiv9mSb7jSFD6Zm2y0vF2
vVHzxoqp7HES1K2PDmu75VoDsGLviVjTZgUIBmGBnFOt2QIwBDHN9qjQG+43dA+odRwJsncT
gPhLm9cRAHCovD0eKFF53b8XQiU5b4HQlRIUriC8xXmFdxQnKd1mlTpcRv3hKQ8JpA6mxtV3
61oUvO/AHfikwKQtAAAAAAAA
--------------ms000403010707020508060102--

--===============5004146096519382743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5004146096519382743==--
