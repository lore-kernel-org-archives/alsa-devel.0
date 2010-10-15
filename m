From: Alex <lee188@singnet.com.sg>
Subject: =?utf-8?q?snd=5Fmixer=5Fload_error_with_composite_US?=
	=?utf-8?q?B_device?=
Date: Fri, 15 Oct 2010 09:56:13 +0000 (UTC)
Message-ID: <loom.20101015T114726-959@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 86E15103BFB
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 11:56:21 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P6h1R-0002SE-6J
	for alsa-devel@alsa-project.org; Fri, 15 Oct 2010 11:56:21 +0200
Received: from 220.255.7.211 ([220.255.7.211])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 11:56:21 +0200
Received: from lee188 by 220.255.7.211 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 11:56:21 +0200
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

Hi Daniel and Clemens,

I have been testing the sdr-widget and when alsamixer is run, there is a 
snd_mixer_load error - Invalid Argument.

The sdr-widget firmware with UAC1 descriptors works under Windows for audio 
control (muting and volume).  The UAC2 firmware works under Linux and OSX for 
audio control as well.

However, firmware with UAC1 does not work under Linux for audio control.  I 
traced the error to the fact that the sdr-widget enumerates as a composite USB 
device and the audio control interface is not interface #0.

The current Linux driver for UAC1 appears to assume that the audio control 
interface is #0.  It should not make that assumption.

Alex
