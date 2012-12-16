From: l9jj@163.com
Subject: Re: Could you help me about the ALSA?
Date: Sun, 16 Dec 2012 22:13:57 +0800 (CST)
Message-ID: <33fb975a.ebba.13ba4106c5b.Coremail.l9jj@163.com>
References: <6B947C8AC4195040A8C6876A496C644A07BAB641@BJ-MAIL-04.vimicro.com>
 <50CAE504.60002@perex.cz>
 <6B947C8AC4195040A8C6876A496C644A07BAB6A9@BJ-MAIL-04.vimicro.com>
 <50CAF574.1@perex.cz>
 <6B947C8AC4195040A8C6876A496C644A07BAB7A7@BJ-MAIL-04.vimicro.com>
 <50CB0727.1030706@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m13-48.163.com (m13-48.163.com [220.181.13.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 02140260728
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2012 15:14:01 +0100 (CET)
In-Reply-To: <50CB0727.1030706@perex.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Zhang wei <zhangwei@vimicro.com>
List-Id: alsa-devel@alsa-project.org






>> 
>>  
>> 
>> Yes,when buffer_size wraped the 'pos' is smallar than last one.If we
>> want to confirm the hw_base need to adjust there must be consider
>> another confidition:
>> 
>> hdelta = jiffies - runtime->hw_ptr_jiffies;
>> 
>>               if (hdelta > runtime->hw_ptr_buffer_jiffies/2)
>> 
>> how to connect this code with checking unnormal interrupt(lost or delayed)?
>
>This condition is for the double interrupt acknowledge problems (see
>comment). It makes sure, that the DMA buffer position was wrapped using
>another external timing source. Indeed, it's mostly a lowlevel driver
>fault to call this pointer update routine with the in_interrupt flag
>when the period was not really elapsed.
>

But,why alsa use the specific  value 'runtime->hw_ptr_buffer_jiffies/2' to compare with hdelta than other?
