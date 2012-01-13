From: Elias Kokkinis <ekokkinis@upatras.gr>
Subject: Read and write different buffer sizes
Date: Fri, 13 Jan 2012 14:19:41 +0200
Message-ID: <B927995C-7CD1-46DF-9B58-A4E62574A688@upatras.gr>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nic.upatras.gr (nic.upatras.gr [150.140.129.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 429F010387D
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 13:19:39 +0100 (CET)
Received: from localhost (nic.upatras.gr [127.0.0.1])
	by nic.upatras.gr (Postfix) with ESMTP id 906E1275C66
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 14:19:38 +0200 (EET)
Received: from nic.upatras.gr ([127.0.0.1])
	by localhost (nic.upatras.gr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mCS1+uwO8jU for <alsa-devel@alsa-project.org>;
	Fri, 13 Jan 2012 14:19:38 +0200 (EET)
Received: from mail.upatras.gr (patreas.upatras.gr [150.140.129.29])
	by nic.upatras.gr (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 14:19:38 +0200 (EET)
Received: from vladimir.wcl.ee.upatras.gr (vladimir.wcl.ee.upatras.gr
	[150.140.187.243])
	by mail.upatras.gr (Postfix) with ESMTPA id 806E7593DC1
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 14:19:36 +0200 (EET)
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

Hello all,

I would like to ask if it is possible in ALSA to define different buffer sizes in the input and output streams.

I am using PCM sound and I want to read 2048 samples, do some processing involving overlap-add and then keep 1024 of them and put them to the output. And so on...

So I want to have the same sample rate and everything but different buffer sizes. Is this possible? I have tried an implementation of this, but I think the output for some reason still outputs 2048 samples and the audio is choppy, like having 1024 samples of audio and 1024 of silence.

I don't know if I am making myself clear here, maybe it's the 10 hours of work up to now, but anyway any help/comments would be greatly appreciated.

Elias Kokkinis
