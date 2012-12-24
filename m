From: "Zhang wei" <zhangwei@vimicro.com>
Subject: Does it will effect the precision of DMA position?
Date: Mon, 24 Dec 2012 18:29:16 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A07C5D85D@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (unknown [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id A695A261616
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 11:30:48 +0100 (CET)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello guys.

In the function snd_pcm_update_hw_ptr0():

pos -= pos % runtime->min_align;

after running it, the 'pos' maybe smaller than before.because there is
need to aligned.so that means lost or drop some Audio data for ever ,is
that true? The data playbacked is a bit of different from we send to?

 

Best Regards

zw
