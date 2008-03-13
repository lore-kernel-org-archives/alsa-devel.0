From: Mathieu Monney <zittix_all@xwaves.net>
Subject: Hardware and software period size
Date: Thu, 13 Mar 2008 14:26:14 +0100
Message-ID: <47D92B76.8080806@xwaves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pimpette.xwaves.net (pimpette.xwaves.net [193.58.255.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 741D22448F
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 14:26:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pimpette.xwaves.net (Postfix) with ESMTP id D984E7B8F8
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 14:28:37 +0100 (CET)
Received: from pimpette.xwaves.net ([127.0.0.1])
	by localhost (pimpette.xwaves.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jKHGZH+RF0U for <alsa-devel@alsa-project.org>;
	Thu, 13 Mar 2008 14:28:35 +0100 (CET)
Received: from [192.168.0.151] (84-74-74-177.dclient.hispeed.ch [84.74.74.177])
	by pimpette.xwaves.net (Postfix) with ESMTP id DE6AD7BA7C
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 14:28:34 +0100 (CET)
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

Hi all,

I'm currently developping a layer between ALSA and a VoIP library for an 
embedded device.  The device cannot have a different period size than 
1024 for playback and 8 for capture (I don't know why :-( ). So my 
problem is that the VoIP library ask me to have a period size different 
of the hardware period size. So I decided to read/write to the sound 
device using the provided software period size rather than the hardware 
period size.. Is it a good idea? It seems to work but I have some sound 
quality issues :-( !

Thank you

Mathieu
