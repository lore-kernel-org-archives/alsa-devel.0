From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RE:[PATCH] emufx: reduce stack usage
Date: Tue, 1 Jul 2003 12:09:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307011207150.13946-100000@pnote.perex-int.cz>
References: <200307010954.LAA26175@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307010954.LAA26175@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "clemens@ladisch.de" <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 1 Jul 2003, p z oooo wrote:

> And ones more:
> 
> IOCTL SNDRV_EMU10K1_IOCTL_PCM_PEEK in snd_emu10k1_fx8010_ioctl 
> allocate structure to ipcm which is then passed to 
> snd_emu10k1_ipcm_peek which then uses one of member (ipcm->substream) 
> which is not initialized (may come from user space ???).

It should be fixed now. Do you need to implement the TRAM_POKE and 
TRAM_PEEK ioctls, too?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
