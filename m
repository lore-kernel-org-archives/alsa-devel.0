From: alfp <alfp@adsmr.co.za>
Subject: RPM Build problem
Date: 30 Sep 2003 08:30:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1064903425.9677.9.camel@didjeridu>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi
I'm trying to build RPMs from alsa-driver-0.9.7 (on Mandrake 9), and at
the end of the process, rpm reports 'installed but unpackaged' files:
Checking for unpackaged file(s): /usr/lib/rpm/check-files
/var/tmp/alsa-driver-0.9.7-root
error: Installed (but unpackaged) file(s) found:
   /lib/modules/2.4.21-0.13mdkenterprise/modules.dep
   /lib/modules/2.4.21-0.13mdkenterprise/modules.generic_string
   /lib/modules/2.4.21-0.13mdkenterprise/modules.ieee1394map
   /lib/modules/2.4.21-0.13mdkenterprise/modules.isapnpmap
   /lib/modules/2.4.21-0.13mdkenterprise/modules.parportmap
   /lib/modules/2.4.21-0.13mdkenterprise/modules.pcimap
   /lib/modules/2.4.21-0.13mdkenterprise/modules.pnpbiosmap
   /lib/modules/2.4.21-0.13mdkenterprise/modules.usbmap

I see that the Makefile runs depmod -a, which creates these files, and
the alsa-driver.spec lists
/lib/modules/*/kernel/*
which does not include these files.

The question is, should they be in the RPM or not? My gutfeel is that
they are installation-specific and should not be in the RPM. In that
case, do I modify the Makefile or somehow tell the specfile to delete
the files before packaging?

Thanks
Alf Potgieter

-- 
alfp <alfp@adsmr.co.za>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
