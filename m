From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: 1.0.13 and indigoio
Date: Fri, 6 Oct 2006 17:35:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0610061714430.4839@denise.shiny.it>
References: <70a871c80610050536w2968cd52n32a5960899b4e90b@mail.gmail.com>
	<s5hbqororyw.wl%tiwai@suse.de>
	<70a871c80610050549i67273c2bs4eab40731685bb47@mail.gmail.com>
	<s5hu02iu1ni.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0610061220220.4839@denise.shiny.it>
	<70a871c80610060712k2f04c1bbpa73fd1473f840871@mail.gmail.com>
	<70a871c80610060802n22a3f184g8b206b11bd0608de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80610060802n22a3f184g8b206b11bd0608de@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Fri, 6 Oct 2006, Dmitry Baikov wrote:

> linux-2.6.17-gentoo-r6, alsa-driver-1.0.11, alsa-firmware-1.0.11
>
> booted without the card.
>
> [...]
>
> cards works. Then:
>
> [4294892.898000] Echoaudio Indigo IO: probe of 0000:07:00.0 failed with error -5

I don't know what happens when the card is removed. From your log it seems 
that the pci_driver.remove() procedure is not called. Just to check it 
isn't an hardware issue: try to boot with the card in (you said it works),
modprobe -r snd-indigo
modprobe snd-indigo
(probably the cards works)

modprobe -r snd-indigo
remove the card
reinsert it
modprobe snd-indigo

Does it work now ?


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
