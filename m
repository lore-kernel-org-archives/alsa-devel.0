From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: aplay: pcm_write:1025: write error &	SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: Mon, 2 Jun 2003 07:20:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGMELKCFAB.mknecht@controlnet.com>
References: <s5h1xycpor7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xycpor7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi,
   Thanks for the fast response. Can you give me the exact format for adding
the module options? I'm not sure which module to add this to, nor have I
ever added module options by hand before. Please be clear as I am not a
software person. /etc/modules.conf? Which line?

Thanks,
Mark

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 02, 2003 6:56 AM
> To: Mark Knecht
> Cc: Alsa-Devel
> Subject: Re: [Alsa-devel] aplay: pcm_write:1025: write error &
> SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
>
>
> At Mon, 2 Jun 2003 06:41:12 -0700,
> Mark Knecht wrote:
> >
> > Takashi,
> >    While I find this interesting, it doesn't address the
> problem. I sent a
> > bunch of information and data in the last two emails. Have I
> sent what you
> > need? Are you able to make any assessment about why aplay will
> not work with
> > this this sound chip on my Asus motherboard?
>
> well, i'm still not sure how can it happen.
> it looks like an unusual case.
>
> anyway, in general, BIOS on some ASUS boards have a bug, and the first
> PCM device won't work on them.
>
> could you try to add the module option dxs_support=2 or 3 ?
> the option 2  will disable the DXS channel support and works as
> VIA8233A chip.  the option 3 suppresses the sample rate 48k only.
>
>
> Takashi
>
> >
> > With best regards,
> > Mark
> >
> > > -----Original Message-----
> > > From: alsa-devel-admin@lists.sourceforge.net
> > > [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of
> Takashi Iwai
> > > Sent: Monday, June 02, 2003 4:12 AM
> > > To: Mark Knecht
> > > Cc: Alsa-Devel
> > > Subject: Re: [Alsa-devel] aplay: pcm_write:1025: write error &
> > > SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
> > >
> > >
> > > At 29 May 2003 21:43:39 -0700,
> > > Mark Knecht wrote:
> > > >
> > > > Sorry this is a bit long. Mostly just data. I hope it helps
> figure this
> > > > out. Sort of strange that the chip is identified in one place as a
> > > > VIA8233 and in another place as a VIA8235....
> > >
> > > in fact, both VIA8233 and 8235 have the same PCI ID.  that's why lspci
> > > shows the same name (while 8235 has the revision 0x50).
> > >
> > >
> > > Takashi
> > >
> > >
> > > -------------------------------------------------------
> > > This SF.net email is sponsored by: eBay
> > > Get office equipment for less on eBay!
> > > http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > >
> > >
> >
> >
>
>




-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
