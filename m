From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: =?utf-8?q?alsa-lib=2C_dmix=2C_and_snd=5Fpcm=5Fopen?=
	=?utf-8?q?=5Fconf_function?=
Date: Mon, 1 Sep 2008 17:05:36 +0000 (UTC)
Message-ID: <loom.20080901T165414-425@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 78CE31037FD
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 19:05:52 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KaCqX-0000ZS-Ht
	for alsa-devel@alsa-project.org; Mon, 01 Sep 2008 17:05:48 +0000
Received: from 72.0.201.57 ([72.0.201.57])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2008 17:05:45 +0000
Received: from bidou by 72.0.201.57 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 01 Sep 2008 17:05:45 +0000
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

Hi, 

I have a problem using dmix on my embedded system (manual installation of
alsa-lib 1.0.15)

When I play a sound with aplay, it works well.

When I try -D dmix or -D plug:dmix parameter, it doesn't work. 

The output is: 

aplay: main:547: audio open error: Operation not permitted

I located my problem in alsa-lib, around line 2154 of alsa-lib/src/pcm/pcm.c: 

err = snd_pcm_open_conf(pcmp, name, root, pcm_conf, stream, mode); (in
snd_pcm_open_noupdate function)

err result is -1 when it's used with dmix...


I don't know how works alsa-lib. I suppose snd_pcm_open_conf has something
related with configuration files... Since I have all default configuration
files... Maybe I must tweak some to be able to use dmix...
