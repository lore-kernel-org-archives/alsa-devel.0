From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ALC268 - Acer Aspire 5720 - mic source switch
 disappered
Date: Tue, 29 Sep 2009 18:50:23 +0200
Message-ID: <1254243023.20723.5.camel@maxim-laptop>
References: <1254186798.16290.4.camel@maxim-laptop>
	<s5hk4zigsco.wl%tiwai@suse.de> <1254237796.20723.1.camel@maxim-laptop>
	<s5hhbul4vb9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id B47FB24407
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 18:50:36 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so1412871fga.2
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2009 09:50:35 -0700 (PDT)
In-Reply-To: <s5hhbul4vb9.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-09-29 at 17:36 +0200, Takashi Iwai wrote: 
> At Tue, 29 Sep 2009 17:23:15 +0200,
> Maxim Levitsky wrote:
> > 
> > On Tue, 2009-09-29 at 08:47 +0200, Takashi Iwai wrote: 
> > > At Tue, 29 Sep 2009 03:13:18 +0200,
> > > Maxim Levitsky wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > I have installed 2.6.32-rc1 (well -rc2...)
> > > > 
> > > > And I notice that 'Input source' is missing.
> > > 
> > > Now it's selected automatically per mic-jack plugging.
> > > 
> > > 
> > > Takashi
> > 
> > Nice, but driver doesn't record from internal mic now, despite the fact
> > that no external mic is plugged in.
> 
> That's a bug, obviously :)
> 
> Could you run alsa-info.sh (with --no-upload option) with and without
> the mic plugged, and attach the files?
> 
> 
> thanks,
> 
> Takashi

Sure, I already did, but it mostly contains the /proc/asound/Intel/...
codec#0 stuff...

Also I have another problem: My laptop has actually 3 input sources,
external&internal mic, and line in..

So, if I plug in both mic and line in, what will be chosen?

PA finally learned to use alsa mixer, so I had nice 'Input source' in
pavucontrol. I think it is better that kernel demanded one.

Besides PA can do the same job now.

Best regards,
Maxim Levitsky
