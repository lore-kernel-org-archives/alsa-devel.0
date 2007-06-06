From: Vasilis Manwlopoulos <vmanolop@gmail.com>
Subject: Surround sound problem with CS46xx
Date: Wed, 06 Jun 2007 22:51:53 +0300
Message-ID: <46671059.7050003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 420122440D
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 21:51:59 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id o2so532413uge
	for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2007 12:51:58 -0700 (PDT)
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

Hi to everybody,


I am kind of new in linux and to alsa and I am facing a problem with the 
setup for 5.1 surround sound with my sound card Hercules Fortissimo III, 
recognized  having the chip cs46xx. I have managed to enable surround 
sound by creating a .asounrc file with the followings


pcm.!default {
  type plug
  slave.pcm "surround51"
  slave.channels 6
  route_policy duplicate
}

The problem is that I am facing weird cpu load spikes (sometimes isn't 
just spikes, but just 99% usage for a long time!) even when just playing 
a normal mp3 file at 128Kbps. This is happening when playing with 
various players (totem,rhythbox,vlc). Also the sound has cracklings or 
there is a delay between the front and the rear speakers. i have send 
this email to alsa-users too, but since there wasn't anyone to propose a 
workaround I was adviced to also send it to alsa-devel.  I am using the 
distro ubuntu 7.04 with the default alsa libraries version 1.0.13ubuntu5.

So, if anyone has any idea plz give me a hint, cause I am stuck with it 
about two weeks now, without having any clue to proceed with!!!





PS. If any other information or command output is necessary to help me, 
tell me so.
