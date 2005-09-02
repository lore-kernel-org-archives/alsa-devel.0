From: Mark Knecht <markknecht@gmail.com>
Subject: hdspmixer segfaults on AMD64
Date: Fri, 2 Sep 2005 15:33:24 -0700
Message-ID: <5bdc1c8b050902153359513ac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   I think this may possibly be fixed already but I couldn't find an
associated bug in Mantis. When I run hdspmixer on my AMD64 system
using 2.6.13-gentoo or 2.6.12-gentoo-r9 it segfaults. I'm running
Alsa-1.0.9 mostly:

lightning hdspmixer # emerge -pv alsa-tools alsa-utils alsa-headers
alsa-lib alsa-oss alsa-jack

These are the packages that I would merge, in order:

Calculating dependencies ...done!
[ebuild   R   ] media-sound/alsa-tools-1.0.9  +X 0 kB
[ebuild   R   ] media-sound/alsa-utils-1.0.9a-r1  +nls 0 kB
[ebuild   R   ] media-sound/alsa-headers-1.0.9b  0 kB
[ebuild   R   ] media-libs/alsa-lib-1.0.9  -doc +jack 0 kB
[ebuild   R   ] media-libs/alsa-oss-1.0.8-r1  0 kB
[ebuild   R   ] media-plugins/alsa-jack-1.0.9  0 kB

Total size of downloads: 0 kB
lightning hdspmixer #

   Has this been addressed already? If so where in the system is the
fix? I'm sort of at a stand still without hdspmixer. I'm hoping there
is a code drop somewhere that I could build and install by hand if
it's just the hdspmixer app.

Thanks,
Mark


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
