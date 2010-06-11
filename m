From: Jakub Schmidtke <sjakub@gmail.com>
Subject: HDMI audio with NVIDIA NVS 3100M
Date: Fri, 11 Jun 2010 01:58:13 -0400
Message-ID: <201006110158.13869.sjakub@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DAD71039A6
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 07:55:33 +0200 (CEST)
Received: by iwn6 with SMTP id 6so123747iwn.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2010 22:55:32 -0700 (PDT)
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

Hi.

I am having problems getting the HDMI audio working with NVIDIA NVS 3100M card 
(this is a card in Lenovo T410 laptop).
When I'm not using any options for the snd-hda-intel module, I have 
4 controls in alsamixer: S/PDIF >S/PDIF 1 S/PDIF 2 S/PDIF 3.
Playing to any of the 4 available devices doesn't produce any sound through 
TV.

In a thread about GT2XX cards
( http://forum.xbmc.org/showthread.php?p=527386 )
there was a solution - adding "options snd-hda-intel enable_msi=0 
probe_mask=0xffff,0xfff2" to modprobe's config.
When I am using this option I have only one S/PDIF output, but I am still not 
getting any sound through TV.

I have run alsa-info.sh script and uploaded the results (this is without any 
options for the modprobe):
http://www.alsa-project.org/db/?f=7514a673a73aca75d58c3e426c59d0bf6ca3dfc8

This is info from lspci about this card:

01:00.0 VGA compatible controller: nVidia Corporation NVIDIA NVS 3100M (rev 
a2)
01:00.0 0300: 10de:0a6c (rev a2)

01:00.1 Audio device: nVidia Corporation High Definition Audio Controller (rev 
a1)
01:00.1 0403: 10de:0be3 (rev a1)

Any hints? Maybe I can debug or check something else? I am ok with modifying 
and building kernel modules, I just have no idea where to start...


Thanks!
