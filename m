From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: stateful reconnect with snd-usb-audio
Date: Wed, 14 Jun 2006 16:50:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606141645450.10637@tm8103.perex-int.cz>
References: <8d4807d50606121405n51edef2au3de163b01029aaf5@mail.gmail.com>
	<s5h1wts9eae.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141330280.10637@tm8103.perex-int.cz>
	<s5hy7w07wvx.wl%tiwai@suse.de> <s5hr71r97rz.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606141543260.10637@tm8103.perex-int.cz>
	<s5hodwv961d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodwv961d.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Sam Revitch <sam.revitch@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Jun 2006, Takashi Iwai wrote:

> > Yes, but we have a problem when an user remove an hotplug device, if 
> > apps do not check the state of file descriptor. After disconnect, 
> > read()/write() syscalls return immediately with -ENODEV and poll() with 
> > POLLERR | POLLNVAL, thus it should be possible to close the disconnected 
> > devices ASAP.
> 
> Then such a thing should be implemented in alsa-lib, not in app
> codes.

I'm not sure how alsa-lib can decide if device has been disconnected
permanently or temporary. But if you mean "closing the file descriptor
in the first time when -ENODEV occurs", it makes a lot of sense for 
alsa-lib and yes, it should be there.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
