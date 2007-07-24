From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: basic workflow when playing some sounddata
Date: Tue, 24 Jul 2007 12:11:32 +0200
Message-ID: <1185271892.5506.1201735887@webmail.messagingengine.com>
References: <46A5B675.5050202@hrz.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 901DA244AA
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 12:11:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46A5B675.5050202@hrz.tu-chemnitz.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Markus Franke <markus.franke@s2002.tu-chemnitz.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Markus Franke wrote:
> Suppose I want to play a *.wav file from userspace with "aplay". After
> triggering all the configuration functions for PCM and the DAI at some
> point the chip_pcm_trigger() function get's called. As per "Writing Alsa
> Drivers" the TRIGGER_START command should now do something for "enabling
> the PCM engine". As per my understanding this could be for example to
> enable the interrupts of my DAI, which is (I2S over GSI) in my case.

Yes.  For most devices, this is where DMA is started.

> The interrupt handler by itself should call snd_pcm_period_elapsed()
> whenever a period of sounddata is copied to the device. Furthermore the
> so called "hw_pointer" should be updated in the interrupt handler,
> right?

Most devices (or DMA controllers) have a register that indicates the
current position in the DMA buffer.  If, however, this information is
not made available by the hardware (or if DMA is not used), the
interrupt handler has to save the current position so that the 'pointer'
callback can return it.

> To make it easy I don't want to use DMA in the beginning.

The driver API was designed so that writing drivers for the most common
sound card architecture, i.e., DMA, is made easy.

> I simply want to copy the data to the hardware buffer of my DAI (I2S via
> GSI) and from there it is copied automatically to my codec. The question
> is now, at which place in the alsa framework I have to put the copy
> process of the sounddata.

If you really don't want to use DMA, you have to implement the copy and
silence callbacks.  See the section "External Hardware Buffers" in
"Writing an ALSA Driver".

> Also I don't know the meaning of chip_pcm_pointer() callback.

It returns the current position in the DMA buffer.

> As far as I could figure out from the source, this function is called
> whenever snd_pcm_period_elapsed() is called, right?

It's also called when an application wants to know the current position.
For example, mplayer calls it quite often to be able to synchronize the
video output to the sound.


Regards,
Clemens
