From: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-audio: support for Edirol
	UA-4FX device
Date: Mon, 6 Oct 2008 21:50:45 +0200
Message-ID: <200810062150.45478.pedro.lopez.cabanillas@gmail.com>
References: <12231307783118-git-send-email-pedro.lopez.cabanillas@gmail.com>
	<48E9B5D5.9080404@ladisch.de> <s5h3ajagihr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E3081037F1
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 21:51:03 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1647824nfd.32
	for <alsa-devel@alsa-project.org>; Mon, 06 Oct 2008 12:50:49 -0700 (PDT)
In-Reply-To: <s5h3ajagihr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > Pedro Lopez-Cabanillas wrote:
> > > Renamed the old quirk function for ua-700/ua-25 to become more
> > > generic, moving the MIDI interfaces to the quirk data header.
> >
> > The MIDI interfaces have to be detected dynamically because in the half-
> > duplex 96 kHz modes, they have a different interface number.
>
> OK, then the MIDI check must be again in uaxx_quirk.
> I like the style Pedro did, putting the numbers in quirk list rather
> than hard-coding in quirk routine.  But if it can't be done
> statically, it has to be reversed in the old way...

Yes, sorry. I will send in a minute a new patch for ua-4fx, using the old way 
to detect the MIDI interfaces.

Regards,
Pedro
