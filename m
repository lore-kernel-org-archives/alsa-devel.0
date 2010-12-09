From: louis@museresearch.com
Subject: Handling non-buffer-sized MMAP requests
Date: Thu, 9 Dec 2010 13:34:41 -0800
Message-ID: <6e2495d80bd7915f371b984cc4b4a503.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.museresearch.com (master.museresearch.com [69.59.28.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 0510A103CBB
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 22:34:50 +0100 (CET)
Received: from localhost ([127.0.0.1] helo=master.museresearch.com)
	by master.museresearch.com with esmtpa (Exim 4.69)
	(envelope-from <louis@museresearch.com>) id 1PQo8P-0004Dc-Bg
	for alsa-devel@alsa-project.org; Thu, 09 Dec 2010 13:34:41 -0800
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

Hi everyone, I'm having some difficulty improving a full-duplex MMAP ALSA
routine.  ALSA sometimes reports more samples available for input than my
buffer can take, or asks for more samples than I have available.  Is this
a buffer overrun/underrun?  If I restart the streams in the case that too
much input is available (on the assumption that it's an xrun) it seems to
happen at the drop of a hat and makes things worse.  If I discard the
excess input, that doesn't work well either.

What is the appropriate way to deal with this situation?  What does it
mean that ALSA is offering me more samples than I have set for the buffer
size?

Cheers,
Louis
