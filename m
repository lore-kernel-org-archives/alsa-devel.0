From: Pete Fawcett <pete@fawcett.co.uk>
Subject: New developer question
Date: Tue, 13 Nov 2007 15:07:04 +0000
Message-ID: <4739BD98.4010105@fawcett.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fhw-relay07.plus.net (fhw-relay07.plus.net [212.159.14.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 399DA244E1
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 16:08:29 +0100 (CET)
Received: from [213.162.114.82] (helo=mail.fawcett.co.uk)
	by fhw-relay07.plus.net with esmtp (Exim) id 1IrxNL-00021w-T6
	for alsa-devel@alsa-project.org; Tue, 13 Nov 2007 15:08:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.fawcett.co.uk (Postfix) with ESMTP id 53B8658023
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 15:08:07 +0000 (GMT)
Received: from mail.fawcett.co.uk ([127.0.0.1])
	by localhost (mail.fawcett.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Py89z0lGuLqA for <alsa-devel@alsa-project.org>;
	Tue, 13 Nov 2007 15:08:01 +0000 (GMT)
Received: from [192.168.34.1] (213-162-114-81.zareno2.adsl.metronet.co.uk
	[213.162.114.81])
	by mail.fawcett.co.uk (Postfix) with ESMTP id BDEC658022
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 15:08:01 +0000 (GMT)
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

Dear Alsa Developers

I am trying to find out how to submit some fixes to ALSA drivers.  All I 
could find on the web site was to subscribe to this mailing list so I 
hope this is the correct place to raise this.

I have made some changes to the driver for AD1988 device.  This is an 
HDA device and handled by the snd_hda_intel module.  The specific 
hardware is handled by patch_analog.c

I have made some changes so that 5.1 surround sound is now output on my 
motherboard. Previously stereo sound was output to all all three pairs 
of speakers.

That's all fine for me, but in the spirit of open source I thought I 
should submit these changes for wider use.

Please advise me how I proceed from here.

Thanks

Pete
