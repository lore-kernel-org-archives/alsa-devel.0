From: Erik Ackermann <kurterikackermann@gmail.com>
Subject: Re: [PATCH - speaker-test 1/1] speaker-test: add
 --force-frequency option to allow hz outside range
Date: Tue, 25 Feb 2014 11:49:46 -0800
Message-ID: <CAN5Z5QH3o=m9rbwuFtMu8DZpDN2xfy_KsC7F6jamwG=_jcXcaA@mail.gmail.com>
References: <s5hmwhgygon.wl%tiwai@suse.de>
 <CAA2k8L1nH3OJUsEb31zWuzwWTjN3EJGSrb0Wsr=dFqYgievFKQ@mail.gmail.com>
 <s5h38j8pmni.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e016350c852bf0e04f34066e0
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f47.google.com (mail-yh0-f47.google.com
 [209.85.213.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 917E1265644
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 20:50:28 +0100 (CET)
Received: by mail-yh0-f47.google.com with SMTP id c41so7605424yho.34
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 11:50:27 -0800 (PST)
In-Reply-To: <s5h38j8pmni.wl%tiwai@suse.de>
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

--089e016350c852bf0e04f34066e0
Content-Type: text/plain; charset=ISO-8859-1

Updated the english po and de/fr/ja translations courtesy of Google
translate. Is there any sign-off required beyond the header git
format-patch adds?

Thanks,
Erik


On Mon, Feb 24, 2014 at 7:15 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 24 Feb 2014 07:04:27 -0800,
> Will R wrote:
> >
> > What is the reasoning behind the limit, protecting speaker hardware,
> > hearing?
>
> I guess so.
>
> > I think common speakers have frequency response up to 15 or 16kHz
> > or so, so maybe a bit higher default limit of 8kHz would be okay.
>
> Agreed.
>
> > I was doing some tests around 20kHz - 22kHz (to test my hearing and freq
> > response of my 25kHz rated headphones), so still see the merit in a force
> > option for people who are certain they want to test that high.
> >
> > New patch: Added min of 1.0Hz for force option, changed default max to
> > 8kHz, fixed typo in flag name:
>
> The changes look good to me.
>
> But could you update the man page, and give your sign-off, too?
>
>
> thanks,
>
> Takashi
>
>
> >
> > diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
> > index 261f399..61396f2 100644
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
> >      "-w,--wavfile Use the given WAV file as a test sound\n"
> >      "-W,--wavdir Specify the directory containing WAV files\n"
> >      "-m,--chmap Specify the channel map to override\n"
> > +    "-X,--force-frequency force frequencies outside the 30-8000hz
> range\n"
> >      "\n"));
> >    printf(_("Recognized sample formats are:"));
> >    for (fmt = supported_formats; *fmt >= 0; fmt++) {
> > @@ -1057,6 +1059,7 @@ int main(int argc, char *argv[]) {
> >      {"wavfile",   1, NULL, 'w'},
> >      {"wavdir",    1, NULL, 'W'},
> >      {"debug",   0, NULL, 'd'},
> > +    {"force-frequency",   0, NULL, 'X'},
> >  #ifdef CONFIG_SUPPORT_CHMAP
> >      {"chmap",   1, NULL, 'm'},
> >  #endif
> > @@ -1078,7 +1081,7 @@ int main(int argc, char *argv[]) {
> >    while (1) {
> >      int c;
> >
> > -    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d"
> > +    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:X"
> >  #ifdef CONFIG_SUPPORT_CHMAP
> >    "m:"
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
> > @@ -1190,6 +1194,13 @@ int main(int argc, char *argv[]) {
> >      exit(EXIT_SUCCESS);
> >    }
> >
> > +  if (!force_frequency) {
> > +    freq = freq < 30.0 ? 30.0 : freq;
> > +    freq = freq > 8000.0 ? 8000.0 : freq;
> > +  } else {
> > +    freq = freq < 1.0 ? 1.0 : freq;
> > +  }
> > +
> >    if (test_type == TEST_WAV)
> >      format = SND_PCM_FORMAT_S16_LE; /* fixed format */
> >
> > --
> > 1.8.3.2
> >
> >
> > On Mon, Feb 24, 2014 at 1:59 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Sat, 22 Feb 2014 16:09:57 -0800,
> > > erik@caspar.alsa-project.org wrote:
> > > >
> > > > From: Erik Ackermann <domohawk@gmail.com>
> > > >
> > > > Signed-off-by: Erik Ackermann <domohawk@gmail.com>
> > >
> > > But still it should have some sanity checks like freq <= 0, as freq is
> > > used as a divisor.
> > >
> > > Or, we may simply relax the frequency range.  What value do you want
> > > to take in your use case?
> > >
> > >
> > > Takashi
> > >
> > > >
> > > > diff --git a/speaker-test/speaker-test.c
> b/speaker-test/speaker-test.c
> > > > index 261f399..22927f2 100644
> > > > --- a/speaker-test/speaker-test.c
> > > > +++ b/speaker-test/speaker-test.c
> > > > @@ -106,6 +106,7 @@ static snd_pcm_uframes_t  period_size;
> > > >  static const char *given_test_wav_file = NULL;
> > > >  static char *wav_file_dir = SOUNDSDIR;
> > > >  static int debug = 0;
> > > > +static int force_frequency = 0;
> > > >  static int in_aborting = 0;
> > > >  static snd_pcm_t *pcm_handle = NULL;
> > > >
> > > > @@ -1015,6 +1016,7 @@ static void help(void)
> > > >          "-w,--wavfile        Use the given WAV file as a test
> sound\n"
> > > >          "-W,--wavdir Specify the directory containing WAV files\n"
> > > >          "-m,--chmap  Specify the channel map to override\n"
> > > > +        "-X,--force-frequency        force frequencies outside the
> > > 30-5000hz range\n"
> > > >          "\n"));
> > > >    printf(_("Recognized sample formats are:"));
> > > >    for (fmt = supported_formats; *fmt >= 0; fmt++) {
> > > > @@ -1057,6 +1059,7 @@ int main(int argc, char *argv[]) {
> > > >      {"wavfile",   1, NULL, 'w'},
> > > >      {"wavdir",    1, NULL, 'W'},
> > > >      {"debug",          0, NULL, 'd'},
> > > > +    {"force-frequncy",         1, NULL, 'X'},
> > > >  #ifdef CONFIG_SUPPORT_CHMAP
> > > >      {"chmap",          1, NULL, 'm'},
> > > >  #endif
> > > > @@ -1078,7 +1081,7 @@ int main(int argc, char *argv[]) {
> > > >    while (1) {
> > > >      int c;
> > > >
> > > > -    if ((c = getopt_long(argc, argv, "hD:r:c:f:F:b:p:P:t:l:s:w:W:d"
> > > > +    if ((c = getopt_long(argc, argv,
> "hD:r:c:f:F:b:p:P:t:l:s:w:W:d:X"
> > > >  #ifdef CONFIG_SUPPORT_CHMAP
> > > >                        "m:"
> > > >  #endif
> > > > @@ -1114,8 +1117,6 @@ int main(int argc, char *argv[]) {
> > > >        break;
> > > >      case 'f':
> > > >        freq = atof(optarg);
> > > > -      freq = freq < 30.0 ? 30.0 : freq;
> > > > -      freq = freq > 5000.0 ? 5000.0 : freq;
> > > >        break;
> > > >      case 'b':
> > > >        buffer_time = atoi(optarg);
> > > > @@ -1173,6 +1174,9 @@ int main(int argc, char *argv[]) {
> > > >      case 'd':
> > > >        debug = 1;
> > > >        break;
> > > > +    case 'X':
> > > > +      force_frequency = 1;
> > > > +      break;
> > > >  #ifdef CONFIG_SUPPORT_CHMAP
> > > >      case 'm':
> > > >        chmap = optarg;
> > > > @@ -1190,6 +1194,11 @@ int main(int argc, char *argv[]) {
> > > >      exit(EXIT_SUCCESS);
> > > >    }
> > > >
> > > > +  if (!force_frequency) {
> > > > +    freq = freq < 30.0 ? 30.0 : freq;
> > > > +    freq = freq > 5000.0 ? 5000.0 : freq;
> > > > +  }
> > > > +
> > > >    if (test_type == TEST_WAV)
> > > >      format = SND_PCM_FORMAT_S16_LE; /* fixed format */
> > > >
> > > > --
> > > > 1.8.3.2
> > > >
> > >
> > [1.2  <text/html; ISO-8859-1 (quoted-printable)>]
> >
> > From 3d9ceb42e1205618b29479077b0bd3f2d71c64db Mon Sep 17 00:00:00 2001
> > From: Erik Ackermann <domohawk@gmail.com>
> > Date: Mon, 24 Feb 2014 06:53:08 -0800
> > Subject: [PATCH - speaker-test 1/1] speaker-test: add --force-frequency
> option
> >  to allow hz outside range
> >
> > Signed-off-by: Erik Ackermann <domohawk@gmail.com>
> >
> > diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
> > index 261f399..61396f2 100644
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
> 30-8000hz range\n"
> >          "\n"));
> >    printf(_("Recognized sample formats are:"));
> >    for (fmt = supported_formats; *fmt >= 0; fmt++) {
> > @@ -1057,6 +1059,7 @@ int main(int argc, char *argv[]) {
> >      {"wavfile",   1, NULL, 'w'},
> >      {"wavdir",    1, NULL, 'W'},
> >      {"debug",          0, NULL, 'd'},
> > +    {"force-frequency",        0, NULL, 'X'},
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
> > @@ -1190,6 +1194,13 @@ int main(int argc, char *argv[]) {
> >      exit(EXIT_SUCCESS);
> >    }
> >
> > +  if (!force_frequency) {
> > +    freq = freq < 30.0 ? 30.0 : freq;
> > +    freq = freq > 8000.0 ? 8000.0 : freq;
> > +  } else {
> > +    freq = freq < 1.0 ? 1.0 : freq;
> > +  }
> > +
> >    if (test_type == TEST_WAV)
> >      format = SND_PCM_FORMAT_S16_LE; /* fixed format */
> >
> > --
> > 1.8.3.2
> >
>

--089e016350c852bf0e04f34066e0
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-speaker-test-add-force-frequency-option-to-allow-hz-.patch"
Content-Disposition: attachment;
	filename="0001-speaker-test-add-force-frequency-option-to-allow-hz-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hs3l6k0f0

RnJvbSAxOThjN2RjNzBhZmUwNGE2MDcyMDU5ZGRjOTk3NDE3YzNjZWNhM2UyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmlrIEFja2VybWFubiA8a3VydGVyaWthY2tlcm1hbm5AZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI1IEZlYiAyMDE0IDExOjQ1OjI0IC0wODAwClN1YmplY3Q6IFtQ
QVRDSCAtIHNwZWFrZXItdGVzdCAxLzFdIHNwZWFrZXItdGVzdDogYWRkIC0tZm9yY2UtZnJlcXVl
bmN5IG9wdGlvbgogdG8gYWxsb3cgaHogb3V0c2lkZSByYW5nZQoKU2lnbmVkLW9mZi1ieTogRXJp
ayBBY2tlcm1hbm4gPGt1cnRlcmlrYWNrZXJtYW5uQGdtYWlsLmNvbT4KCmRpZmYgLS1naXQgYS9w
by9kZS5wbyBiL3BvL2RlLnBvCmluZGV4IDBjNDdjNjUuLjU4NmJkZTIgMTAwNjQ0Ci0tLSBhL3Bv
L2RlLnBvCisrKyBiL3BvL2RlLnBvCkBAIC0xNDg3LDYgKzE0ODcsNyBAQCBtc2dpZCAiIgogIi1z
LC0tc3BlYWtlclx0c2luZ2xlIHNwZWFrZXIgdGVzdC4gVmFsdWVzIDE9TGVmdCwgMj1yaWdodCwg
ZXRjXG4iCiAiLXcsLS13YXZmaWxlXHRVc2UgdGhlIGdpdmVuIFdBViBmaWxlIGFzIGEgdGVzdCBz
b3VuZFxuIgogIi1XLC0td2F2ZGlyXHRTcGVjaWZ5IHRoZSBkaXJlY3RvcnkgY29udGFpbmluZyBX
QVYgZmlsZXNcbiIKKyItWCwtLWZvcmNlLWZyZXF1ZW5jeVx0Zm9yY2UgZnJlcXVlbmNpZXMgb3V0
c2lkZSB0aGUgMzAtODAwMGh6IHJhbmdlXG4iCiAiXG4iCiBtc2dzdHIgIiIKICJWZXJ3ZW5kdW5n
OiBzcGVha2VyLXRlc3QgW09wdGlvbl0uLi5cbiIKQEAgLTE1MDQsNiArMTUwNSw3IEBAIG1zZ3N0
ciAiIgogIi1zLC0tc3BlYWtlciAgICB0ZXN0ZSBlaW5lbiBlaW56ZWxuZW4gTGF1dHNwcmVjaGVy
OyAxPWxpbmtzLCAyPXJlY2h0cywgdXN3LlxuIgogIi13LC0td2F2ZmlsZSAgICBiZW51dHplIFdB
Vi1EYXRlaSBhbHMgVGVzdHRvblxuIgogIi1XLC0td2F2ZGlyICAgICBiZW51dHplIFZlcnplaWNo
bmlzIG1pdCBkYXJpbiBlbnRoYWx0ZW5lbiBXQVYtRGF0ZWllblxuIgorIi1YLC0tZm9yY2UtZnJl
cXVlbmN5XHRlcm3DtmdsaWNoZW4gRnJlcXVlbnplbiBhdcOfZXJoYWxiIGRlciAzMC04MDAwSHog
QmVyZWljaFxuIgogIlxuIgogCiAjOiBzcGVha2VyLXRlc3Qvc3BlYWtlci10ZXN0LmM6OTIxCmRp
ZmYgLS1naXQgYS9wby9mci5wbyBiL3BvL2ZyLnBvCmluZGV4IGE2MDI4YTQuLjg3NmM5YTMgMTAw
NjQ0Ci0tLSBhL3BvL2ZyLnBvCisrKyBiL3BvL2ZyLnBvCkBAIC0xNDc0LDYgKzE0NzQsNyBAQCBt
c2dpZCAiIgogIi1zLC0tc3BlYWtlclx0c2luZ2xlIHNwZWFrZXIgdGVzdC4gVmFsdWVzIDE9TGVm
dCwgMj1yaWdodCwgZXRjXG4iCiAiLXcsLS13YXZmaWxlXHRVc2UgdGhlIGdpdmVuIFdBViBmaWxl
IGFzIGEgdGVzdCBzb3VuZFxuIgogIi1XLC0td2F2ZGlyXHRTcGVjaWZ5IHRoZSBkaXJlY3Rvcnkg
Y29udGFpbmluZyBXQVYgZmlsZXNcbiIKKyItWCwtLWZvcmNlLWZyZXF1ZW5jeVx0Zm9yY2UgZnJl
cXVlbmNpZXMgb3V0c2lkZSB0aGUgMzAtODAwMGh6IHJhbmdlXG4iCiAiXG4iCiBtc2dzdHIgIiIK
ICJVdGlsaXNhdGlvbjogc3BlYWtlci10ZXN0IFtPUFRJT05dLi4uXG4iCkBAIC0xNDkyLDYgKzE0
OTMsNyBAQCBtc2dzdHIgIiIKICJcdFx0VmFsZXVycyAxPUdhdWNoZSwgMj1Ecm9pdGUsIGV0IGMu
XG4iCiAiLXcsLS13YXZmaWxlXHRVdGlsaXNlciBsZSBmaWNoaWVyIFdBViBzcMOpY2lmacOpIHBv
dXIgbGUgdGVzdFxuIgogIi13LC0td2F2ZGlyXHRTcMOpY2lmaWVyIGxlIHLDqXBlcnRvaXJlIGNv
bnRlbmFudCBsZXMgZmljaGllcnMgV0FWXG4iCisiLVgsLS1mb3JjZS1mcmVxdWVuY3lcdHBlcm1l
dHRyZSBmcsOpcXVlbmNlcyBlbiBkZWhvcnMgZGUgbGEgZ2FtbWUgMzAtODAwMEh6XG4iCiAiXG4i
CiAKICM6IC4uL3NwZWFrZXItdGVzdC9zcGVha2VyLXRlc3QuYzo4NTIKZGlmZiAtLWdpdCBhL3Bv
L2phLnBvIGIvcG8vamEucG8KaW5kZXggMmMyMzRmNC4uZDhlZjcwNiAxMDA2NDQKLS0tIGEvcG8v
amEucG8KKysrIGIvcG8vamEucG8KQEAgLTE0MjksNiArMTQyOSw3IEBAIG1zZ2lkICIiCiAiLXMs
LS1zcGVha2VyXHRzaW5nbGUgc3BlYWtlciB0ZXN0LiBWYWx1ZXMgMT1MZWZ0LCAyPXJpZ2h0LCBl
dGNcbiIKICItdywtLXdhdmZpbGVcdFVzZSB0aGUgZ2l2ZW4gV0FWIGZpbGUgYXMgYSB0ZXN0IHNv
dW5kXG4iCiAiLVcsLS13YXZkaXJcdFNwZWNpZnkgdGhlIGRpcmVjdG9yeSBjb250YWluaW5nIFdB
ViBmaWxlc1xuIgorIi1YLC0tZm9yY2UtZnJlcXVlbmN5XHRmb3JjZSBmcmVxdWVuY2llcyBvdXRz
aWRlIHRoZSAzMC04MDAwaHogcmFuZ2VcbiIKICJcbiIKIG1zZ3N0ciAiIgogIuS9v+eUqOazlTog
c3BlYWtlci10ZXN0IFvjgqrjg5fjgrfjg6fjg7NdLi4uXG4iCkBAIC0xNDQ3LDYgKzE0NDgsNyBA
QCBtc2dzdHIgIiIKICItcywtLXNwZWFrZXIgICAgICAgICDljZjkuIDjgrnjg5Tjg7zjgqvjg7zj
g4bjgrnjg4ggIDE95bemIOOBvuOBn+OBryAyPeWPs1xuIgogIi13LC0td2F2ZmlsZSAgICAgICAg
IOaMh+WumuOBrldBVuODleOCoeOCpOODq+OCkuODhuOCueODiOmfs+a6kOOBqOOBl+OBpuS9v+eU
qFxuIgogIi1XLC0td2F2ZGlyICAgICAgICAgIFdBVuODleOCoeOCpOODq+OBruOBguOCi+ODh+OC
o+ODrOOCr+ODiOODquOCkuaMh+WumlxuIgorIi1YLC0tZm9yY2UtZnJlcXVlbmN5XHQzMC04MDAw
SHrnr4Tlm7LlpJboqLHlj69cbiIKICJcbiIKIAogIzogc3BlYWtlci10ZXN0L3NwZWFrZXItdGVz
dC5jOjgzNQpkaWZmIC0tZ2l0IGEvc3BlYWtlci10ZXN0L3NwZWFrZXItdGVzdC5jIGIvc3BlYWtl
ci10ZXN0L3NwZWFrZXItdGVzdC5jCmluZGV4IDI2MWYzOTkuLjYxMzk2ZjIgMTAwNjQ0Ci0tLSBh
L3NwZWFrZXItdGVzdC9zcGVha2VyLXRlc3QuYworKysgYi9zcGVha2VyLXRlc3Qvc3BlYWtlci10
ZXN0LmMKQEAgLTEwNiw2ICsxMDYsNyBAQCBzdGF0aWMgc25kX3BjbV91ZnJhbWVzX3QgIHBlcmlv
ZF9zaXplOwogc3RhdGljIGNvbnN0IGNoYXIgKmdpdmVuX3Rlc3Rfd2F2X2ZpbGUgPSBOVUxMOwog
c3RhdGljIGNoYXIgKndhdl9maWxlX2RpciA9IFNPVU5EU0RJUjsKIHN0YXRpYyBpbnQgZGVidWcg
PSAwOworc3RhdGljIGludCBmb3JjZV9mcmVxdWVuY3kgPSAwOwogc3RhdGljIGludCBpbl9hYm9y
dGluZyA9IDA7CiBzdGF0aWMgc25kX3BjbV90ICpwY21faGFuZGxlID0gTlVMTDsKIApAQCAtMTAx
NSw2ICsxMDE2LDcgQEAgc3RhdGljIHZvaWQgaGVscCh2b2lkKQogCSAgICItdywtLXdhdmZpbGUJ
VXNlIHRoZSBnaXZlbiBXQVYgZmlsZSBhcyBhIHRlc3Qgc291bmRcbiIKIAkgICAiLVcsLS13YXZk
aXIJU3BlY2lmeSB0aGUgZGlyZWN0b3J5IGNvbnRhaW5pbmcgV0FWIGZpbGVzXG4iCiAJICAgIi1t
LC0tY2htYXAJU3BlY2lmeSB0aGUgY2hhbm5lbCBtYXAgdG8gb3ZlcnJpZGVcbiIKKwkgICAiLVgs
LS1mb3JjZS1mcmVxdWVuY3kJZm9yY2UgZnJlcXVlbmNpZXMgb3V0c2lkZSB0aGUgMzAtODAwMGh6
IHJhbmdlXG4iCiAJICAgIlxuIikpOwogICBwcmludGYoXygiUmVjb2duaXplZCBzYW1wbGUgZm9y
bWF0cyBhcmU6IikpOwogICBmb3IgKGZtdCA9IHN1cHBvcnRlZF9mb3JtYXRzOyAqZm10ID49IDA7
IGZtdCsrKSB7CkBAIC0xMDU3LDYgKzEwNTksNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKSB7CiAgICAgeyJ3YXZmaWxlIiwgICAxLCBOVUxMLCAndyd9LAogICAgIHsid2F2ZGly
IiwgICAgMSwgTlVMTCwgJ1cnfSwKICAgICB7ImRlYnVnIiwJICAwLCBOVUxMLCAnZCd9LAorICAg
IHsiZm9yY2UtZnJlcXVlbmN5IiwJICAwLCBOVUxMLCAnWCd9LAogI2lmZGVmIENPTkZJR19TVVBQ
T1JUX0NITUFQCiAgICAgeyJjaG1hcCIsCSAgMSwgTlVMTCwgJ20nfSwKICNlbmRpZgpAQCAtMTA3
OCw3ICsxMDgxLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkgewogICB3aGls
ZSAoMSkgewogICAgIGludCBjOwogICAgIAotICAgIGlmICgoYyA9IGdldG9wdF9sb25nKGFyZ2Ms
IGFyZ3YsICJoRDpyOmM6ZjpGOmI6cDpQOnQ6bDpzOnc6VzpkIgorICAgIGlmICgoYyA9IGdldG9w
dF9sb25nKGFyZ2MsIGFyZ3YsICJoRDpyOmM6ZjpGOmI6cDpQOnQ6bDpzOnc6VzpkOlgiCiAjaWZk
ZWYgQ09ORklHX1NVUFBPUlRfQ0hNQVAKIAkJCSAibToiCiAjZW5kaWYKQEAgLTExMTQsOCArMTEx
Nyw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsKICAgICAgIGJyZWFrOwog
ICAgIGNhc2UgJ2YnOgogICAgICAgZnJlcSA9IGF0b2Yob3B0YXJnKTsKLSAgICAgIGZyZXEgPSBm
cmVxIDwgMzAuMCA/IDMwLjAgOiBmcmVxOwotICAgICAgZnJlcSA9IGZyZXEgPiA1MDAwLjAgPyA1
MDAwLjAgOiBmcmVxOwogICAgICAgYnJlYWs7CiAgICAgY2FzZSAnYic6CiAgICAgICBidWZmZXJf
dGltZSA9IGF0b2kob3B0YXJnKTsKQEAgLTExNzMsNiArMTE3NCw5IEBAIGludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pIHsKICAgICBjYXNlICdkJzoKICAgICAgIGRlYnVnID0gMTsKICAg
ICAgIGJyZWFrOworICAgIGNhc2UgJ1gnOgorICAgICAgZm9yY2VfZnJlcXVlbmN5ID0gMTsKKyAg
ICAgIGJyZWFrOwogI2lmZGVmIENPTkZJR19TVVBQT1JUX0NITUFQCiAgICAgY2FzZSAnbSc6CiAg
ICAgICBjaG1hcCA9IG9wdGFyZzsKQEAgLTExOTAsNiArMTE5NCwxMyBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKSB7CiAgICAgZXhpdChFWElUX1NVQ0NFU1MpOwogICB9CiAKKyAg
aWYgKCFmb3JjZV9mcmVxdWVuY3kpIHsKKyAgICBmcmVxID0gZnJlcSA8IDMwLjAgPyAzMC4wIDog
ZnJlcTsKKyAgICBmcmVxID0gZnJlcSA+IDgwMDAuMCA/IDgwMDAuMCA6IGZyZXE7CisgIH0gZWxz
ZSB7CisgICAgZnJlcSA9IGZyZXEgPCAxLjAgPyAxLjAgOiBmcmVxOworICB9CisKICAgaWYgKHRl
c3RfdHlwZSA9PSBURVNUX1dBVikKICAgICBmb3JtYXQgPSBTTkRfUENNX0ZPUk1BVF9TMTZfTEU7
IC8qIGZpeGVkIGZvcm1hdCAqLwogCi0tIAoxLjguMy4yCgo=
--089e016350c852bf0e04f34066e0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--089e016350c852bf0e04f34066e0--
