From: christopher cuse <ccuse@tiscali.fr>
Subject: Re: [Alsa-devel] audio format TYPE II and TYPE III descriptor
 support
Date: 09 May 2003 11:20:04 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1052472004.2080.9.camel@drs0.manchotnetworks.net>
References: <1052464949.2144.6.camel@drs0.manchotnetworks.net>
	<s5hhe84bklp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe84bklp.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: alsa-user-list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks very much for the info -- i'll try the patch when available.

Cheers

Christopher CUSE
On Fri, 2003-05-09 at 10:16, Takashi Iwai wrote:
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
> 
> anyway, the patch will be up in a couple of days.
> 
> 
> ciao,
> 
> Takashi




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
