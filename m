From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: aplay - memory leak
Date: Fri, 4 Nov 2011 17:38:52 +0530
Message-ID: <CAODvfaHcmA2UzqG12iNwoUrxoLG1ftN_x37VTyvT6xf0133zYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C84CD247F8
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 13:08:54 +0100 (CET)
Received: by gyg4 with SMTP id 4so2573684gyg.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2011 05:08:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am working with DM368 based custom board. we have external codec
interfaced to McBSP.
when we run aplay command i am observing memory leak.

the leak is around 12k everytime i do aplay. if i get any underruns
the leak is more than 12k

the kernel version i am working is "Linux-2.6.32.17-davinci1".

The codec driver is in alsa model.
Could you please help to resolve this problem.

Thanks in advance,
Sreedhar.
