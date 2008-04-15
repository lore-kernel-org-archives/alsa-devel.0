From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] snd-usb-us122l v0.4 for US-122L
Date: Tue, 15 Apr 2008 18:40:48 +0200
Message-ID: <200804151840.48562.fzu@wemgehoertderstaat.de>
References: <200803161956.42461.fzu@wemgehoertderstaat.de>
	<200804151648.34466.fzu@wemgehoertderstaat.de>
	<s5hd4orgnls.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AF79C24537
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 18:41:01 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id l27so1989073fgb.44
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 09:40:52 -0700 (PDT)
In-Reply-To: <s5hd4orgnls.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 15. April 2008 schrieb Takashi Iwai:
> > > +#endif
> > > +
> > > +#define USB_STREAM_NURBS 4
> > > +struct usb_stream_config {
> > > +	unsigned version;
> > > +	unsigned sample_rate;
> > > +	unsigned period_frames;
> > > +	unsigned frame_size;
> > > +};
> > > 
> > > The codes below here should be hidden to user-space.
> > > If it's exported, then prepare more explicit struct.  For example,
> > > pointers may have different sizes on user-space.
> > 
> > Needed in user-space. Currently only 64Bit userspace works on 64Bit kernel.
> > Also 32bit user-space on 32bit kernel.
> > 32bit user-space on 64bit kernel returns an error to the caller, please see
> > the plugin.
> > IMO 32bit user-space working on 64bit kernel can wait for "INTERFACE_VERSION 2"
> Exporting this kind of particular internal struct to the user-space is
> very dangerous.

Everything exported by that struct can only be mmap()ed "read only".
Please explain why you think its very dangerous.

> This shouldn't be done.
> If a part of the data struct  
> is needed to be accessible via mmap etc, define explicitly the data
> struct instead.

Nearly all of the data struct is used by the user-space plugin.


thanks,
      Karsten
