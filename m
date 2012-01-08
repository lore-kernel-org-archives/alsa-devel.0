From: David Smith <david@silentgpu.co.uk>
Subject: TI Davinci expert wanted McASP/ALSA
Date: Sun, 8 Jan 2012 01:26:47 +0000
Message-ID: <E65F07D4-B8D9-416E-AB50-7FE4174847EE@silentgpu.co.uk>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vserver.onlinehome-server.info
	(s15429629.onlinehome-server.info [87.106.100.201])
	by alsa0.perex.cz (Postfix) with ESMTP id EC6442415A
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 02:27:02 +0100 (CET)
Received: from [192.168.0.7] (unknown [2.98.183.67])
	by vserver.onlinehome-server.info (Postfix) with ESMTP id AD2A0669C445
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 01:26:54 +0000 (UTC)
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

I am beginning to start on an audio project for the TI DM8148/EVM.  I intend to

1). extend the current McASP/PCM drivers to support 4 transmit serializes to support four stereo pairs of 24-bit 96kHz in DIT mode
         - output on McASP2 (for 7.1 audio digital)

2). extend the current McASP/PCM drivers to support 4 transmit serializes to support four stereo pairs of 24-bit 96kHz in i2s mode
         - output on McASP2 (for 7.1 audio digital)

3). make relevant changes to EDMA etc.
4). make sure McASP2/3 hardware registers are set up correctly
5). add relevant support to a new ALSA driver and present McASP2 and McASP3 as two separate 7.1 capable sound cards.

I am looking for some help (paid or otherwise. Anyone interested?

David.
