From: Florian Bomers <Florian.Bomers@Sun.COM>
Subject: x86_64 builds
Date: Mon, 07 Jun 2004 14:26:19 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C4DD7B.40809@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
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

Hi,

when trying to compile ALSA drivers 1.0.5a on SLES 8.1 with 
kernel 2.4.19, the configure script always detected "k8" so 
gcc was called with "-march=athlon". This resulted in module 
binding problems, and I could not find a way to explicitly 
compile for x86_64. I hacked configure.in so the check

     #elif defined(CONFIG_X86_64)
         fprintf(file, "x86_64");

comes right at the beginning of the long list of #elif's. On 
AMD64, both CONFIG_MK8 and CONFIG_X86_64 are defined, so 
without the hack the configure script would always assume k8.

I think it makes sense to modify configure.in so that it 
compiles for 64-bit by default, or, at least, add a 
configure parameter to explicitly choose 64-bit.

Florian


-- 
Florian Bomers
----------------------------------------------
Java Sound              Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/
----------------------------------------------
Please quote this email in your reply. Thanks!



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
