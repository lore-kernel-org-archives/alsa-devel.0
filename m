From: Shawn Smout <olorin_the_great@yahoo.com>
Subject: Alsa-driver gawk/POSIX bug (again)
Date: Sun, 16 Nov 2003 12:44:50 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031116204450.51935.qmail@web40906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

There is a bug in the alsa-driver file
"utils/convert_isapnp_ids" that causes compilation of
alsa-driver to fail if gawk runs in POSIX mode (which
is the case if the environment variable
POSIXLY_CORRECT is set).

Line 84 of convert_isapnp_ids currently says:
    if (match($0, "\{.*\}")) {

The slashes to escape the braces were intended as a
fix to this bug (which I previously posted), but it
turns out they don't work.  I believe this is because
awk evaluates the expression in the double quotes
before passing it to the match function, so the regex
matcher sees {.*}, not \{.*\}.  This can be fixed in
one of two ways:

    if (match($0, "\\{.*\\}")) {
or
    if (match($0, /\{.*\}/) {

The former escapes the slash, so the regex itself sees
the braces as escaped.  The latter merely causes gawk
not to evaluate the argument before passing it to
match.  Both have the same effect of sending the regex
\{.*\} to match.  The code then works as intended
regardless of whether POSIXLY_CORRECT is set.

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
