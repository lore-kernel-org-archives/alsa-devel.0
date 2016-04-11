From: Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: Improve missing break for
	switch/case tests
Date: Sun, 10 Apr 2016 19:26:22 -0700
Message-ID: <1460341582.1800.66.camel@perches.com>
References: <D32C47F6.1E2FD%ryan.harvey@cirrus.com>
 <s5hfuuvcfsr.wl-tiwai@suse.de> <570928CC.6030404@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0239.hostedemail.com
 [216.40.44.239])
 by alsa0.perex.cz (Postfix) with ESMTP id 45713261469
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 04:26:27 +0200 (CEST)
In-Reply-To: <570928CC.6030404@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@shadowen.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, LKML <linux-kernel@vger.kernel.org>, "Harvey, Ryan" <Ryan.Harvey@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The current switch/case test doesn't handle ... case labels like:

	switch (foo) {
	case bar ... baz:
		etc...
	}

Add a specific regex for that form and the default label.
Use the regex where a case label is tested.

Improve the missing break/fall-through test by only reporting
the first case label missing the break not every case label
where there isn't a preceding break/fall-through.

Show the line above the case label when reporting
the possible defect.

Signed-off-by: Joe Perches <joe@perches.com>
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
---
=A0scripts/checkpatch.pl | 18 ++++++++++++------
=A01 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e3d9c34..216e4a1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -331,6 +331,11 @@ our $Operators	=3D qr{
=A0		=A0=A0}x;
=A0
=A0our $c90_Keywords =3D qr{do|for|while|if|else|return|goto|continue|switc=
h|default|case|break}x;
+our $case_label =3D qr{
+			(?:case\s+(?:$Ident|$Constant)
+			=A0=A0=A0=A0(?:\s*\.\.\.\s*\s*(?:$Ident|$Constant))? |
+			=A0default)\s*:
+		=A0=A0}x;
=A0
=A0our $BasicType;
=A0our $NonptrType;
@@ -4417,7 +4422,7 @@ sub process {
=A0				$herecurr);
=A0		}
=A0# case and default should not have general statements after them
-		if ($line =3D~ /^.\s*(?:case\s*.*|default\s*):/g &&
+		if ($line =3D~ /^.\s*$case_label/g &&
=A0		=A0=A0=A0=A0$line !~ /\G(?:
=A0			(?:\s*$;*)(?:\s*{)?(?:\s*$;*)(?:\s*\\)?\s*$|
=A0			\s*return\s+
@@ -5648,27 +5653,28 @@ sub process {
=A0		}
=A0
=A0# check for case / default statements not preceded by break/fallthrough/=
switch
-		if ($line =3D~ /^.\s*(?:case\s+(?:$Ident|$Constant)\s*|default):/) {
+		if ($line =3D~ /^.\s*$case_label/ &&
+		=A0=A0=A0=A0$prevline !~ /^.\s*$case_label/) {
=A0			my $has_break =3D 0;
=A0			my $has_statement =3D 0;
=A0			my $count =3D 0;
=A0			my $prevline =3D $linenr;
-			while ($prevline > 1 && ($file || $count < 3) && !$has_break) {
+			while ($prevline > 1 && ($file || $count < 3) && !$has_break && !$has_s=
tatement) {
=A0				$prevline--;
=A0				my $rline =3D $rawlines[$prevline - 1];
=A0				my $fline =3D $lines[$prevline - 1];
=A0				last if ($fline =3D~ /^\@\@/);
=A0				next if ($fline =3D~ /^\-/);
-				next if ($fline =3D~ /^.(?:\s*(?:case\s+(?:$Ident|$Constant)[\s$;]*|de=
fault):[\s$;]*)*$/);
+				next if ($fline =3D~ /^.(?:\s*${case_label}[\s$;]*)*$/);
=A0				$has_break =3D 1 if ($rline =3D~ /fall[\s_-]*(through|thru)/i);
=A0				next if ($fline =3D~ /^.[\s$;]*$/);
-				$has_statement =3D 1;
=A0				$count++;
=A0				$has_break =3D 1 if ($fline =3D~ /\bswitch\b|\b(?:break\s*;[\s$;]*$|=
return\b|goto\b|continue\b)/);
+				$has_statement =3D 1;
=A0			}
=A0			if (!$has_break && $has_statement) {
=A0				WARN("MISSING_BREAK",
-				=A0=A0=A0=A0=A0"Possible switch case/default not preceeded by break or=
 fallthrough comment\n" . $herecurr);
+				=A0=A0=A0=A0=A0"Possible switch case/default not preceeded by break or=
 fallthrough comment\n" . $hereprev);
=A0			}
=A0		}
=A0
