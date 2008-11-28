From: Jaroslav Kysela <perex@perex.cz>
Subject: HDA Analyzer
Date: Fri, 28 Nov 2008 11:29:27 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811281117480.8005@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 438DC24603
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 11:29:28 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	331CF149965
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 11:29:28 +0100 (CET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	1D65F8435D
	for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2008 11:29:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi HDA developers,

	I am trying to write a small tool for control and analyze HDA 
codecs (something like more powerful GUI brother for Takashi's hda-verb). 
For rapid development, I chose python and pygtk2 gtk bindings. At this 
time, only basic things are implemented and not all widget types are 
supported in detail, but routing and volume control is implemented. If you 
are interested to check this preview and send me ideas to make this tool 
better, the code is available at URL bellow (or in alsa.git repo - see 
www.alsa-project.org).

	http://git.alsa-project.org/?p=alsa.git;a=tree;f=hda-analyzer

Planned features:

- support all widget types in detail
- allow assign custom names to nodes for better orientation
- raw verb r/w ops
- save a text output of codec configuration for driver developers
  (maybe some diff)
- run aplay or speaker-test directly from GUI
- run arecord directly from GUI with some simple scope to analyze input
- sysfs support for actual HDA driver

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
