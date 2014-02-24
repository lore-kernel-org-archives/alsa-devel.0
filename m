From: Will R <domohawk@gmail.com>
Subject: Re: [PATCH - speaker-test 1/1] speaker-test: add
 --force-frequency option to allow hz outside range
Date: Mon, 24 Feb 2014 07:04:27 -0800
Message-ID: <CAA2k8L1nH3OJUsEb31zWuzwWTjN3EJGSrb0Wsr=dFqYgievFKQ@mail.gmail.com>
References: <s5hmwhgygon.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf300e51e51b3f9604f3284c7d
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 00FC6265568
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:05:08 +0100 (CET)
Received: by mail-yk0-f176.google.com with SMTP id 19so14801075ykq.7
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 07:05:08 -0800 (PST)
In-Reply-To: <s5hmwhgygon.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--20cf300e51e51b3f9604f3284c7d
Content-Type: text/plain; charset=ISO-8859-1

What is the reasoning behind the limit, protecting speaker hardware,
hearing? I think common speakers have frequency response up to 15 or 16kHz
or so, so maybe a bit higher default limit of 8kHz would be okay.

I was doing some tests around 20kHz - 22kHz (to test my hearing and freq
response of my 25kHz rated headphones), so still see the merit in a force
option for people who are certain they want to test that high.

New patch: Added min of 1.0Hz for force option, changed default max to
8kHz, fixed typo in flag name:

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 261f399..61396f2 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -106,6 +106,7 @@ static snd_pcm_uframes_t  period_size;
 static const char *given_test_wav_file = NULL;
 static char *wav_file_dir = SOUNDSDIR;
 static int debug = 0;
+static int force_frequency = 0;
 static int in_aborting = 0;
 static snd_pcm_t *pcm_handle = NULL;

@@ -1015,6 +1016,7 @@ static void help(void)
     "-w,--wavfile Use the given WAV file as a test sound\n"
     "-W,--wavdir Specify the directory containing WAV files\n"
     "-m,--chmap Specify the channel map to override\n"
+    "-X,--force-frequency force frequencies outside the 30-8000hz range\n"
     "\n"));
   printf(_("Recognized sample formats are:"));
   for (fmt = supported_formats; *fmt >= 0; fmt++) {
@@ -1057,6 +1059,7 @@ int main(int argc, char *argv[]) {
     {"wavfile",   1, NULL, 'w'},
     {"wavdir",    1, NULL, 'W'},
     {"debug",   0, NULL, 'd'},
+    {"force-frequency",   0, NULL, 'X'},
 #ifdef CONFIG_SUPPORT_CHMAP
     {"chmap",   1, NULL, 'm'},
 #endif
@@ -1078,7 +1081,7 @@ int main(int argc, char *argv[]) {
   while (1) {
     int c;

-    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d"
+    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:X"
 #ifdef CONFIG_SUPPORT_CHMAP
   "m:"
 #endif
@@ -1114,8 +1117,6 @@ int main(int argc, char *argv[]) {
       break;
     case 'f':
       freq = atof(optarg);
-      freq = freq < 30.0 ? 30.0 : freq;
-      freq = freq > 5000.0 ? 5000.0 : freq;
       break;
     case 'b':
       buffer_time = atoi(optarg);
@@ -1173,6 +1174,9 @@ int main(int argc, char *argv[]) {
     case 'd':
       debug = 1;
       break;
+    case 'X':
+      force_frequency = 1;
+      break;
 #ifdef CONFIG_SUPPORT_CHMAP
     case 'm':
       chmap = optarg;
@@ -1190,6 +1194,13 @@ int main(int argc, char *argv[]) {
     exit(EXIT_SUCCESS);
   }

+  if (!force_frequency) {
+    freq = freq < 30.0 ? 30.0 : freq;
+    freq = freq > 8000.0 ? 8000.0 : freq;
+  } else {
+    freq = freq < 1.0 ? 1.0 : freq;
+  }
+
   if (test_type == TEST_WAV)
     format = SND_PCM_FORMAT_S16_LE; /* fixed format */

-- 
1.8.3.2


On Mon, Feb 24, 2014 at 1:59 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 22 Feb 2014 16:09:57 -0800,
> erik@caspar.alsa-project.org wrote:
> >
> > From: Erik Ackermann <domohawk@gmail.com>
> >
> > Signed-off-by: Erik Ackermann <domohawk@gmail.com>
>
> But still it should have some sanity checks like freq <= 0, as freq is
> used as a divisor.
>
> Or, we may simply relax the frequency range.  What value do you want
> to take in your use case?
>
>
> Takashi
>
> >
> > diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
> > index 261f399..22927f2 100644
> > --- a/speaker-test/speaker-test.c
> > +++ b/speaker-test/speaker-test.c
> > @@ -106,6 +106,7 @@ static snd_pcm_uframes_t  period_size;
> >  static const char *given_test_wav_file = NULL;
> >  static char *wav_file_dir = SOUNDSDIR;
> >  static int debug = 0;
> > +static int force_frequency = 0;
> >  static int in_aborting = 0;
> >  static snd_pcm_t *pcm_handle = NULL;
> >
> > @@ -1015,6 +1016,7 @@ static void help(void)
> >          "-w,--wavfile        Use the given WAV file as a test sound\n"
> >          "-W,--wavdir Specify the directory containing WAV files\n"
> >          "-m,--chmap  Specify the channel map to override\n"
> > +        "-X,--force-frequency        force frequencies outside the
> 30-5000hz range\n"
> >          "\n"));
> >    printf(_("Recognized sample formats are:"));
> >    for (fmt = supported_formats; *fmt >= 0; fmt++) {
> > @@ -1057,6 +1059,7 @@ int main(int argc, char *argv[]) {
> >      {"wavfile",   1, NULL, 'w'},
> >      {"wavdir",    1, NULL, 'W'},
> >      {"debug",          0, NULL, 'd'},
> > +    {"force-frequncy",         1, NULL, 'X'},
> >  #ifdef CONFIG_SUPPORT_CHMAP
> >      {"chmap",          1, NULL, 'm'},
> >  #endif
> > @@ -1078,7 +1081,7 @@ int main(int argc, char *argv[]) {
> >    while (1) {
> >      int c;
> >
> > -    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d"
> > +    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:X"
> >  #ifdef CONFIG_SUPPORT_CHMAP
> >                        "m:"
> >  #endif
> > @@ -1114,8 +1117,6 @@ int main(int argc, char *argv[]) {
> >        break;
> >      case 'f':
> >        freq = atof(optarg);
> > -      freq = freq < 30.0 ? 30.0 : freq;
> > -      freq = freq > 5000.0 ? 5000.0 : freq;
> >        break;
> >      case 'b':
> >        buffer_time = atoi(optarg);
> > @@ -1173,6 +1174,9 @@ int main(int argc, char *argv[]) {
> >      case 'd':
> >        debug = 1;
> >        break;
> > +    case 'X':
> > +      force_frequency = 1;
> > +      break;
> >  #ifdef CONFIG_SUPPORT_CHMAP
> >      case 'm':
> >        chmap = optarg;
> > @@ -1190,6 +1194,11 @@ int main(int argc, char *argv[]) {
> >      exit(EXIT_SUCCESS);
> >    }
> >
> > +  if (!force_frequency) {
> > +    freq = freq < 30.0 ? 30.0 : freq;
> > +    freq = freq > 5000.0 ? 5000.0 : freq;
> > +  }
> > +
> >    if (test_type == TEST_WAV)
> >      format = SND_PCM_FORMAT_S16_LE; /* fixed format */
> >
> > --
> > 1.8.3.2
> >
>

--20cf300e51e51b3f9604f3284c7d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-speaker-test-add-force-frequency-option-to-allow-hz-.patch"
Content-Disposition: attachment;
	filename="0001-speaker-test-add-force-frequency-option-to-allow-hz-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hs1vi59o0

RnJvbSAzZDljZWI0MmUxMjA1NjE4YjI5NDc5MDc3YjBiZDNmMmQ3MWM2NGRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmlrIEFja2VybWFubiA8ZG9tb2hhd2tAZ21haWwuY29tPgpE
YXRlOiBNb24sIDI0IEZlYiAyMDE0IDA2OjUzOjA4IC0wODAwClN1YmplY3Q6IFtQQVRDSCAtIHNw
ZWFrZXItdGVzdCAxLzFdIHNwZWFrZXItdGVzdDogYWRkIC0tZm9yY2UtZnJlcXVlbmN5IG9wdGlv
bgogdG8gYWxsb3cgaHogb3V0c2lkZSByYW5nZQoKU2lnbmVkLW9mZi1ieTogRXJpayBBY2tlcm1h
bm4gPGRvbW9oYXdrQGdtYWlsLmNvbT4KCmRpZmYgLS1naXQgYS9zcGVha2VyLXRlc3Qvc3BlYWtl
ci10ZXN0LmMgYi9zcGVha2VyLXRlc3Qvc3BlYWtlci10ZXN0LmMKaW5kZXggMjYxZjM5OS4uNjEz
OTZmMiAxMDA2NDQKLS0tIGEvc3BlYWtlci10ZXN0L3NwZWFrZXItdGVzdC5jCisrKyBiL3NwZWFr
ZXItdGVzdC9zcGVha2VyLXRlc3QuYwpAQCAtMTA2LDYgKzEwNiw3IEBAIHN0YXRpYyBzbmRfcGNt
X3VmcmFtZXNfdCAgcGVyaW9kX3NpemU7CiBzdGF0aWMgY29uc3QgY2hhciAqZ2l2ZW5fdGVzdF93
YXZfZmlsZSA9IE5VTEw7CiBzdGF0aWMgY2hhciAqd2F2X2ZpbGVfZGlyID0gU09VTkRTRElSOwog
c3RhdGljIGludCBkZWJ1ZyA9IDA7CitzdGF0aWMgaW50IGZvcmNlX2ZyZXF1ZW5jeSA9IDA7CiBz
dGF0aWMgaW50IGluX2Fib3J0aW5nID0gMDsKIHN0YXRpYyBzbmRfcGNtX3QgKnBjbV9oYW5kbGUg
PSBOVUxMOwogCkBAIC0xMDE1LDYgKzEwMTYsNyBAQCBzdGF0aWMgdm9pZCBoZWxwKHZvaWQpCiAJ
ICAgIi13LC0td2F2ZmlsZQlVc2UgdGhlIGdpdmVuIFdBViBmaWxlIGFzIGEgdGVzdCBzb3VuZFxu
IgogCSAgICItVywtLXdhdmRpcglTcGVjaWZ5IHRoZSBkaXJlY3RvcnkgY29udGFpbmluZyBXQVYg
ZmlsZXNcbiIKIAkgICAiLW0sLS1jaG1hcAlTcGVjaWZ5IHRoZSBjaGFubmVsIG1hcCB0byBvdmVy
cmlkZVxuIgorCSAgICItWCwtLWZvcmNlLWZyZXF1ZW5jeQlmb3JjZSBmcmVxdWVuY2llcyBvdXRz
aWRlIHRoZSAzMC04MDAwaHogcmFuZ2VcbiIKIAkgICAiXG4iKSk7CiAgIHByaW50ZihfKCJSZWNv
Z25pemVkIHNhbXBsZSBmb3JtYXRzIGFyZToiKSk7CiAgIGZvciAoZm10ID0gc3VwcG9ydGVkX2Zv
cm1hdHM7ICpmbXQgPj0gMDsgZm10KyspIHsKQEAgLTEwNTcsNiArMTA1OSw3IEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pIHsKICAgICB7IndhdmZpbGUiLCAgIDEsIE5VTEwsICd3
J30sCiAgICAgeyJ3YXZkaXIiLCAgICAxLCBOVUxMLCAnVyd9LAogICAgIHsiZGVidWciLAkgIDAs
IE5VTEwsICdkJ30sCisgICAgeyJmb3JjZS1mcmVxdWVuY3kiLAkgIDAsIE5VTEwsICdYJ30sCiAj
aWZkZWYgQ09ORklHX1NVUFBPUlRfQ0hNQVAKICAgICB7ImNobWFwIiwJICAxLCBOVUxMLCAnbSd9
LAogI2VuZGlmCkBAIC0xMDc4LDcgKzEwODEsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKSB7CiAgIHdoaWxlICgxKSB7CiAgICAgaW50IGM7CiAgICAgCi0gICAgaWYgKChjID0g
Z2V0b3B0X2xvbmcoYXJnYywgYXJndiwgImhEOnI6YzpmOkY6YjpwOlA6dDpsOnM6dzpXOmQiCisg
ICAgaWYgKChjID0gZ2V0b3B0X2xvbmcoYXJnYywgYXJndiwgImhEOnI6YzpmOkY6YjpwOlA6dDps
OnM6dzpXOmQ6WCIKICNpZmRlZiBDT05GSUdfU1VQUE9SVF9DSE1BUAogCQkJICJtOiIKICNlbmRp
ZgpAQCAtMTExNCw4ICsxMTE3LDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkg
ewogICAgICAgYnJlYWs7CiAgICAgY2FzZSAnZic6CiAgICAgICBmcmVxID0gYXRvZihvcHRhcmcp
OwotICAgICAgZnJlcSA9IGZyZXEgPCAzMC4wID8gMzAuMCA6IGZyZXE7Ci0gICAgICBmcmVxID0g
ZnJlcSA+IDUwMDAuMCA/IDUwMDAuMCA6IGZyZXE7CiAgICAgICBicmVhazsKICAgICBjYXNlICdi
JzoKICAgICAgIGJ1ZmZlcl90aW1lID0gYXRvaShvcHRhcmcpOwpAQCAtMTE3Myw2ICsxMTc0LDkg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkgewogICAgIGNhc2UgJ2QnOgogICAg
ICAgZGVidWcgPSAxOwogICAgICAgYnJlYWs7CisgICAgY2FzZSAnWCc6CisgICAgICBmb3JjZV9m
cmVxdWVuY3kgPSAxOworICAgICAgYnJlYWs7CiAjaWZkZWYgQ09ORklHX1NVUFBPUlRfQ0hNQVAK
ICAgICBjYXNlICdtJzoKICAgICAgIGNobWFwID0gb3B0YXJnOwpAQCAtMTE5MCw2ICsxMTk0LDEz
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsKICAgICBleGl0KEVYSVRfU1VD
Q0VTUyk7CiAgIH0KIAorICBpZiAoIWZvcmNlX2ZyZXF1ZW5jeSkgeworICAgIGZyZXEgPSBmcmVx
IDwgMzAuMCA/IDMwLjAgOiBmcmVxOworICAgIGZyZXEgPSBmcmVxID4gODAwMC4wID8gODAwMC4w
IDogZnJlcTsKKyAgfSBlbHNlIHsKKyAgICBmcmVxID0gZnJlcSA8IDEuMCA/IDEuMCA6IGZyZXE7
CisgIH0KKwogICBpZiAodGVzdF90eXBlID09IFRFU1RfV0FWKQogICAgIGZvcm1hdCA9IFNORF9Q
Q01fRk9STUFUX1MxNl9MRTsgLyogZml4ZWQgZm9ybWF0ICovCiAKLS0gCjEuOC4zLjIKCg==
--20cf300e51e51b3f9604f3284c7d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf300e51e51b3f9604f3284c7d--
