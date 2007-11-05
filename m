From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: 1.0.15: volume levels drift on HDA with STAC92XX
	codec
Date: Mon, 5 Nov 2007 17:32:32 +0200
Message-ID: <200711051732.32880.maximlevitsky@gmail.com>
References: <472A113B.7030406@redhat.com>
	<200711051653.23338.maximlevitsky@gmail.com>
	<s5h640gnbb9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by alsa0.perex.cz (Postfix) with ESMTP id A7535246C6
	for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2007 16:40:31 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2257664wag
	for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2007 07:40:29 -0800 (PST)
In-Reply-To: <s5h640gnbb9.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, libbe@stefansen.net, Chuck Ebbert <cebbert@redhat.com>, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

On Monday 05 November 2007 14:09:30 Takashi Iwai wrote:
> At Mon, 5 Nov 2007 16:53:23 +0200,
> Maxim Levitsky wrote:
> > 
> > On Monday 05 November 2007 13:40:48 Takashi Iwai wrote:
> > > At Thu, 1 Nov 2007 20:17:30 +0200,
> > > Maxim Levitsky wrote:
> > > > 
> > > > On Thursday 01 November 2007 19:47:39 Chuck Ebbert wrote:
> > > > > We have two reports now of unstable volume levels:
> > > > > 
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=361051
> > > > > https://bugzilla.redhat.com/show_bug.cgi?id=354981
> > > > > 
> > > > > This is with kernel 2.6.23 plus the two ALSA merge patches from
> > > > > 2.6.23-rc1.
> > > > > _______________________________________________
> > > > > Alsa-devel mailing list
> > > > > Alsa-devel@alsa-project.org
> > > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > > > 
> > > > Probably this isn't a software bug.
> > > > Probably this chip country to datasheet doesn't have usable "Master
> > >  > Volume" (volume knob) control.
> > > > 
> > > > 
> > > > The master volume control wasn't present before, I added support for
> > >  > it, using data-sheets. 
> > > > I need to know what exactly sigmatel codec was used in both cases.
> > > 
> > > Yes, the latter case seems with STAC9205 but the former one (361051)
> > > isn't clear.  Please check /proc/asound/card0/codec#* entries.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > 
> > The former is also STAC9205/04/ since it is the only one with analog loopback and two ADCs
> > 
> > I have question, I talked with the reporter of 354981, and I don't know why but his amixer
> > gives very strange results:
> > 
> > [root@itse68482 ~]# cat amixer-contents-kernel-2.6.23.2-36
> > numid=0,iface=MIXER,name='Master Playback Switch'
> >   ; type=BOOLEAN,access=rw------,values=1
> >   : values=on
> > numid=0,iface=MIXER,name='Master Playback Volume'
> >   ; type=INTEGER,access=rw------,values=2,min=0,max=65536,step=1
> >   : values=65536,65536
> > numid=0,iface=MIXER,name='Capture Switch'
> >   ; type=BOOLEAN,access=rw------,values=1
> >   : values=on
> > numid=0,iface=MIXER,name='Capture Volume'
> >   ; type=INTEGER,access=rw------,values=2,min=0,max=65536,step=1
> >   : values=34953,34953
> > 
> > How can that be?
> 
> Is the codec accessed properly?  This looks like the error at reading
> amp capability of these NIDS and returned -1.  The volume attributes
> are extracted from the amp caps.  But if so, usually relevant kernel
> messages appear...
> 
> 
> Takashi
> 

Probably,

only this one:
hda_intel: azx_get_response timeout, switching to polling mode: last cmd=0x00bf1c00

But he told me that he has both 'Master' and 'Front' in gnome-volume-control
but there are no signs of 'Front' in amixer.

Espen Stefansen, can you send the dmesg after you run the amixer.
Do you have by chance a second sound card plugged when you have the amixer run?
Can you run alsamixer, and tell me what controls you see there on both 'Playback' and 'Capture' tabs:
(Press 'Tab' to switch between 'Playback' and 'Capture' controls.

Best regards,
	Maxim Levitsky
