From: noreply@alsa-project.org
Subject: [ALSA - driver 0000376]: inserting maestro3 hangs system
Date: Thu, 15 Jul 2004 11:25:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <9afb2000599baff257f3f60baea2b2cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0376
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                tmarble
Assigned To:                tiwai
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     376
Category:                   PCI - maestro3
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Debian unstable
Kernel Version:             2.4.26
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             07-11-2004 18:30 CEST
Last Modified:              07-15-2004 11:25 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    inserting maestro3 hangs system
Description:=20
modprobe snd-maestro3 consistently hangs the system.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 tmarble - 07-13-2004 07:43 CEST=20
----------------------------------------------------------------------
The attached files were created as follows:

# cp /usr/src/kernel-source-2.4.26/.config =20
/data/debian/alsa/2.4.26-tm2.config.txt
# cp /boot/System.map-2.4.26-tm2
/data/debian/alsa/System.map-2.4.26-tm2.txt
# cp /etc/alsa/modutils/1.0 /data/debian/alsa/alsa-1.0.conf
# depmod -a -v -u -e -F /boot/System.map-2.4.26-tm2 >
/data/debian/alsa/depmod.txt
# modprobe -n -v snd-maestro3 safemode=3D1 > /data/debian/alsa/depends.tx=
t
# modprobe -v snd safemode=3D1
# modprobe -v snd-ac97-codec safemode=3D1
# modprobe -v snd-page-alloc safemode=3D1
# modprobe -v snd-timer safemode=3D1
# modprobe -v snd-pcm safemode=3D1
# modprobe -v snd-maestro3 safemode=3D1

PCI: Found IRQ 5 for device 02:03.0             =20
maestro3: enabled hack for 'Dell Inspiron 8100' =20

-- hangs -- no other messages on console --

-- following reboot --

# cd /var/log/ksymoops
# cp 20040712233907.ksyms /data/debian/alsa/20040712233907.ksyms.txt
# cp 20040712233907.modules /data/debian/alsa/20040712233907.modules.txt

If there is additional debugging information I can provide please
let me know.

--Tom

----------------------------------------------------------------------
 tiwai - 07-15-2004 11:25 CEST=20
----------------------------------------------------------------------
Could you check which ALSA version worked for you with the
same kernel?
I don't remember so many changes to this driver...

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
07-11-04 18:30 tmarble        New Bug                                    =
 =20
07-11-04 18:30 tmarble        Distribution              =3D> Debian unsta=
ble=20
07-11-04 18:30 tmarble        Kernel Version            =3D> 2.4.26      =
   =20
07-13-04 07:37 tmarble        File Added: 2.4.26-tm2.config.txt          =
      =20
 =20
07-13-04 07:38 tmarble        File Added: System.map-2.4.26-tm2.txt      =
      =20
     =20
07-13-04 07:38 tmarble        File Added: alsa-1.0.conf                  =
 =20
07-13-04 07:39 tmarble        File Added: depmod.txt                     =
 =20
07-13-04 07:40 tmarble        File Added: depends.txt                    =
 =20
07-13-04 07:41 tmarble        File Added: 20040712233907.modules.txt     =
      =20
      =20
07-13-04 07:41 tmarble        File Added: 20040712233907.ksyms.txt       =
      =20
    =20
07-13-04 07:43 tmarble        Bugnote Added: 0001412                     =
 =20
07-15-04 11:25 tiwai          Bugnote Added: 0001428                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
