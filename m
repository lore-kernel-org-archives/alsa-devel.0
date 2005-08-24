From: "=?GB2312?Q?=EE=A1=CE=C0=B7=E6?=" <weifengsui@163.com>
Subject: Sound Card does not be detected
Date: Wed, 24 Aug 2005 16:43:12 +0800
Message-ID: <E1E7qqq-0002II-1J@mail.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: quoted-printable
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
To: sui15274@sina.comsui15274@sina.com
Cc: alsa-devel@lists.sourceforge.netalsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

sui15274=A3=AC=C4=FA=BA=C3=A3=A1

=09I am facing a problem when program the driver of ALSA HDAudio.=
 My Redhat version is 9.01,the linux kernel version is 2.6.0 and=
 the ALSA version is 1.0.6a.The HDAudio driver can be detected by=
 the ALSA-utils aplay and the driver work OK, but it cann't be=
 detected by 'system settings/detect sound card'.
    
    the following is module configuration file /etc/modules.conf,=
 My HDAudio module name is snd-azx.

#############################
alias usb-controller ehci-hcd
alias usb-controller1 usb-uhci

# ALSA native device support
alias char-major-116 snd
options snd major-116 cards_limit=3D1
alias snd-card-0 snd-azx
options snd-azx index=3D0 id "test"

# OSS/Free setup

#alias char-major-14 soundcore
#alias sound-slot-0 snd-card-0
#alias sound-service-0-0 snd-mixer-oss
#alias sound-service-0-1 snd-seq-oss
#alias sound-service-0-3 snd-pcm-oss
#alias sound-service-0-8 snd-seq-oss
#alias sound-service-0-12 snd-pcm-oss

alias sound-slot-0 snd-azx

################

    "modprobe snd-azx", "rmmod snd-azx",and "lsmod", it seems to=
 work correctly. I dont know why.

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D6=C2
=C0=F1=A3=A1
 =09=09=09=09

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=EE=A1=CE=C0=B7=E6
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1weifengsui@163.com
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12004-11-08





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
