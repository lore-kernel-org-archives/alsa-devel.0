From: Paul Davis <paul@linuxaudiosystems.com>
Subject: vmap/snd_compat_vmap messed up ...
Date: Thu, 8 May 2003 12:35:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305081635.h48GZG731155@linuxaudiosystems.com>
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

the #idef's for this in alsa-driver/acore/wrappers.c seem all messed
up. the #ifdef for 2.3.0 extends all the way to the bottom of the
file. sound.c exports snd_compat_vmap for kernels < 2.5.69, yet that
function includes a call to "vmap()" which is not defined anywhere in
kernel 2.4.20 ...

what it is the intent of all this?


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
