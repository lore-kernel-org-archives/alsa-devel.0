From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: Re: How to enforce 32bit access?
Date: Wed, 10 Oct 2007 17:40:08 +0200
Message-ID: <1192030808.5545.23.camel@localhost>
References: <1191339247.30745.23.camel@localhost>
	<1191604193.5762.2.camel@localhost> <s5h8x6cveo5.wl%tiwai@suse.de>
	<1192022382.5545.9.camel@localhost>  <s5hr6k3qf3a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 53893103844
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Oct 2007 17:40:15 +0200 (CEST)
In-Reply-To: <s5hr6k3qf3a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-10-10 at 15:22 +0200, Takashi Iwai wrote:
> > > At Fri, 05 Oct 2007 19:09:53 +0200,
> > > Joachim Foerster wrote:
> > > > 
> > > > Hi ALSA devs,
> > > > 
> > > > meanwhile I tried to put a constraint on SNDRV_PCM_HW_PARAM_FRAME_BITS
> > > > by the use of snd_pcm_hw_constraint_minmax() function with min=32 and
> > > > max=32, but still no success - the ALSA Library still makes 16bit
> > > > accesses, when playing mono (1 channel) files.
> > > > 
> > > > Any ideas?
> > > 
> > > Could you show the chain of plugins via aplay -v ?
> > > I'm not sure which plugin requires S16.  Possibly, the rate converter.
> > 
> > bash-3.00# aplay -v -M ../Absage.wav
> > Playing WAVE '../Absage.wav' : Signed 16 bit Little Endian, Rate 16000
> > Hz, Mono
> 
> Well, the sample itself is 16bit format, and your hardware *does*
> support 16bit format.  Why to be 32bit?

Well actually, we are on a embedded system here. The bus is 32bit wide
(Xilinx ML403, PowerPC 405, OBP). So, why waste resources with two 16bit
accesses?
One sample is 16bits. But we have two channels (stereo only). Thus the
controller expects a frame with 32bit data - two samples at the same
time.

 Joachim

PS: As soon as stereo .wav-files are used, there is no problem, because
then the "conversion framework" and the Plug PCM are not used - just a
plain memcpy which results in 32bit accesses.
