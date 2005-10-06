From: Tom Watson <sdc695@yahoo.com>
Subject: RFC - Clean up of ALSA kernel codes
Date: Thu, 6 Oct 2005 13:51:40 -0700 (PDT)
Message-ID: <20051006205140.76619.qmail@web60813.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In your message you mentioned:
"8. Clean up proc fs handlers".

My only idea is to make the /proc stuff a little more "page friendly".  M=
any
of the register dumps are one register per line.  It is a bit easier (in =
my
opinion) to have them say 8 register values per line.  It makes the thing=
s
easier to read, and refer without scrolling back and forth.  As an exampl=
e
(not limited to JUST this sound card): /proc/asound/V8235/via82xx produce=
s
over 40 lines of register data.  It could have just as easily been format=
ted
horizontally and be at a minimum 1/4 of the number of lines.

Yes, this is a picky item, but having register data in a nice readable fo=
rmat
makes for nicer debugging.  Obviously this is not a "high priority" item,=
 as
the current setup does function.  I will leave it to others to determine =
the
priority of such a change.

I do have a driver in the planning stages, and my intent is to make the /=
proc
printouts "nicely formatted".  We shall see when I publish the driver whi=
ch
is one of those "real soon now" (in the works for 2+ years) things.

Just random thoughts.

--=20
Tom Watson
tsw@johana.com


	=09
__________________________________=20
Yahoo! Mail - PC Magazine Editors' Choice 2005=20
http://mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
