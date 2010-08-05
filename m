From: Niels Mayer <nielsmayer@gmail.com>
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Wed, 4 Aug 2010 21:11:31 -0700
Message-ID: <AANLkTika6-jw+esswwSSvn-X=+hRELiD=zP0Zm5AhS24@mail.gmail.com>
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
	<AANLkTi=srm_ACCVi5t=Pd_PuUaLsTFvxf7CK_9WSvh08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636d34e99bde222048d0bbee7
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id E382F2445E
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 06:11:31 +0200 (CEST)
Received: by vws20 with SMTP id 20so5303895vws.38
	for <alsa-devel@alsa-project.org>; Wed, 04 Aug 2010 21:11:31 -0700 (PDT)
In-Reply-To: <AANLkTi=srm_ACCVi5t=Pd_PuUaLsTFvxf7CK_9WSvh08@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Audio Developers <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

--001636d34e99bde222048d0bbee7
Content-Type: text/plain; charset=UTF-8

Actually, there's a much simpler version of this patch, since the
previous code provided some extra validation and pretty error
messages, but no information that couldn't be provided by
snd_ctl_open(), e.g.:
....
gnulem-336-~> envy24control -Dfoo
ALSA lib control.c:902:(snd_ctl_open_noupdate) Invalid CTL foo
snd_ctl_open: No such file or directory
....

diff --git a/envy24control/envy24control.c b/envy24control/envy24control.c
index 0b2749e..3798ba3 100644
--- a/envy24control/envy24control.c
+++ b/envy24control/envy24control.c
@@ -2084,24 +2166,50 @@ int main(int argc, char **argv)
 	view_spdif_playback = 0;
 	profiles_file_name = DEFAULT_PROFILERC;
 	default_profile = NULL;
	while ((c = getopt_long(argc, argv, "D:c:f:i:m:Mo:p:s:w:vt:",
long_options, NULL)) != -1) {
 		switch (c) {
 		case 'D':
-			name = optarg;
-			card_number = atoi(strchr(name, ':') + sizeof(char));
-			if (card_number < 0 || card_number >= MAX_CARD_NUMBERS) {
-				fprintf(stderr, "envy24control: invalid card number %d\n", card_number);
-				exit(1);
-			}
+		/*
+		 * NPM: use ALSA code to fix/validate
+		 * https://bugzilla.redhat.com/show_bug.cgi?id=602900
+		 * The old code assumed ':' present, e.g. "-Dhw:66", (w/
+		 * .asoundrc "ctl.66 {type hw, card M66}") and would
+		 * coredump if given "-D66". Here, by not worrying about
+		 * "hw:" and passing "optarg" as-is via 'name' to
+		 * snd_ctl_open() below, resolves the issue, giving similar
+		 * behavior as 'amixer'.  However, letting snd_ctl_open()
+		 * validate gives less helpful error messages on
+		 * failure: "envy24control -Dhw:foo"
+		 *           ==> "snd_ctl_open: No such device"
+		 * So validate the arg as ALSA CTL, providing
+		 * a more specific error message and fail first if not valid.
+		 */
+			name = optarg; /* NPM: e.g. pass "-D66" unaltered to
snd_ctl_open() and let it validate valid ALSA CTL name */
+			if (index(optarg, ':')) { /* NPM: handle e.g. optarg == "hw:M66" */
+			    card_number = snd_card_get_index(strchr(optarg, ':') + sizeof(char));
+			    if (card_number < 0) {
+			      fprintf(stderr, "envy24control: invalid ALSA audio device,
invalid index or name for card: %s\n", optarg);
+			      exit(1);
+			    }
+			  }
 			break;
 		case 'c':
-			i = atoi(optarg);
-			if (i < 0 || i >= MAX_CARD_NUMBERS) {
-				fprintf(stderr, "envy24control: invalid card number %d\n", i);
+	        /*
+		  NPM: use snd_card_get_index() to fix/validate
+		  https://bugzilla.redhat.com/show_bug.cgi?id=602900
+		 * NPM: nb :"The accepted format is
+		 * an integer value in ASCII representation or the card
+		 * identifier (the id parameter for sound-card
+		 * drivers). The control device name like
+		 * /dev/snd/controlC0 is accepted, too."
+		 */
+			card_number = snd_card_get_index(optarg);
+			if (card_number < 0) {		/* NPM: code orig from alsa-utils/alsamixer/cli.c */
+				fprintf(stderr, "envy24control: invalid ALSA index or name for
audio card: %s\n", optarg);
 				exit(1);
 			}
-			card_number = i;
-			sprintf(tmpname, "hw:%d", i);
+			sprintf(tmpname, "hw:%d", card_number); /* e.g. "hw:M66" for arg
"-cM66" passed to snd_ctl_open() below */
 			name = tmpname;
 			break;
 		case 'f':

...................................

Niels
http://nielsmayer.com

--001636d34e99bde222048d0bbee7
Content-Type: text/x-patch; charset=US-ASCII; name="fix-alsa-ctl-device-params.patch"
Content-Disposition: attachment; filename="fix-alsa-ctl-device-params.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gch2iowg1

ZGlmZiAtLWdpdCBhL2VudnkyNGNvbnRyb2wvZW52eTI0Y29udHJvbC5jIGIvZW52eTI0Y29udHJv
bC9lbnZ5MjRjb250cm9sLmMKaW5kZXggMGIyNzQ5ZS4uMzc5OGJhMyAxMDA2NDQKLS0tIGEvZW52
eTI0Y29udHJvbC9lbnZ5MjRjb250cm9sLmMKKysrIGIvZW52eTI0Y29udHJvbC9lbnZ5MjRjb250
cm9sLmMKQEAgLTIwODQsMjQgKzIxNjYsNTAgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiph
cmd2KQogCXZpZXdfc3BkaWZfcGxheWJhY2sgPSAwOwogCXByb2ZpbGVzX2ZpbGVfbmFtZSA9IERF
RkFVTFRfUFJPRklMRVJDOwogCWRlZmF1bHRfcHJvZmlsZSA9IE5VTEw7Cgl3aGlsZSAoKGMgPSBn
ZXRvcHRfbG9uZyhhcmdjLCBhcmd2LCAiRDpjOmY6aTptOk1vOnA6czp3OnZ0OiIsIGxvbmdfb3B0
aW9ucywgTlVMTCkpICE9IC0xKSB7CiAJCXN3aXRjaCAoYykgewogCQljYXNlICdEJzoKLQkJCW5h
bWUgPSBvcHRhcmc7Ci0JCQljYXJkX251bWJlciA9IGF0b2koc3RyY2hyKG5hbWUsICc6JykgKyBz
aXplb2YoY2hhcikpOwotCQkJaWYgKGNhcmRfbnVtYmVyIDwgMCB8fCBjYXJkX251bWJlciA+PSBN
QVhfQ0FSRF9OVU1CRVJTKSB7Ci0JCQkJZnByaW50ZihzdGRlcnIsICJlbnZ5MjRjb250cm9sOiBp
bnZhbGlkIGNhcmQgbnVtYmVyICVkXG4iLCBjYXJkX251bWJlcik7Ci0JCQkJZXhpdCgxKTsKLQkJ
CX0KKwkJLyoKKwkJICogTlBNOiB1c2UgQUxTQSBjb2RlIHRvIGZpeC92YWxpZGF0ZQorCQkgKiBo
dHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTYwMjkwMAorCQkgKiBU
aGUgb2xkIGNvZGUgYXNzdW1lZCAnOicgcHJlc2VudCwgZS5nLiAiLURodzo2NiIsICh3LworCQkg
KiAuYXNvdW5kcmMgImN0bC42NiB7dHlwZSBodywgY2FyZCBNNjZ9IikgYW5kIHdvdWxkCisJCSAq
IGNvcmVkdW1wIGlmIGdpdmVuICItRDY2Ii4gSGVyZSwgYnkgbm90IHdvcnJ5aW5nIGFib3V0CisJ
CSAqICJodzoiIGFuZCBwYXNzaW5nICJvcHRhcmciIGFzLWlzIHZpYSAnbmFtZScgdG8KKwkJICog
c25kX2N0bF9vcGVuKCkgYmVsb3csIHJlc29sdmVzIHRoZSBpc3N1ZSwgZ2l2aW5nIHNpbWlsYXIK
KwkJICogYmVoYXZpb3IgYXMgJ2FtaXhlcicuICBIb3dldmVyLCBsZXR0aW5nIHNuZF9jdGxfb3Bl
bigpCisJCSAqIHZhbGlkYXRlIGdpdmVzIGxlc3MgaGVscGZ1bCBlcnJvciBtZXNzYWdlcyBvbgor
CQkgKiBmYWlsdXJlOiAiZW52eTI0Y29udHJvbCAtRGh3OmZvbyIKKwkJICogICAgICAgICAgID09
PiAic25kX2N0bF9vcGVuOiBObyBzdWNoIGRldmljZSIKKwkJICogU28gdmFsaWRhdGUgdGhlIGFy
ZyBhcyBBTFNBIENUTCwgcHJvdmlkaW5nCisJCSAqIGEgbW9yZSBzcGVjaWZpYyBlcnJvciBtZXNz
YWdlIGFuZCBmYWlsIGZpcnN0IGlmIG5vdCB2YWxpZC4KKwkJICovCisJCQluYW1lID0gb3B0YXJn
OyAvKiBOUE06IGUuZy4gcGFzcyAiLUQ2NiIgdW5hbHRlcmVkIHRvIHNuZF9jdGxfb3BlbigpIGFu
ZCBsZXQgaXQgdmFsaWRhdGUgdmFsaWQgQUxTQSBDVEwgbmFtZSAqLworCQkJaWYgKGluZGV4KG9w
dGFyZywgJzonKSkgeyAvKiBOUE06IGhhbmRsZSBlLmcuIG9wdGFyZyA9PSAiaHc6TTY2IiAqLwor
CQkJICAgIGNhcmRfbnVtYmVyID0gc25kX2NhcmRfZ2V0X2luZGV4KHN0cmNocihvcHRhcmcsICc6
JykgKyBzaXplb2YoY2hhcikpOworCQkJICAgIGlmIChjYXJkX251bWJlciA8IDApIHsKKwkJCSAg
ICAgIGZwcmludGYoc3RkZXJyLCAiZW52eTI0Y29udHJvbDogaW52YWxpZCBBTFNBIGF1ZGlvIGRl
dmljZSwgaW52YWxpZCBpbmRleCBvciBuYW1lIGZvciBjYXJkOiAlc1xuIiwgb3B0YXJnKTsKKwkJ
CSAgICAgIGV4aXQoMSk7CisJCQkgICAgfQorCQkJICB9CiAJCQlicmVhazsKIAkJY2FzZSAnYyc6
Ci0JCQlpID0gYXRvaShvcHRhcmcpOwotCQkJaWYgKGkgPCAwIHx8IGkgPj0gTUFYX0NBUkRfTlVN
QkVSUykgewotCQkJCWZwcmludGYoc3RkZXJyLCAiZW52eTI0Y29udHJvbDogaW52YWxpZCBjYXJk
IG51bWJlciAlZFxuIiwgaSk7CisJICAgICAgICAvKgorCQkgIE5QTTogdXNlIHNuZF9jYXJkX2dl
dF9pbmRleCgpIHRvIGZpeC92YWxpZGF0ZQorCQkgIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNv
bS9zaG93X2J1Zy5jZ2k/aWQ9NjAyOTAwCisJCSAqIE5QTTogbmIgOiJUaGUgYWNjZXB0ZWQgZm9y
bWF0IGlzCisJCSAqIGFuIGludGVnZXIgdmFsdWUgaW4gQVNDSUkgcmVwcmVzZW50YXRpb24gb3Ig
dGhlIGNhcmQKKwkJICogaWRlbnRpZmllciAodGhlIGlkIHBhcmFtZXRlciBmb3Igc291bmQtY2Fy
ZAorCQkgKiBkcml2ZXJzKS4gVGhlIGNvbnRyb2wgZGV2aWNlIG5hbWUgbGlrZQorCQkgKiAvZGV2
L3NuZC9jb250cm9sQzAgaXMgYWNjZXB0ZWQsIHRvby4iCisJCSAqLworCQkJY2FyZF9udW1iZXIg
PSBzbmRfY2FyZF9nZXRfaW5kZXgob3B0YXJnKTsKKwkJCWlmIChjYXJkX251bWJlciA8IDApIHsJ
CS8qIE5QTTogY29kZSBvcmlnIGZyb20gYWxzYS11dGlscy9hbHNhbWl4ZXIvY2xpLmMgKi8KKwkJ
CQlmcHJpbnRmKHN0ZGVyciwgImVudnkyNGNvbnRyb2w6IGludmFsaWQgQUxTQSBpbmRleCBvciBu
YW1lIGZvciBhdWRpbyBjYXJkOiAlc1xuIiwgb3B0YXJnKTsKIAkJCQlleGl0KDEpOwogCQkJfQot
CQkJY2FyZF9udW1iZXIgPSBpOwotCQkJc3ByaW50Zih0bXBuYW1lLCAiaHc6JWQiLCBpKTsKKwkJ
CXNwcmludGYodG1wbmFtZSwgImh3OiVkIiwgY2FyZF9udW1iZXIpOyAvKiBlLmcuICJodzpNNjYi
IGZvciBhcmcgIi1jTTY2IiBwYXNzZWQgdG8gc25kX2N0bF9vcGVuKCkgYmVsb3cgKi8KIAkJCW5h
bWUgPSB0bXBuYW1lOwogCQkJYnJlYWs7CiAJCWNhc2UgJ2YnOgo=
--001636d34e99bde222048d0bbee7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--001636d34e99bde222048d0bbee7--
