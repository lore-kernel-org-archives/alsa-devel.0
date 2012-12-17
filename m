From: "Zhang wei" <zhangwei@vimicro.com>
Subject: Re: Could you help me about the ALSA?
Date: Mon, 17 Dec 2012 17:43:50 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A07BABBFC@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (mail.vimicro.com [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DB232615BD
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2012 10:45:13 +0100 (CET)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 

> Yes,when buffer_size wraped the 'pos' is smallar than last one.If we

> want to confirm the hw_base need to adjust there must be consider

> another confidition:

> 

> hdelta = jiffies - runtime->hw_ptr_jiffies;

> 

>               if (hdelta > runtime->hw_ptr_buffer_jiffies/2)

> 

> how to connect this code with checking unnormal interrupt(lost or
delayed)?

 

This condition is for the double interrupt acknowledge problems (see

comment). It makes sure, that the DMA buffer position was wrapped using

another external timing source. Indeed, it's mostly a lowlevel driver

fault to call this pointer update routine with the in_interrupt flag

when the period was not really elapsed.

 

--------------------------------------

I am sorry. I forget signed my info and this mail sent  by me.

 

Yes,I saw the comment and known the target of the pices of code and
known alsa use jiffies as another timing source to detect the wrap
situation,but I do not understand how to detect or check that case.In
other word,why does alsa use the value runtime->hw_ptr_buffer_jiffies/2
not runtime->hw_ptr_buffer_jiffies/3 or runtime->hw_ptr_buffer_jiffies/4
...?

 

Best Regards

zw
