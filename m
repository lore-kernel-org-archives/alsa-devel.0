From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-user] Re: audio format TYPE II and TYPE III
 descriptor support
Date: Fri, 9 May 2003 11:11:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305091111080.1237-100000@pnote.perex-int.cz>
References: <s5hhe84bklp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe84bklp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 May 2003, Takashi Iwai wrote:

> At 09 May 2003 09:22:28 +0200,
> christopher cuse wrote:
> > 
> > Good Day,
> > 
> > the following is a snip from 
> > 
> > /alsa-driver-0.9.3a/alsa-kernel/usb/usbaudio.c
> > 
> >        /* FIXME: needed support for TYPE II and III */
> >         if (format_type != USB_FORMAT_TYPE_I) {
> >                 snd_printd(KERN_INFO "%d:%u:%d : format type %d is not
> > supported yet\n",
> >                            dev->devnum, iface_no, altno, format_type);
> >                 return -1;
> >         }
> > 
> > 
> > If a usb card has TYPE II or TYPE III, is there a work around?
> 
> my current version already supports these formats but still under
> debugging.  (also, for using TYPE II, we need a special tool.  the
> current audio  apps support only linear/float formats.)

Type II contains MPEG formats?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
