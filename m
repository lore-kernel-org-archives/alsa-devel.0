From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Re: Kernel OOP with alsaplayer driver
Date: Tue, 20 Aug 2002 17:02:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020820150212.GA380@orbital.xs4all.nl>
References: <20020820125953.GA920@orbital.xs4all.nl> <Pine.LNX.4.33.0208201515200.12251-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0208201515200.12251-100000@pnote.perex-int.cz>
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

On Tue, Aug 20, 2002 at 03:15:49PM +0200, Jaroslav Kysela wrote:

> > ioctl(4, 0x4143, 0x1807)                = 0
> > ioctl(4, 0x4112, 0x40031090)            = 0
> > close(4)                                = 0
> > open("/root/.alsaplayer/config", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
> > close(4)                                = 0
> 
> Where it crashes? I've fixed one problem in CVS, but it shouldn't be 
> triggered with Trident hardware.

It crashes when snd_pcm_close() is called, I can't couple the OOP
directly with a strace line. I can confirm that the code committed to
pcm_native.c does not fix the OOP problem for me.

Andy


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
