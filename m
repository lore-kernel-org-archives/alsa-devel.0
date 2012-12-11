From: l9jj <l9jj@163.com>
Subject: how this will happen about hw_ptr_buffer_jiffies?
Date: Tue, 11 Dec 2012 19:58:46 +0800 (CST)
Message-ID: <13d41c4a.10c0b.13b89d4daac.Coremail.l9jj@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m13-84.163.com (m13-84.163.com [220.181.13.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B2FC526036E
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 12:58:49 +0100 (CET)
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

recently,i am tracing the process into the snd_pcm_update_hw_ptr0() and find the statement. i do not understand when the 

if (hdelta > runtime->hw_ptr_buffer_jiffies/2) 
(1)will happen?
(2)and the reason?
(3)the other question is if the dma interrupt will can enter the snd_pcm_update_hw_ptr0() every time when it ocurrs?


thanks for any suggestion.
Best Regards
L9jj


=====================code start==============================>
if (in_interrupt) {
                   /* we know that one period was processed */


                   /* delta = "expected next hw_ptr" for in_interrupt != 0 */


                   delta = runtime->hw_ptr_interrupt + runtime->period_size;


                   if (delta > new_hw_ptr) {


                            /* check for double acknowledged interrupts */


                            hdelta = jiffies - runtime->hw_ptr_jiffies;


                            if (hdelta > runtime->hw_ptr_buffer_jiffies/2) {


                                     hw_base += runtime->buffer_size;


                                     if (hw_base >= runtime->boundary)


                                               hw_base = 0;


                                     new_hw_ptr = hw_base + pos;


                                     goto __delta;


                            }


                   }


<=====================code end============================





--
------------------------------------
 l9jj
Regards
