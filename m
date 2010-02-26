From: Daniel Mack <daniel@caiaq.de>
Subject: [RFC] Cleanup/refactor the usbaudio driver
Date: Fri, 26 Feb 2010 15:34:40 +0100
Message-ID: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 625C4103A2D
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:35:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 00434840019
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:35:23 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop.caiaq.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UL3T5w3L-DYs for <alsa-devel@alsa-project.org>;
	Fri, 26 Feb 2010 15:35:02 +0100 (CET)
Received: from localhost.localdomain (pd95699b2.dip0.t-ipconnect.de
	[217.86.153.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by buzzloop.caiaq.de (Postfix) with ESMTPSA id CCFCA84000B
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:35:01 +0100 (CET)
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

I've spent some time cleaning up the usbaudio driver. I felt that the
existing implementation was quite difficult to follow because it
contained code for all sorts of things mixed up in one big file.

So I split the driver into pieces and tried to be as less intrusive as
I can, meaning that I didn't touch much real code but rather copied
the functions as they were and factored them out. Of course, non-static
functions were properly prefixed to avoid name space pollution.

I also moved almost all quirks to a seperate file and introduced two
more generic hooks to handle them, so the excecption add less to the
actual code of the driver.

Unfortunately it wasn't easily possible to put that big change into
smaller pieces, and so 3/3 became a huge chunk.

After all, I feel that it is easier to read now, but I don't know
whether you agree. So take this as RFC for now :)

Daniel
