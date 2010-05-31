From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Crash 2.6.32.x, Echo 3G, Alsa, SCSI
Date: Mon, 31 May 2010 22:59:36 +0200
Message-ID: <20100531225936.4a9344df@Jay>
References: <73211.74714.qm@web180714.mail.sp1.yahoo.com>
	<4B684513.8090201@ladisch.de> <20100202230911.71e8b600@Jay>
	<4C040864.8010205@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out29.alice.it (smtp-out29.alice.it [85.33.2.29])
	by alsa0.perex.cz (Postfix) with ESMTP id DFB63245E9
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 23:00:34 +0200 (CEST)
In-Reply-To: <4C040864.8010205@ameritech.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "F. Heitkamp" <heitkamp@ameritech.net>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-audio-user@lists.linuxaudio.org, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 31 May 2010 15:05:08 -0400
"F. Heitkamp" <heitkamp@ameritech.net> wrote:

> On 02/02/10 17:09, Giuliano Pochini wrote:
> > On Tue, 02 Feb 2010 16:30:27 +0100
> > Clemens Ladisch<clemens@ladisch.de>  wrote:
> >
> >    
> >> Frederick V Heitkamp wrote:
> >>      
> >>> Repeatable Hard Crash.
> >>> What else do I need to provide?
[...]
> > Signed-off-by: Giuliano Pochini<pochini@shiny.it>
> >
> > --- alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c__orig	2010-02-02 22:37:33.000000000 +0100
> > +++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c	2010-02-02 22:44:03.000000000 +0100
> > @@ -1821,7 +1821,9 @@ static irqreturn_t snd_echo_interrupt(in
> >   	/* The hardware doesn't tell us which substream caused the irq,
> >   	thus we have to check all running substreams. */
> >   	for (ss = 0; ss<  DSP_MAXPIPES; ss++) {
> > -		if ((substream = chip->substream[ss])) {
> > +		substream = chip->substream[ss];
> > +		if (substream&&  ((struct audiopipe *)substream->runtime->
> > +				private_data)->state == PIPE_STATE_STARTED) {
> >   			period = pcm_pointer(substream) /
> >   				substream->runtime->period_size;
> >   			if (period != chip->last_period[ss]) {
> >
> >
> >    
> I've tried some newer kernels.  Still having problems with the echo 3G.  
> This is kernel version:
> 2.6.32.13.  The above patches posted to the linux kernel list seemed to 
> get rid of the crashes, but evidently did not go into the main kernel tree.

Indeed. I've just checked 2.6.33 and the patch isn't there. It's in 2.6.34.

If you need 2.6.32.13 you can apply the above patch to the kernel tree or
download ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.23.tar.bz2,
otherwise just use the latest kernel.


-- 
Giuliano.
