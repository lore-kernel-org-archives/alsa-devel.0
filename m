From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Getting /dev/snd/* permissions correct
Date: Mon, 06 Oct 2003 18:44:42 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031006184442.8619.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I can't work out how to get the entries in /dev/snd to have the correct
permissions.

Starting with no modules.
Modprobe snd-XXXX results in the files in /dev/snd having only root rw
permissions.  They are created with the correct group "audio"

At the moment every time I reload my driver I need to "chmod g+rw /dev/snd/*"
I want them to have root and group rw permissions.

What do I need to change?

thanks

==================
modules.conf includes
options snd device_mode=0660

devfsd is running.

devfsd.conf includes
REGISTER ^snd$ PERMISSIONS root.audio 0660
REGISTER ^snd/.* PERMISSIONS root.audio 0660

cat /proc/asound/version:
Advanced Linux Sound Architecture Driver Version 0.9.7.
Compiled on Oct  1 2003 for kernel 2.4.18-6mdk with versioned symbols.


Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
