From: Shane Walton <dsrelist@yahoo.com>
Subject: SNDRV_PCM_IOCTL_PVERSION Error (Unknown Ioctl)
Date: Mon, 23 Sep 2002 12:45:15 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020923194515.58964.qmail@web20803.mail.yahoo.com>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

When tyring to use beta6, ..., beta9, I get an error
in the device open() call that states an unknown/bad
ioctl command.  The beta6 worked well with the 2.2.19
kernel.  I am wondering if this is a problem when used
with a 2.4.19 kernel.  Can anyone validate?  It seems
that the only way the PVERSION ioctl would be valid is
if the _plugin_ calls are resolved in the open()
function.  As far as I can debug, it seems that the
_plugin_ reference fails and the _hw_ reference is
used instead.  Can someone please point me in the
right direction?  Thanks.

=====
Shane M. Walton, Software Engineer
Digital System Resources, Inc.
dsrelist@yahoo.com : swalton@dsrnet.com
703.234.1674

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
