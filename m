From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: aoss failures under Alsa-1.0.0rc1
Date: Thu, 4 Dec 2003 06:39:45 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAECLECAB.mknecht@controlnet.com>
References: <s5hn0a8af88.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0a8af88.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > (At this point the xmms gui opens. I then press play)
> >
> > xmms: alsa-oss.c:222: oss_dsp_hw_params: Assertion `err >= 0' failed.
> > /usr/bin/aoss: line 9:  2841 Aborted
> > LD_PRELOAD=${exec_prefix}/lib/libaoss.so $*
> > bash-2.05b$
>
> fixed recently - at least it won't abort but returns an error.
> but i'm not sure whether the OSS emulation with dmix now works in your
> case...
>

Takashi,
   Thanks for the response. Does it make sense to change dshare to dmix? The
goal was to get OSS emulation to only use 2 channels of my HDSP 9652. Or are
you saying I need rc2?

   Also, why does aoss change the sample rate from 44.1K to 48K?

Thanks,
Mark




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
