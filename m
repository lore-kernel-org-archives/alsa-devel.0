From: Jacek Blizinski <azidog@nyc.rr.com>
Subject: Problem compiling alsa-driver-0.9.3c
Date: Mon, 26 May 2003 18:57:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305261857.31425.azidog@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

checking for GCC version... Kernel compiler: gcc 3.2.2 (Mandrake Linux 9.1 
3.2.2-3mdk) Used compiler: gcc-3.2.2 (GCC) 3.2.2 (Mandrake Linux 9.1 
3.2.2-3mdk)
Fatal error: Compiler type does not match

However the compiler is the same. Is there any way to fix this or remove the 
check?

I use the following command successfully on previous versions of alsa 
successfully:
./configure --with-cards=intel8x0 --with-sequencer=yes --with-isapnp=no

I tried compiling the drivers with the 2.4.21-rc1 kernel and when I got the 
message, I compiled and use 2.4.21-rc3. However I still get the message. I 
havent changed any of the compiler settings. I dont understand what's wrong. 
Please help.


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
