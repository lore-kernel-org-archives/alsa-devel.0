From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: midi on ESS Solo with 2.6.0-test2
Date: Wed, 30 Jul 2003 15:26:52 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307301526200.9821-100000@pnote.perex-int.cz>
References: <200307301503.07706.jos@vandenoever.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307301503.07706.jos@vandenoever.info>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jos van den Oever <jos@vandenoever.info>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Jul 2003, Jos van den Oever wrote:

> Hello,
> 
> With 2.6.0-test1 I got linux to play midi files (without software sythesiser) 
> for the first time on my laptop with ESS Technology ES1969 Solo-1 Audiodrive. 
> However, it only works when I use playmidi and the OSS interface is enabled. 
> The program 'pmidi -l' lists two midi devices:
>  Port     Client name                       Port name
>  64:0     Rawmidi 0 - MPU-401 (UART) 0-0    MPU-401 (UART) 0-0
>  65:0     OPL3 FM synth                     OPL3 FM Port
> I can use both of them for midi output without error message: the program 
> seems to be playing something, but no sound is heard. I've checked the midi 
> volume which should be correct, since I can hear midi with 'playmidi'.
> 
> Is there some setting I've forgotten or is there a problem with the sequencing 
> support? I'd like to use rosegarden and this program insists on using the 
> mute ALSA devices.

Use sbiload from the alsa-tools package to load FM instruments to 
the driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
