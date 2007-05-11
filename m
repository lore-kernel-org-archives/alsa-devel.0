From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Mackie XD-2 Spike USB Drivers for Linux
Date: Fri, 11 May 2007 18:45:08 +0200
Message-ID: <1178901908.26158.1189349485@webmail.messagingengine.com>
References: <200705101549.02071.tictactatic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 166392434E
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 18:45:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705101549.02071.tictactatic@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sava Tatic <tictactatic@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sava Tatic wrote:
> I have been trying to get the Mackie XD-2 Spike 
> (http://www.mackie.com/products/spike/) to work on my Kubuntu Feisty machine, 
> and so far I have only gotten it to play out (I had to use plughw instead of 
> hw).

If playing works, then the driver has already found and recognized your
device.

> I am having trouble recording anything on the card.

What exactly is the trouble?

> Alsamixer (or Kmix) do not see the card. When I do alsamixer -c 1 (0 is
> my onboard card), it returns "no mixer elems found". 

Many USB devices do not have any software-accessible mixer controls.


Regards,
Clemens
