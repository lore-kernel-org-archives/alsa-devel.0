From: Sava Tatic <tictactatic@gmail.com>
Subject: Mackie XD-2 Spike USB Drivers for Linux
Date: Thu, 10 May 2007 15:49:01 +0200
Message-ID: <200705101549.02071.tictactatic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.187])
	by alsa0.perex.cz (Postfix) with ESMTP id A4DD024399
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 15:49:08 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id i2so407971mue
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 06:49:07 -0700 (PDT)
Content-Disposition: inline
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

Hello,

I have been trying to get the Mackie XD-2 Spike 
(http://www.mackie.com/products/spike/) to work on my Kubuntu Feisty machine, 
and so far I have only gotten it to play out (I had to use plughw instead of 
hw). I am using the generic USB drivers that came with the distro. I am 
having trouble recording anything on the card. Alsamixer (or Kmix) do not see 
the card. When I do alsamixer -c 1 (0 is my onboard card), it returns "no 
mixer elems found". 

I am aware that this card is not in the ALSA Matrix of supported cards, but I 
am wondering what would it take for it to become supported? 

All the best,

Sava
