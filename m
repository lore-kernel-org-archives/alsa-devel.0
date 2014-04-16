From: jiwang <jiada_wang@mentor.com>
Subject: alsa-utils aplay/arecord can't be interrupted when
 streaming is not active
Date: Wed, 16 Apr 2014 16:54:30 +0900
Message-ID: <534E3736.6070100@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id C0F022617B8
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 09:54:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hi All

With latest 1.0.27.2 alsa-utils, I am facing problem to interrupt 
aplay/arecord
when the streaming is not active (no data can be written to or read from 
cards)
further more, if I start aplay/arecord with "-N" nonblocking option,
then aplay/arecord can never exit, unless I do a system reset


I found if I revert the following patch

/commit 1d0042d7e948815f8015c62bc53143eed3b83206//
//Author: Jaroslav Kysela <perex@perex.cz>//
//Date:   Mon Apr 8 13:30:54 2013 +0200//
//
//    aplay/arecord: change the interrupt handling using snd_pcm_abort()//
////
//    It is required (exclude the fatal SIGABRT) to call snd_pcm_close() 
and//
//    the end of work (outside of the interrupt handler). Use new 
snd_pcm_abort()//
//    function to inform alsa-lib to not ignore EINTR and move the 
in_aborting//
//    variable to the global scope to be checked in the i/o loops.//
////
//    Signed-off-by: Jaroslav Kysela <perex@perex.cz>//
/
http://git.alsa-project.org/?p=alsa-utils.git;a=commit;h=1d0042d7e948815f8015c62bc53143eed3b83206

then aplay/arecord can be interrupted correctly

Is it a defect in aplay.c or did I miss something?

Thanks,
Jiada
