From: Juan Pablo Bouza <jpbouza@hotmail.com>
Subject: Re: M-Audio FTU issues
Date: Thu, 21 Jul 2011 17:31:43 -0300
Message-ID: <BAY155-w44BFA897C126A8D60923D6B64F0@phx.gbl>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>,
	<4E045058.6000405@showlabor.de>,
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>,
	<4E04B42E.2080906@ladisch.de>,
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>,
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>,
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>,
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>,
	<BAY155-w40601505DEAEF2C675FB21B64F0@phx.gbl>,
	<CACTFLAPTo2jGftr2G25yyw5Dn6rBv=ayk+y1Ny6JhnYDwF9BPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s24.bay0.hotmail.com (bay0-omc3-s24.bay0.hotmail.com
	[65.54.190.162])
	by alsa0.perex.cz (Postfix) with ESMTP id E893B1037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 22:31:49 +0200 (CEST)
In-Reply-To: <CACTFLAPTo2jGftr2G25yyw5Dn6rBv=ayk+y1Ny6JhnYDwF9BPQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zonque@gmail.com
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org


Yes, I know about the duplex mode kernel crash... But anyway, playback is just broken with the patch and my compilation...

Against what version of kernel 3 is the patch supposed to work?

Is there any additional kernel configuration option I should or should not use in order to make the patch work??

> Date: Thu, 21 Jul 2011 09:55:16 +0200
> Subject: Re: [alsa-devel] M-Audio FTU issues
> From: zonque@gmail.com
> To: jpbouza@hotmail.com
> CC: gdiffey@gmail.com; tiwai@suse.de; blablack@gmail.com; alsa-devel@alsa-project.org; clemens@ladisch.de; linuxaudio@showlabor.de
> 
> On Thu, Jul 21, 2011 at 7:08 AM, Juan Pablo Bouza <jpbouza@hotmail.com> wrote:
> > Capture works perfectly fine.
> >
> > Playback does not work with alsa apps  or with jack.
> >
> >  This is my /proc/asound/cards output
> >
> >  0 [SB             ]: HDA-Intel - HDA ATI SB
> >                       HDA ATI SB at 0xf9ff4000 irq 16
> >  1 [Ultra          ]: USB-Audio - Fast Track Ultra
> >                       M-Audio Fast Track Ultra at usb-0000:00:13.5-1, high
> > speed
> >
> >
> > This is what happens when trying to playback a sound file with aplay -D
> > plughw:Ultra /media/Edipo/Triangulo/Hadas\ por\ ahora.mp3
> 
> aplay is not capable of playing mp3 files. Try a .wav.
> 
> Also, note that the patch you tried is preliminary and not intended
> for productive use. It might crash your kernel.
> 
> We need some conscenus about how to decouple the USB stream from the
> ALSA stream internally to finish it.
> 
> 
> Daniel
 		 	   		  
