From: Anders Johansson <ajh@watri.org.au>
Subject: Re: Digigram VXpocket440 on SuSE 10.1 - a lot of
	problems - few solutions
Date: Wed, 27 Dec 2006 09:33:06 +0900
Message-ID: <20061227003306.GA31937@watri.org.au>
References: <4591569E.7080106@p54A1C1F2.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <4591569E.7080106@p54A1C1F2.dip0.t-ipconnect.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have the same card. Depending on your kernel version you probabbly
don't need vxloader any longer. The firmware is loaded by some unified
firmware loader in the kernel for newer kernels. Which kernel version
are you using and what does you syslog say when the machine hangs.

I have some problem with this card as well. For me the sound is fine
(as long as the volume level is not too high, check pcm volume
controls) but the card semes to be very good at hanging the machine
(remote login not possible), check my prevous posts. Can you playback
sound using aplay and use alsamixer at the same time without hanging
the machine?

Which chipset does your machine have (check with lspci -v -v)?

Cheers,
//Anders

> Hello!
> 
> [...]
> 
> 1. distortions on high frequencies
> When starting playback, almost every time(!), the sound is distorted, it
> is rattling. It is really ugly. If the playback is paused for a few
> seconds and started again, most times, the sound is fine afterwards.
> Going back a few seconds can help, too.
> 
> -> /etc/modprobe.conf.local
> options snd_vxpocket ibl=514
> 
> The option ibl is used for playback, too, as I could read in the source
> code.
> 
> 
> 2. muting the pcm does not work properly
> If playback is muted with alsamixer or kmix, often just one channel
> (left or right) is muted or unmuted.
> 
> no solution
> 
> 3. pcm volume control
> Adjusting the volume sometimes leads to one missing channel or the
> channels are differently loud.
> 
> no solution
> 
> 4. machine hangup
> After removing the card, the actual session is dead, which means:
> keyboard doesn't work any more, but the mouse is working. It isn't
> possible to switch to another console - even with the mouse. But it is
> possible to login remote with another KDE-session e.g.
> 
> -> use the command pccardctl eject
> When suspend to disk or ram is used, the card and the modules
> snd_vxpocket, snd_vx_lib and snd_pcm must be unloaded before suspending.
> 
> 
> 5. fimrware?
> vx-status reports, that the firmware would be loaded. I didn't start
> vxloader. If I start it, I'm getting the message:
> 
> vxloader: no VX-compatible cards found
> 
> no solution
> 
> BTW, OpenSuSE 10.2 does have the same problems.
> 
> 
> Hope it helps,
> kind regards,
> Andreas Hartmann



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
