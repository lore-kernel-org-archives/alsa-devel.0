From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Re: Problems playing with intel8x0 [long]
Date: Tue, 29 Apr 2003 10:56:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304291056.21280.n8gray@caltech.edu>
References: <200304281542.54340.n8gray@caltech.edu> <s5hllxty7yc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllxty7yc.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 29 April 2003 02:22 am, Takashi Iwai wrote:
> At Mon, 28 Apr 2003 15:42:54 -0700,
>
> Nathaniel Gray wrote:
> > The intel8x0 driver has a bad habit of going into an infinite loop
> > and consuming 100% cpu when I try to play certain sound files.  I
> > think it has trouble with non-standard sample rates.  It will
> > handle 44100, 22050, and 11025, but KDE ships some samples with
> > weird rates like 7418, 11127 and 22254, and if I try to play these
> > with, for example, aplay, I get the loop.
>
> which version are you using?
> there WAS a bug in this regard but i believe it was fixed in the
> recent version.

Was it a driver bug or an application bug?  I found that I could play 
the samples with "play" but not with xmms or aplay.

I'm using 0.9.0rc7.  (Stock Mandrake 9.1)

Cheers,
-n8
-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
