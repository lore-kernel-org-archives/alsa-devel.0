From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Subject: Surround speaker connection on Acer 8951G
Date: Thu, 4 Apr 2019 21:24:30 +0200
Message-ID: <20190404192430.GA24729@xn--80adja5bqm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id 92C1BF8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 21:24:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am not sure if this is the right place to ask or if I should just
submit a bugreport, but you guys helped me out with a similar problem about 
10 years ago, so I'll try here first. If I'm wrong here, then I apologize,
just let me know.

I have an Acer Aspire Ethos 8951G notebook which has 6 built in speakers for
5.1 surround sound, it's a Realtek ALC669X.

The problem is that only two speakers are recognized by default.

I tried fiddling around with hdajackretast and it does make a difference, but
I somehow could not find a step-by-step approach on how to figure out what is
what and how to map everything correctly, so some guidance would be very much 
appreciated. I even ended up in situations where I got channels supporting 
only mute which would influence muting of other channels, I really got lost 
there..


Here's my alsa-info output:
http://alsa-project.org/db/?f=3adde87164f5fc349c3c78b211ee63e416ebf10b

It would be great if we could figure it out and make it work by default.

Basically that's what we did 10 years ago, back then I had an Acer Aspire 
8920G with a ALC889 which had the same problem that got fixed by you and these 
days it just works out of the box :)

Kind regards,
Jin
