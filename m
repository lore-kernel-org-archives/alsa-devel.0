From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs
Date: Mon, 9 Sep 2002 20:40:43 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209092039210.16669-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0209092207400.882-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209092207400.882-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > I'll try, I don't know exactly where it could be failing but I'll try to 
> > find out (I'll have to read a lot of code :-) The error is not 
> > instantaneous, it takes almost a second (maybe) to fail, there must be a 
> > timeout somewhere. 
> 
> The updated code in CVS should be more verbose. Could you try it and send 
> me related lines from /var/log/messages? Thanks.

Here's the error message from the cvs version, it appears to add a little 
bit more information to what I sent before:

Sep  9 20:25:57 pc1 kernel: PCI: Setting latency timer of device 00:1f.5 
to 64
Sep  9 20:25:58 pc1 kernel: ALSA 
../../alsa-kernel/pci/ac97/ac97_codec.c:1519: AC'97 1:0 does not respond - 
RESET [REC_GAIN = 0x0]
Sep  9 20:25:58 pc1 kernel: Intel ICH soundcard not found or device busy

-- Fernando




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
