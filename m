From: Justin Turner Arthur <justinarthur.mail@verizon.net>
Subject: Is source in CVS broken, or is it just me?
Date: Mon, 26 Jan 2004 13:43:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40155FCB.10302@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out012.verizon.net (out012pub.verizon.net [206.46.170.137])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA21707
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2004 19:40:59 +0100
Received: from verizon.net ([151.199.12.49]) by out012.verizon.net
          (InterMail vM.5.01.06.06 201-253-122-130-106-20030910) with ESMTP
          id <20040126184055.ZPTW1590.out012.verizon.net@verizon.net>
          for <alsa-devel@alsa-project.org>;
          Mon, 26 Jan 2004 12:40:55 -0600
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is my first time using the CVS, so something in my protocol of 
operation may be flawed. Here is what I am doing:

1. Downloading CVS source with the following command:
|cvs -z3 -d ':pserver:anonymous@cvs.alsa-project.org:/cvsroot/alsa' co -P .

2. Copying the alsa-kernel files (minus the oss and CVS folders) to 
/usr/src/linux/sound/

3. Copying the alsa-kernel/include files (minus the CVS folder) to 
/usr/src/linux/include/sound/

4. "make gconfig" to make sure that it is properly configured, and that 
the ice1712 and Intel i8x0 drivers are enabled.

5. "make bzImage"

Upon execution of that last command I get a few warnings about implicit 
declarations regarding class_simple_device_*, then in the end I get the 
following error:

sound/built-in.o(.text+0x1b7): In function `sound_insert_unit':
: undefined reference to `class_simple_device_add'
sound/built-in.o(.text+0x272): In function `sound_remove_unit':
: undefined reference to `class_simple_device_remove'
sound/built-in.o(.text+0xfbe): In function `snd_register_device':
: undefined reference to `class_simple_device_add'
sound/built-in.o(.text+0x1097): In function `snd_unregister_device':
: undefined reference to `class_simple_device_remove'
sound/built-in.o(.exit.text+0x23): In function `cleanup_soundcore':
: undefined reference to `class_simple_destroy'
sound/built-in.o(.exit.text+0x73): In function `alsa_sound_exit':
: undefined reference to `class_simple_device_remove'
sound/built-in.o(.init.text+0x37): In function `init_soundcore':
: undefined reference to `class_simple_create'
sound/built-in.o(.init.text+0x196): In function `alsa_sound_init':
: undefined reference to `class_simple_device_add'
make: *** [.tmp_vmlinux1] Error 1

This is a bummer, because the latest stable release's ice1712 driver 
doesn't work too well with my card and kernel 2.6.x. I was told the 
latest patches will have fixed this. Any ideas why my kernel won't 
compile with the latest CVS?
|



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
