From: Lee Revell <rlrevell@joe-job.com>
Subject: AC97 related build problem with CVS
Date: Sat, 20 Nov 2004 01:45:19 -0500
Message-ID: <1100933119.6879.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This must be related to the AC97 changes committed recently.  CVS from
yesterday works, but today I get:

make[1]: Entering directory
`/home/rlrevell/kernel-source/linux-2.6.9-rc3-mm3-T3'
  Building modules, stage 2.
  MODPOST
*** Warning:
"snd_ac97_restore_iec958" [/home/rlrevell/cvs/alsa/alsa-driver/pci/ac97/snd-ac97-codec.ko] undefined!
*** Warning:
"snd_ac97_restore_status" [/home/rlrevell/cvs/alsa/alsa-driver/pci/ac97/snd-ac97-codec.ko] undefined!

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
