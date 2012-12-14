From: "Zhang wei" <zhangwei@vimicro.com>
Subject: Could you help me about the ALSA?
Date: Fri, 14 Dec 2012 18:46:12 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A07BAB7A7@BJ-MAIL-04.vimicro.com>
References: <6B947C8AC4195040A8C6876A496C644A07BAB641@BJ-MAIL-04.vimicro.com>
 <50CAE504.60002@perex.cz>
 <6B947C8AC4195040A8C6876A496C644A07BAB6A9@BJ-MAIL-04.vimicro.com>
 <50CAF574.1@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (unknown [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D341265133
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 11:47:18 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <50CAF574.1@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 14.12.2012 09:55, Zhang wei wrote:

> Thank you very much.

> 

> But if the OS lost or delayed some interrupt(s) the variable

> hw_ptr_interrupt will smaller than it should be,because delayed update

> it from last time enter the interrupt.so the

> 

> delta = runtime->hw_ptr_interrupt + runtime->period_size;

> 

> should be smaller than new_hw_ptr.

 

The current 'pos' value from the driver can be smaller (buffer_size

wrap) than last one. The new_hw_ptr can be lower than delta in this
case.

 

                       Jaroslav

 

Yes,when buffer_size wraped the 'pos' is smallar than last one.If we
want to confirm the hw_base need to adjust there must be consider
another confidition:

hdelta = jiffies - runtime->hw_ptr_jiffies;

              if (hdelta > runtime->hw_ptr_buffer_jiffies/2)

how to connect this code with checking unnormal interrupt(lost or
delayed)?

Why we can prove need to adjust the 'hw_base' when 'hdelta' >
hw_ptr_buffer_jiffies/2 ? the former represent the jiffier error between
this moment and last be here(maybe called from non-interrupt elpased()).

The later means the time spend on fill the buffer.Then compare them and
we will find if 'delta' is bigger means the DMA already fininshed a
period at least without notice the OS?

The compariation confused me.I can not get the relationship from the
result and what the information or clue is ignored by me? Please give me
some tips. Thank you.
