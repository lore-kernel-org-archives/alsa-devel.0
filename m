From: Carlo Caione <carlo@caione.org>
Subject: DMA buffer alignment
Date: Thu, 4 Dec 2014 16:54:01 +0100
Message-ID: <CAOQ7t2b5Rr6OjpQQ8uvwQ+7O2RL=tTKyjWG1HSJuOc3X4-NDag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 90E7C26262D
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 16:54:02 +0100 (CET)
Received: by mail-vc0-f176.google.com with SMTP id hq12so7849258vcb.7
 for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2014 07:54:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I'm working with a SoC sound hw that requires that all the data
written into the DMA memory is aligned a 64 byte boundary. Actually
the alignment is required since the format of the data into the DMA
memory is (for a 2 channel 16bit audio): 16 samples for the left
channel followed by 16 samples for the right channel. If I try to
write anything that is not aligned to the 64 bytes I got audio
corruption (high pitched noise).
Several user-space programs (like aplay) work well with my hw, since
the buffer sent from the user-space is always (padded) of period-size
bytes, that is aligned to my 64 bytes boundary. Others (like
speaker-test) are not working because sometimes they snd_pcm_writei()
a buffer that is not multiple of 64 bytes. In general every time I
write into the DMA area a buffer that is not aligned, my hw pointer is
not aligned anymore with the 64 bytes and the noise starts.

IIUC it is not possible to force the user-space programs to send
buffers with a fixed size so the problem should be solved in
kernel-space (am I wrong on this point?).
Any suggestion on how to tackle this problem?

Thanks,

-- 
Carlo Caione
