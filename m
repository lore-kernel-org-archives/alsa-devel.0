From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Staying synced after underrun
Date: Tue, 15 May 2012 00:45:54 -0700
Message-ID: <D567972935594567ADE30994399E117C@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-masked.atl.sa.earthlink.net
	(elasmtp-masked.atl.sa.earthlink.net [209.86.89.68])
	by alsa0.perex.cz (Postfix) with ESMTP id CB91F24C61
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 09:46:15 +0200 (CEST)
Received: from [76.89.179.141] (helo=PAULD)
	by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <pderocco@ix.netcom.com>) id 1SUCSU-0003hj-54
	for alsa-devel@alsa-project.org; Tue, 15 May 2012 03:46:14 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm writing 48KHz stereo to Intel HD audio on my mobo, and I'd like to send
it in parallel to both the analog and S/PDIF outputs, which share a clock
source. If I open both devices, configure them with the same buffer space,
and write the same data with snd_pcm_writei, how should I handle an
underrun? Call snd_pcm_prepare on both device handles? If so, and the first
device underruns, should I bother writing the buffer to the second device?

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
