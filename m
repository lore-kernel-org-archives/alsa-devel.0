From: William Estrada <MrUmunhum@popdial.com>
Subject: Re: ALSA, select() question.
Date: Fri, 29 Aug 2008 13:16:24 -0700
Message-ID: <48B85918.4070404@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from MAIL02.inside.adbasesystems.com (mail.1dial.com [64.136.164.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 625D824371
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 22:16:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav,

  I got you Email address from
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09605.html.
<http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg09605.html>
I am trying to write a C program that simply reads from a ALSA device
and then writes back to it.
The program work with one major problem, there is a 4.1 second delay
between the read and the write.
This delay is caused by the select() not returning at the right time. In
you post you said to use:
> Yes, but you have to create revents for snd_seq_poll_descriptors_revents()
> to get the right event then. Don't use values from select() directly.
>
>                                                 Jaroslav
>   
  Do you have some sample code that I could look at so that I could fix
my problem?

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum
