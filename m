From: "David Hartveld" <dhartveld@hotmail.com>
Subject: [snd-via82xx] AC'97 codec invalid on VIA VT8233/A/8235
Date: Mon, 19 Jan 2004 20:53:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-F110rbmLUKhvK30002cd94@hotmail.com>
Reply-To: david@hartveld.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi all,

some time ago I replaced my old, broken motherboard with an ASUS A7V8X-X 
(via 8235 chipset) one (because both motherboards seemed to have similar 
sound chipsets, and on the old (via82c686 chipset) motherboard I had no 
problems with my sound).  Now I'm trying to load the snd-via82xx module 
under linux-2.6.1, but I'm getting the following message when running

	# modprobe snd-via82xx

	...
	ALSA sound/pci/via82xx.c:512: codec_valid: codec 0 is not valid [0x87e530]
	...

The message is printed out at least 10 times, and sound is not working.  I'm 
using standard stereo speakers with this motherboard (it also supports 
surround sound).  I've searched this mailing list's archive, but I couldn't 
find any similar problems.  I was wondering if this problem is already 
known, and if there are any workarounds/patches available.

Some other information:

	# lspci
	...
	00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 
AC97 Audio Controller (rev 50)
	...

I'm running Debian sarge, with a customized kernel (v2.6.1) directly from 
kernel.org.


Thanks in advance,

David Hartveld
<david@hartveld.net> or <dhartveld@hotmail.com>

_________________________________________________________________
Play online games with your friends with MSN Messenger 
http://messenger.msn.nl/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
