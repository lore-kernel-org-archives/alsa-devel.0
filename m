From: "M. Nentwig" <nentwig@users.sourceforge.net>
Subject: compilation problem: #include <jack/jack.h>
Date: Fri, 07 Mar 2003 18:13:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E68C523.BF6722A3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Moi,

I have encountered an odd problem; I wonder, if anybody has installed
rc8 on a 'clean' system yet:

alsa-lib-0.9.0rc8 does not compile (on a slackware installation free of
any previous audio software).
It tries to include <jack/jack.h> in src/pcm/ext/pcm_jack.c.
But jack without alsa-lib does not compile either...

-Markus

"Laugh about it shout about it
when you've got to choose
Every way you look at it you lose" :)

PS: 'hack'
-take out SUBDIRS = ext in src/pcm/Makefile
-compile alsa-lib
-compile jack
- put SUBDIRS = ext back
- compile alsa-lib




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
