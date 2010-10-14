From: Daniel Mack <zonque@gmail.com>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 18:11:23 +0200
Message-ID: <20101014161123.GA28512@wok>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141710.02194.julian@jusst.de> <20101014153912.GA28334@wok>
	<201010141754.35809.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id BA201243D8
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 18:11:26 +0200 (CEST)
Received: by fxm14 with SMTP id 14so2282921fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 09:11:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010141754.35809.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, lee188@singnet.com.sg, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 14, 2010 at 05:54:35PM +0200, Julian Scheel wrote:
> Am Donnerstag, 14. Oktober 2010, 17:39:13 schrieb Daniel Mack:
> > What about the voltage levels? Are they within the specs? I had a quick
> > look and it seems that Vdd on the codec has to be within 3.0 .. 3.6V,
> > while the signals you provide rather seem to be in the range of 5V? The
> > absolute maximum ratings say that Vdd must not be greater than 4.0V.
> 
> This might indeed be an issue. The clock signals have about 5V level... The 
> data coming from the uC still has 4.2V
> This might be too much... Stays the question how to lower the voltage properly 
> there... Any suggestions?

This get more and more off-topic for the ALSA community, but ...

For the signals, use a voltage shifter, something like the 74LVC2T45.
For Vdd, if you have to provide that to the board, use a proper
switching power regulator with low ripple, or an LDO, and care well for
blocking.

Also check whether the voltages you applied all the time could have
damaged the chip permanently.

Daniel
