From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Si3054 and Lenovo3000 n100
Date: Sun, 13 Jan 2008 16:49:45 +0200
Message-ID: <200801131649.46091.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 21DA42499E
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 15:50:04 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so1804987fgb.44
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 06:50:03 -0800 (PST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Hi, I have problems with setting up internal modem (regular si3054 sitting on 
hda bus) with subj notebook.
During boot I get following message in dmesg:

ALSA /var/tmp/portage/media-sound/alsa-driver-9999/work/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:237: 
si3054: cannot initialize. EXT MID = 0000

And then when I try to use slmodem I get following repeating messages from 
slmodemd:

<598.472031> main: alsa xrun: try to recover...
<598.475735> main: alsa xrun: recovered.
<598.475792> main: dev read = 0

I've tried to use alsa-driver-1.0.15 and latest alsa-driver from hg tree

I can provide any additional info, just ask ;)

Regards
Vasily
