From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: ICE1724 / Revolution 7.1 recognized but no sound
Date: Mon, 03 Nov 2008 11:19:40 +0100
Message-ID: <490ED03C.6050307@insite.cz>
References: <f3642e6b0810300718hee2c311m2e9c93021200ccc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 72C032433F
	for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2008 11:19:39 +0100 (CET)
In-Reply-To: <f3642e6b0810300718hee2c311m2e9c93021200ccc6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andreas Hartmetz <ahartmetz@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andreas Hartmetz wrote:
> Hi guys,
> 
> [this is a slightly modified resend of a message to LKML]
> I have a problem with my sound card. It is the only regular PCI device in my
> system.
> alsamixer works fine but any application trying to play sound will either
> hang when trying to play the first sample (mplayer, aplay) or report an error
> (amarok with xine backend).
> 


Hi Andreas,

please post results of "amixer contents". What is your sample rate
selector value? Perhaps the card is set to external clock signal?

Pavel.
