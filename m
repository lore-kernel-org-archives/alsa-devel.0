From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 22:14:23 +0200
Message-ID: <201010142214.24155.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141754.35809.julian@jusst.de> <20101014161123.GA28512@wok>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id DA897243E9
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 22:14:25 +0200 (CEST)
In-Reply-To: <20101014161123.GA28512@wok>
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
Cc: lee188@singnet.com.sg, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 18:11:23 schrieb Daniel Mack:
> On Thu, Oct 14, 2010 at 05:54:35PM +0200, Julian Scheel wrote:
> > Am Donnerstag, 14. Oktober 2010, 17:39:13 schrieb Daniel Mack:
> > > What about the voltage levels? Are they within the specs? I had a quick
> > > look and it seems that Vdd on the codec has to be within 3.0 .. 3.6V,
> > > while the signals you provide rather seem to be in the range of 5V? The
> > > absolute maximum ratings say that Vdd must not be greater than 4.0V.
> > 
> > This might indeed be an issue. The clock signals have about 5V level...
> > The data coming from the uC still has 4.2V
> > This might be too much... Stays the question how to lower the voltage
> > properly there... Any suggestions?
> 
> This get more and more off-topic for the ALSA community, but ...

Indeed sorry for that...
 
> For the signals, use a voltage shifter, something like the 74LVC2T45.
> For Vdd, if you have to provide that to the board, use a proper
> switching power regulator with low ripple, or an LDO, and care well for
> blocking.

Even found an easier way, at least for the clock signals. As they are 
generated from a 74HCT4060 right now they are 5V. Replacing it with a 74HC4060 
(or 4040) will allow me to reduce Vcc to 3V, so that the output will match.
Thanks anyway...
 
> Also check whether the voltages you applied all the time could have
> damaged the chip permanently.

Will check it... Have another board in backup for the worst case.

Thanks so far... (c:
Julian
