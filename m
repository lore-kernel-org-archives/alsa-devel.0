From: alsa@0x00.my-ho.st
Subject: Re: Maestro 2E (rev 10) not found or device busy w/
 0.9.2
Date: Sun, 6 Apr 2003 12:55:56 -0600 (MDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0304061234440.0@0x00.my-ho.st>
References: <Pine.LNX.4.50.0303261659330.8112-100000@0x00.my-ho.st>
 <s5hof3xnp8c.wl@alsa2.suse.de> <Pine.LNX.4.50.0303271039120.8112-100000@0x00.my-ho.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.50.0303271039120.8112-100000@0x00.my-ho.st>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Mar 2003 alsa@0x00.my-ho.st wrote:

> On Thu, 27 Mar 2003, Takashi Iwai wrote:
>
> > At Wed, 26 Mar 2003 17:12:55 -0700 (MST),
> > alsa@0x00.my-ho.st wrote:
> > >
> > > The 'maestro' driver included with Linux 2.4.x loads, and for the most
> > > part works okay.  However trying to use the latest ALSA results in:
> > >
> > > kernel: es1968: not attempting power management.
> > > kernel: ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1960: AC'97 0:0 does not respond - RESET
> > > kernel: ESS Maestro soundcard not found or device busy
> > >
> > > Anyone have any suggestions on how to fix this?
> >
> > which version of alsa did you test exactly?
> > i thought this was fixed in the recent version.  please try the cvs
> > version if not tried yet.
>
> Thanks for the quick response.  I have tried 0.9.2 and the latest cvs;
> both give the same errors.  :(
>
> Any suggestions?

Since I didn't get any response yet I decided to look into this more
closely myself.

The problem appears to be that although 0x8a05 is written to the
AC97_REC_GAIN register, a subsequent read returns 0xa05.  Anyone know why
this might occur?  Could someone more familiar with the ALSA code give me
some pointers on where to go from here?

Thanks.

 - Ted


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
