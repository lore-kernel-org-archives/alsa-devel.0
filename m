From: Bill McKie <mckie@sky.arc.nasa.gov>
Subject: Gateway MP-6954 laptop, FC6, no sound
Date: Mon, 30 Jul 2007 00:51:54 -0700
Message-ID: <200707300751.l6U7ps2n008306@sky.arc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sky.arc.nasa.gov (sky.arc.nasa.gov [128.102.154.165])
	by alsa0.perex.cz (Postfix) with ESMTP id 58BE21037FF
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jul 2007 09:51:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mckie@sky.arc.nasa.gov
List-Id: alsa-devel@alsa-project.org

I've been running FC6 on a Gateway MP-6954 laptop computer
since Oct-2006, and have been hoping that the regular FC6 yum
updates will eventually provide an alsa update that will support
the MP-6954's sound hardware.  So far, that hasn't happened,
and my system has never had sound capability.

Current system stuff:

uname -r
2.6.20-1.2962.fc6

rpm -q -a | grep -i alsa
alsa-lib-1.0.14-0.1.rc1.fc6
alsa-lib-devel-1.0.14-0.1.rc1.fc6
alsa-utils-1.0.14-0.2.rc1.fc6

cat /etc/modprobe.conf
alias eth0 sky2
alias scsi_hostadapter ahci
remove snd-hda-intel { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; };
    /sbin/modprobe -r --ignore-remove snd-hda-intel
options snd cards_limit=8
alias snd-card-0 snd-hda-intel
options snd-hda-intel index=0
alias snd-card-7 snd-usb-audio
options snd-usb-audio index=7

alsamixer (v1.0.14rc1) reports:
 Card: HDA Intel
 Chip: SigmaTel ID 7634

Some Internet googling showed that Tobin Davis released
a source level Sigmatel STAC9250 (7634) test patch 6
(gateway-mp6954.patch.6) that appears to address this
problem back in December 2006.

  http://www.spinics.net/lists/alsa-devel/msg05113.html

Is this gateway-mp6954.patch.6 still appropriate to be 
used on my FC6 system? (My FC6 sys has all the current
yum updates applied.)

If this patch is appropriate, should I first remove the
existing alsa rpms before installing alsa from source
with the patch.  I.e. should I remove all 3 packages:

 alsa-lib-1.0.14-0.1.rc1.fc6
 alsa-lib-devel-1.0.14-0.1.rc1.fc6
 alsa-utils-1.0.14-0.2.rc1.fc6

Will subsequent FC6 yum updates involving alsa then
disturb the patched alsa?

Thanks much,
Bill
