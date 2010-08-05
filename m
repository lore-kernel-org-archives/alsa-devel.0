From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [LAD] [alsa-devel]  announcing envy24control,
	mudita (*) edition.
Date: Wed, 4 Aug 2010 19:18:49 -0700
Message-ID: <AANLkTi=srm_ACCVi5t=Pd_PuUaLsTFvxf7CK_9WSvh08@mail.gmail.com>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
	<201007282012.39291.termtech@rogers.com>
	<201007282110.33065.termtech@rogers.com>
	<201007311506.56614.termtech@rogers.com>
	<AANLkTik61RwcMtZQ6VsD7JHtvdC9F=N2kgjiS9JoMiV9@mail.gmail.com>
	<20100801225410.GF4060@zita2>
	<AANLkTi=e_uy_44wmn=zK5Nd=W28wu0M3NocLR7nO+=B0@mail.gmail.com>
	<AANLkTikyxQGAVUj8aY7pMRKfxf1c6cUgn8b4aw2kmWY-@mail.gmail.com>
	<AANLkTi=srCoxcNf9gfbA_Mo8yFbdJe4AMPSHack4XqfY@mail.gmail.com>
	<AANLkTinoDYS_X32A0LcDN-2JBa84vyncvzPOZ5OXFP29@mail.gmail.com>
	<AANLkTi=-6DeeoqdOks38Khh0ux3K=aH7OQSwT4UhYdF7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364ed268b44191048d0a2b9d
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <AANLkTi=-6DeeoqdOks38Khh0ux3K=aH7OQSwT4UhYdF7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Raymond Yau <superquad.vortex2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux Audio Developers <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--0016364ed268b44191048d0a2b9d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 4, 2010 at 1:20 AM, Raymond Yau <superquad.vortex2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
> The "-D" option seem to be used similar to =C2=A0"amixer -Dabc"
> ctl.abc {=C2=A0 type hw ,  card 2 }

Raymond --

Thanks for the clarification regarding the use of the -D argument for
alsa control devices. I've updated my code to handle things in the
same way that amixer does. The diffs for this change are at the end of
this message, and attached. ALSA names for examples/tests below from
http://nielsmayer.com/npm/dot-asoundrc.txt ....

.........................................
gnulem-277-~> /usr/bin/envy24control -D66    ##behavior on current
head and latest stable release
Segmentation fault (core dumped)
gnulem-278-~> envy24control -D66                ##behavior using this patch=
 ...
using	 --- input_channels: 4
gnulem-279-~> envy24control -D666
ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL 666
envy24control: cannot open mixer: No such file or directory - '666'
gnulem-280-~> envy24control -Dhw:66
envy24control: invalid ALSA audio device, invalid index or name for card: h=
w:66
gnulem-281-~> envy24control -Dhw:M66
using	 --- input_channels: 4
gnulem-282-~> envy24control -Dmulti
invalid card type (driver is HDA-Intel)
gnulem-283-~> envy24control -Ddefault
invalid card type (driver is USB-Audio)
gnulem-284-~> envy24control -c default
envy24control: invalid ALSA index or name for audio card: default
gnulem-285-~> envy24control -c SB
invalid card type (driver is HDA-Intel)
gnulem-286-~> envy24control -c multi
envy24control: invalid ALSA index or name for audio card: multi
gnulem-287-~> envy24control -c M66
using	 --- input_channels: 4
gnulem-299-~> amixer -Dhw:/dev/snd/controlC2 >! /tmp/foo
gnulem-301-~> amixer -D/dev/snd/controlC2 > ! /tmp/foo
ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL /dev/snd/control=
C2
amixer: Mixer attach /dev/snd/controlC2 error: No such file or directory
gnulem-290-~> envy24control -D/dev/snd/controlC2
ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL /dev/snd/control=
C2
envy24control: cannot open mixer: No such file or directory -
'/dev/snd/controlC2'

.........................................

diff --git a/envy24control/envy24control.c b/envy24control/envy24control.c
index 0b2749e..e5d89d0 100644
--- a/envy24control/envy24control.c
+++ b/envy24control/envy24control.c
@@ -2084,3 +2166,3 @@ int main(int argc, char **argv)
 	view_spdif_playback =3D 0;
 	profiles_file_name =3D DEFAULT_PROFILERC;
 	default_profile =3D NULL;
	while ((c =3D getopt_long(argc, argv, "D:c:f:i:m:Mo:p:s:w:vt:",
long_options, NULL)) !=3D -1) {
 		switch (c) {
 		case 'D':
-			name =3D optarg;
-			card_number =3D atoi(strchr(name, ':') + sizeof(char));
-			if (card_number < 0 || card_number >=3D MAX_CARD_NUMBERS) {
-				fprintf(stderr, "envy24control: invalid card number %d\n", card_number=
);
-				exit(1);
+			/* NPM: old code assumed ':' present, e.g. "-Dhw:66",
+			 * (w/ .asoundrc "ctl.66 {type hw, card M66}") and would
+			 * coredump if given "-D66". Prevent the coredump and even
+			 * handle latter case even if keying off ':' is not a
+			 * good way to do this. Note that for snd_card_get_index()
+			 * "The accepted format is an integer value in ASCII
representation or the card
+			 * identifier (the id parameter for sound-card drivers). The control de=
vice
+			 * name like /dev/snd/controlC0 is accepted, too." */
+			if (!index(optarg, ':')) {
+			  /* NPM: unlike old envy24control code, but behaving like amixer et al=
,
+			     "-D66" is valid. Handle it. */
+			  snd_mixer_t *mixer;
+			  struct snd_mixer_selem_regopt selem_regopt =3D {
+			    .ver =3D 1,
+			    .abstract =3D SND_MIXER_SABSTRACT_NONE,
+			    .device =3D optarg,
+			  };
+			  if ((err =3D snd_mixer_open(&mixer, 0)) < 0) {
+			    fprintf(stderr, "envy24control: cannot open mixer: %s -
'%s'\n", snd_strerror(err), optarg);
+			    exit(1);
+			  }
+			  if ((err =3D snd_mixer_selem_register(mixer, &selem_regopt, NULL)) < =
0) {
+			    fprintf(stderr, "envy24control: cannot open mixer: %s -
'%s'\n", snd_strerror(err), optarg);
+			    exit(1);
+			  }
+			  name =3D optarg; /* NPM: now that device name validated,  e.g.
pass "-D66" unaltered to snd_ctl_open()... */
+			}
+			else {
+			  /* NPM: handle e.g. optarg =3D=3D "hw:M66" */
+			  card_number =3D snd_card_get_index(strchr(optarg, ':') +
sizeof(char)); /* NPM: use correct ALSA-specific call to fix
https://bugzilla.redhat.com/show_bug.cgi?id=3D602900  */
+			  if (card_number < 0) {
+			    fprintf(stderr, "envy24control: invalid ALSA audio device,
invalid index or name for card: %s\n", optarg);
+			    exit(1);
+			  }
+			  name =3D optarg; /* e.g. optarg =3D=3D "hw:M66" passed to
snd_ctl_open() below */
 			}
 			break;
 		case 'c':
-			i =3D atoi(optarg);
-			if (i < 0 || i >=3D MAX_CARD_NUMBERS) {
-				fprintf(stderr, "envy24control: invalid card number %d\n", i);
+			card_number =3D snd_card_get_index(optarg); /* NPM: use correct
ALSA-specific call to fix
https://bugzilla.redhat.com/show_bug.cgi?id=3D602900  */
+			if (card_number < 0) {		/* NPM: code orig from alsa-utils/alsamixer/cli=
.c */
+				fprintf(stderr, "envy24control: invalid ALSA index or name for
audio card: %s\n", optarg);
 				exit(1);
 			}
-			card_number =3D i;
-			sprintf(tmpname, "hw:%d", i);
+			sprintf(tmpname, "hw:%d", card_number); /* e.g. "hw:M66" for arg
"-cM66" passed to snd_ctl_open() below */
 			name =3D tmpname;
 			break;
 		case 'f':

.........................................

--Niels
http://nielsmayer.com

--0016364ed268b44191048d0a2b9d
Content-Type: text/x-patch; charset=US-ASCII; name="fix-alsa-ctl-device-params.patch"
Content-Disposition: attachment; filename="fix-alsa-ctl-device-params.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcgz7hue0

ZGlmZiAtLWdpdCBhL2VudnkyNGNvbnRyb2wvZW52eTI0Y29udHJvbC5jIGIvZW52eTI0Y29udHJv
bC9lbnZ5MjRjb250cm9sLmMKaW5kZXggMGIyNzQ5ZS4uZTVkODlkMCAxMDA2NDQKLS0tIGEvZW52
eTI0Y29udHJvbC9lbnZ5MjRjb250cm9sLmMKKysrIGIvZW52eTI0Y29udHJvbC9lbnZ5MjRjb250
cm9sLmMKQEAgLTIwODQsMyArMjE2NiwzIEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJn
dikKIAl2aWV3X3NwZGlmX3BsYXliYWNrID0gMDsKIAlwcm9maWxlc19maWxlX25hbWUgPSBERUZB
VUxUX1BST0ZJTEVSQzsKIAlkZWZhdWx0X3Byb2ZpbGUgPSBOVUxMOwoJd2hpbGUgKChjID0gZ2V0
b3B0X2xvbmcoYXJnYywgYXJndiwgIkQ6YzpmOmk6bTpNbzpwOnM6dzp2dDoiLCBsb25nX29wdGlv
bnMsIE5VTEwpKSAhPSAtMSkgewogCQlzd2l0Y2ggKGMpIHsKIAkJY2FzZSAnRCc6Ci0JCQluYW1l
ID0gb3B0YXJnOwotCQkJY2FyZF9udW1iZXIgPSBhdG9pKHN0cmNocihuYW1lLCAnOicpICsgc2l6
ZW9mKGNoYXIpKTsKLQkJCWlmIChjYXJkX251bWJlciA8IDAgfHwgY2FyZF9udW1iZXIgPj0gTUFY
X0NBUkRfTlVNQkVSUykgewotCQkJCWZwcmludGYoc3RkZXJyLCAiZW52eTI0Y29udHJvbDogaW52
YWxpZCBjYXJkIG51bWJlciAlZFxuIiwgY2FyZF9udW1iZXIpOwotCQkJCWV4aXQoMSk7CisJCQkv
KiBOUE06IG9sZCBjb2RlIGFzc3VtZWQgJzonIHByZXNlbnQsIGUuZy4gIi1EaHc6NjYiLAorCQkJ
ICogKHcvIC5hc291bmRyYyAiY3RsLjY2IHt0eXBlIGh3LCBjYXJkIE02Nn0iKSBhbmQgd291bGQK
KwkJCSAqIGNvcmVkdW1wIGlmIGdpdmVuICItRDY2Ii4gUHJldmVudCB0aGUgY29yZWR1bXAgYW5k
IGV2ZW4KKwkJCSAqIGhhbmRsZSBsYXR0ZXIgY2FzZSBldmVuIGlmIGtleWluZyBvZmYgJzonIGlz
IG5vdCBhIAorCQkJICogZ29vZCB3YXkgdG8gZG8gdGhpcy4gTm90ZSB0aGF0IGZvciBzbmRfY2Fy
ZF9nZXRfaW5kZXgoKQorCQkJICogIlRoZSBhY2NlcHRlZCBmb3JtYXQgaXMgYW4gaW50ZWdlciB2
YWx1ZSBpbiBBU0NJSSByZXByZXNlbnRhdGlvbiBvciB0aGUgY2FyZAorCQkJICogaWRlbnRpZmll
ciAodGhlIGlkIHBhcmFtZXRlciBmb3Igc291bmQtY2FyZCBkcml2ZXJzKS4gVGhlIGNvbnRyb2wg
ZGV2aWNlCisJCQkgKiBuYW1lIGxpa2UgL2Rldi9zbmQvY29udHJvbEMwIGlzIGFjY2VwdGVkLCB0
b28uIiAqLworCQkJaWYgKCFpbmRleChvcHRhcmcsICc6JykpIHsgCisJCQkgIC8qIE5QTTogdW5s
aWtlIG9sZCBlbnZ5MjRjb250cm9sIGNvZGUsIGJ1dCBiZWhhdmluZyBsaWtlIGFtaXhlciBldCBh
bCwKKwkJCSAgICAgIi1ENjYiIGlzIHZhbGlkLiBIYW5kbGUgaXQuICovCisJCQkgIHNuZF9taXhl
cl90ICptaXhlcjsKKwkJCSAgc3RydWN0IHNuZF9taXhlcl9zZWxlbV9yZWdvcHQgc2VsZW1fcmVn
b3B0ID0geworCQkJICAgIC52ZXIgPSAxLAorCQkJICAgIC5hYnN0cmFjdCA9IFNORF9NSVhFUl9T
QUJTVFJBQ1RfTk9ORSwKKwkJCSAgICAuZGV2aWNlID0gb3B0YXJnLAorCQkJICB9OworCQkJICBp
ZiAoKGVyciA9IHNuZF9taXhlcl9vcGVuKCZtaXhlciwgMCkpIDwgMCkgeworCQkJICAgIGZwcmlu
dGYoc3RkZXJyLCAiZW52eTI0Y29udHJvbDogY2Fubm90IG9wZW4gbWl4ZXI6ICVzIC0gJyVzJ1xu
Iiwgc25kX3N0cmVycm9yKGVyciksIG9wdGFyZyk7CisJCQkgICAgZXhpdCgxKTsKKwkJCSAgfQor
CQkJICBpZiAoKGVyciA9IHNuZF9taXhlcl9zZWxlbV9yZWdpc3RlcihtaXhlciwgJnNlbGVtX3Jl
Z29wdCwgTlVMTCkpIDwgMCkgeworCQkJICAgIGZwcmludGYoc3RkZXJyLCAiZW52eTI0Y29udHJv
bDogY2Fubm90IG9wZW4gbWl4ZXI6ICVzIC0gJyVzJ1xuIiwgc25kX3N0cmVycm9yKGVyciksIG9w
dGFyZyk7CisJCQkgICAgZXhpdCgxKTsKKwkJCSAgfQorCQkJICBuYW1lID0gb3B0YXJnOyAvKiBO
UE06IG5vdyB0aGF0IGRldmljZSBuYW1lIHZhbGlkYXRlZCwgIGUuZy4gcGFzcyAiLUQ2NiIgdW5h
bHRlcmVkIHRvIHNuZF9jdGxfb3BlbigpLi4uICovCisJCQl9CisJCQllbHNlIHsKKwkJCSAgLyog
TlBNOiBoYW5kbGUgZS5nLiBvcHRhcmcgPT0gImh3Ok02NiIgKi8KKwkJCSAgY2FyZF9udW1iZXIg
PSBzbmRfY2FyZF9nZXRfaW5kZXgoc3RyY2hyKG9wdGFyZywgJzonKSArIHNpemVvZihjaGFyKSk7
IC8qIE5QTTogdXNlIGNvcnJlY3QgQUxTQS1zcGVjaWZpYyBjYWxsIHRvIGZpeCBodHRwczovL2J1
Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTYwMjkwMCAgKi8KKwkJCSAgaWYgKGNh
cmRfbnVtYmVyIDwgMCkgeworCQkJICAgIGZwcmludGYoc3RkZXJyLCAiZW52eTI0Y29udHJvbDog
aW52YWxpZCBBTFNBIGF1ZGlvIGRldmljZSwgaW52YWxpZCBpbmRleCBvciBuYW1lIGZvciBjYXJk
OiAlc1xuIiwgb3B0YXJnKTsKKwkJCSAgICBleGl0KDEpOworCQkJICB9CisJCQkgIG5hbWUgPSBv
cHRhcmc7IC8qIGUuZy4gb3B0YXJnID09ICJodzpNNjYiIHBhc3NlZCB0byBzbmRfY3RsX29wZW4o
KSBiZWxvdyAqLwogCQkJfQogCQkJYnJlYWs7CiAJCWNhc2UgJ2MnOgotCQkJaSA9IGF0b2kob3B0
YXJnKTsKLQkJCWlmIChpIDwgMCB8fCBpID49IE1BWF9DQVJEX05VTUJFUlMpIHsKLQkJCQlmcHJp
bnRmKHN0ZGVyciwgImVudnkyNGNvbnRyb2w6IGludmFsaWQgY2FyZCBudW1iZXIgJWRcbiIsIGkp
OworCQkJY2FyZF9udW1iZXIgPSBzbmRfY2FyZF9nZXRfaW5kZXgob3B0YXJnKTsgLyogTlBNOiB1
c2UgY29ycmVjdCBBTFNBLXNwZWNpZmljIGNhbGwgdG8gZml4IGh0dHBzOi8vYnVnemlsbGEucmVk
aGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9NjAyOTAwICAqLworCQkJaWYgKGNhcmRfbnVtYmVyIDwg
MCkgewkJLyogTlBNOiBjb2RlIG9yaWcgZnJvbSBhbHNhLXV0aWxzL2Fsc2FtaXhlci9jbGkuYyAq
LworCQkJCWZwcmludGYoc3RkZXJyLCAiZW52eTI0Y29udHJvbDogaW52YWxpZCBBTFNBIGluZGV4
IG9yIG5hbWUgZm9yIGF1ZGlvIGNhcmQ6ICVzXG4iLCBvcHRhcmcpOwogCQkJCWV4aXQoMSk7CiAJ
CQl9Ci0JCQljYXJkX251bWJlciA9IGk7Ci0JCQlzcHJpbnRmKHRtcG5hbWUsICJodzolZCIsIGkp
OworCQkJc3ByaW50Zih0bXBuYW1lLCAiaHc6JWQiLCBjYXJkX251bWJlcik7IC8qIGUuZy4gImh3
Ok02NiIgZm9yIGFyZyAiLWNNNjYiIHBhc3NlZCB0byBzbmRfY3RsX29wZW4oKSBiZWxvdyAqLwog
CQkJbmFtZSA9IHRtcG5hbWU7CiAJCQlicmVhazsKIAkJY2FzZSAnZic6Cg==
--0016364ed268b44191048d0a2b9d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-audio-dev mailing list
Linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
http://lists.linuxaudio.org/listinfo/linux-audio-dev

--0016364ed268b44191048d0a2b9d--
