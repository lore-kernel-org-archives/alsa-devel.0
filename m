From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Sat, 19 Apr 2008 02:41:03 +0200
Message-ID: <20080419004103.GA29770@buzzloop.caiaq.de>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C5582415D
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Apr 2008 02:41:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 11:26:28PM +0300, Jarkko Nikula wrote:
> No any show stopper either but I just started to think about gpiolib if
> AIC3x GPIOs are used as a GPIO.

I agree in general and thought about alternatives as well, but in this
case, it turns out to be a thing the aic3x driver is responsible to as
the registers in questions are purely in its scope. So the idea is to
set up the GPIO's functions via alsa controls and handle its events in
some board-related code as this is really not abstractable. One could,
however, do this setup in machine-related code within the asoc
environment.

My changes don't cast any problems on the existing implementation
either, so I would suggest to just take this patch until someone comes
up with a more suitable solution :)

Best regards,
Daniel
