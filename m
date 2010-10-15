From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 10:59:32 +0200
Message-ID: <201010151059.32746.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141710.02194.julian@jusst.de> <20101014153912.GA28334@wok>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D4DD103BED
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 10:59:35 +0200 (CEST)
In-Reply-To: <20101014153912.GA28334@wok>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 17:39:13 schrieb Daniel Mack:
> Well, even if it was, you should hear some sound. It might be distorted,
> but if you don't get any output, the reason is somewhere else.
> 
> Did you check the schematics of your board in comparison to the
> reference diagrams in the codec's datasheet? Are there any other things
> to be considered maybe?
> 
> What about the voltage levels? Are they within the specs? I had a quick
> look and it seems that Vdd on the codec has to be within 3.0 .. 3.6V,
> while the signals you provide rather seem to be in the range of 5V? The
> absolute maximum ratings say that Vdd must not be greater than 4.0V.

Sorry for one more off-topic mail, but I rechecked it. Digital Input Voltage 
is -0.3V to 6.5V, so my 5V clock voltage should be fine imho. Vdd is 3.0V on 
my board...
Do you maybe have any other thoughts what might be wrong here?

-Julian
