From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 17:54:35 +0200
Message-ID: <201010141754.35809.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141710.02194.julian@jusst.de> <20101014153912.GA28334@wok>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AF1D24340
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 17:54:38 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: lee188@singnet.com.sg, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 17:39:13 schrieb Daniel Mack:
> On Thu, Oct 14, 2010 at 05:10:01PM +0200, Julian Scheel wrote:
> > I did a capture of the same signal, but this time not just a short snap,
> > but a whole memory dump of the oscilloscope. I did a plot with gnuplot
> > and uploaded it here:
> > http://jusst.de/files/i2s_plot.png
> > 
> > As it's 0,5MB big I didn't want to send it as attachment...
> > 
> > Would you agree that the data (this time blue channel) is delayed too
> > much? Looks like it's at least 2 cycles behind the LRCK toggle.
> > Would it be possible that this is the reason for the DAC not
> > understanding the data?
> 
> Well, even if it was, you should hear some sound. It might be distorted,
> but if you don't get any output, the reason is somewhere else.

Ok.

> Did you check the schematics of your board in comparison to the
> reference diagrams in the codec's datasheet? Are there any other things
> to be considered maybe?

Couldn't find anything...
Schematic is this: 
http://www.twistedpearaudio.com/docs/digital/cod_schematic.pdf

> What about the voltage levels? Are they within the specs? I had a quick
> look and it seems that Vdd on the codec has to be within 3.0 .. 3.6V,
> while the signals you provide rather seem to be in the range of 5V? The
> absolute maximum ratings say that Vdd must not be greater than 4.0V.

This might indeed be an issue. The clock signals have about 5V level... The 
data coming from the uC still has 4.2V
This might be too much... Stays the question how to lower the voltage properly 
there... Any suggestions?

> Also note that ~11MHz is already in high-speed in a way, so you should
> pay attention to data integrity on your bus. I mention that because the
> board you sent a link about earlier seems to have terminal blocks for
> all signals, so keep the traces short.

Yep, all wires as short as possible and each signal/clock line is drilled 
together with a GND line. The measurements I posted are on the terminal block 
of the DAC module.

> I'd suggest to double-check such electicals details first :)

Not the worst idea (c:

Regards,
Julian
