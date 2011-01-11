From: Wolfgang Scheicher <wolfgang.scheicher@gmail.com>
Subject: snd_hda_intel: regression from kernel 2.6.36 -> .37
	(Microphone)
Date: Tue, 11 Jan 2011 15:40:05 +0100
Message-ID: <ighq3i$9b8$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 126DD24444
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:30:11 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pch6j-0006dO-LN
	for alsa-devel@alsa-project.org; Tue, 11 Jan 2011 17:30:05 +0100
Received: from 84-119-34-232.dynamic.xdsl-line.inode.at ([84.119.34.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:30:05 +0100
Received: from wolfgang.scheicher by 84-119-34-232.dynamic.xdsl-line.inode.at
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:30:05 +0100
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


I used kernel 2.6.36 from debian experimental for quite some time now, 
without any problem:
http://www.alsa-project.org/db/?f=11290fe50066e9bcd6a244f2c83b1c66c9dd201b

Upgrading to 2.6.37 from debian experimental left me unable to use my 
microphone:
http://www.alsa-project.org/db/?f=0f29e6de98ea9fefae5c6e2adb43ff8f8eede697

I also noticed some (inconsisitent?) changes in the mixer channel names, 
like "Mic" became "Rear Mic", while "Mic Boost" remained.

Wolfgang Scheicher
