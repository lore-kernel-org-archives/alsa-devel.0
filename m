From: "Zhang wei" <zhangwei@vimicro.com>
Subject: how to check the CODEC registers vaule
Date: Thu, 20 Dec 2012 10:31:00 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A07C0470E@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (mail.vimicro.com [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B3A3264FA2
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 03:31:45 +0100 (CET)
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

Hello everyone,I am confused again : (

I read the wm8985.pdf and found the description:

 

If the address is not recognised or the R/W bit is '1' when operating in
write only mode,the WM8985 returns to the idle conditon and waits for a
new start condition and valid address.

 

Does it mean the wm8985 registers write only, can not be read?

I found other kinds of codec datasheet same as it. Is it necessary to
read back the value from the register ?

 

Thanks a lot.

Best Regards

zw

 
