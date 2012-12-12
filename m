From: "Zhang wei" <zhangwei@vimicro.com>
Subject: how to update the hw_ptr in the interrupt?
Date: Wed, 12 Dec 2012 15:29:37 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A07B604FB@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (mail.vimicro.com [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F17B26030A
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 08:29:40 +0100 (CET)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello every one.i am in a trouble and could anyone help me figure out ? 

I have spent couple days trying to understand ,but I do not know the
pricinple clearly which decides how to adjust the hw_ptr in the
interrupt routine. 

Below is the reference sourcecode in the snd_pcm_update_hw_ptr0().

When the DMA interrupt ocurrs the process will enter the
snd_pcm_update_hw_ptr0() with the in_interrupt=1.

==========================================================     

if (in_interrupt) {

                   /* we know that one period was processed */

                   /* delta = "expected next hw_ptr" for in_interrupt !=
0 */

                   delta = runtime->hw_ptr_interrupt +
runtime->period_size;

                   if (delta > new_hw_ptr) {

                            /* check for double acknowledged interrupts
*/

                            hdelta = jiffies - runtime->hw_ptr_jiffies;

                            if (hdelta >
runtime->hw_ptr_buffer_jiffies/2) {

                                     hw_base += runtime->buffer_size;

                                     if (hw_base >= runtime->boundary)

                                               hw_base = 0;

                                     new_hw_ptr = hw_base + pos;

                                     goto __delta;

                            }

                   }

         }

==========================================================

The question is:

what can we get from the result of the compare between delta and
new_hw_ptr.? Why  we can conclue it?

The delta represent the expected location in the range of  *boundary* ,
and it producted based the hw_ptr_interrupt(*not fixed*) and
perod_size(fixed)?

The new_hw_ptr is producted by runtime->hw_ptr_base plus pos.

What Is the relationship between delta and new_hw_ptr? Why we can
compare them with each other ?

 

Any tips will be ok.

Thanks a lot.

 

Best Regards

zw
