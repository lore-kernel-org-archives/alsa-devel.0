From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Re: RFC: OSS driver removal, a slightly different approach
Date: Fri, 20 Jan 2006 10:53:58 +0100
Message-ID: <20060120095358.GA3683__7579.81357533044$1137750808$gmane$org@tuba>
References: <20060119174600.GT19398@stusta.de> <m3ek34vucz.fsf@defiant.localdomain> <1137745550.43d09e8ebde13@webmail.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C83CF153
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 10:52:37 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <1137745550.43d09e8ebde13@webmail.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 20, 2006 at 09:25:50AM +0100, Clemens Ladisch wrote:
> Krzysztof Halasa wrote:
> 
> > Adrian Bunk <bunk@stusta.de> writes:
> >
> > > 3. no ALSA drivers for the same hardware
> > >
> > > SOUND_ACI_MIXER
> >
> > Never heard
> 
> A chip used on miroPCM (ISA) cards.  An ALSA driver has been written for it,
> and it seems the ACI stuff is supported.  (This driver is not yet in the
> kernel tree.)
> 
> Martin, has your miro.c a complete implementation of what is in aci.c?

Not all card models are tested, yet. It could be possible that 
something is broken. There is a lack of bugreports for ISA cards...

Be aware that the driver for the radio part of the miroSOUND PCM20 
still depends on the OSS aci driver. Someone has to move those files 
drivers/media/radio/miropcm20* to ALSA. Meanwhile I got a miroSOUND 
PCM20 and so I'm still waiting that the ALSA miro driver will be moved 
into the kernel tree for doing it... 

Any plans about moving ALSA miro driver into the kernel? Or is there 
something completely wrong which has to be fixed at first?


martin




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
