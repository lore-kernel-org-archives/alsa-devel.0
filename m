From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsploader 1.1
Date: Fri, 11 Jul 2003 12:01:06 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34483.80.11.199.28.1057917666.squirrel@www.undata.org>
References: <45125.81.51.162.201.1057777378.squirrel@www.undata.org>
        <32898.24.225.156.130.1057884141.squirrel@webmail.ouroboros-complex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32898.24.225.156.130.1057884141.squirrel@webmail.ouroboros-complex.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jfm3@ouroboros-complex.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I start the system. The red light on the Multiface is on. No sound
> drivers are loaded yet. My modules.conf is as you see it.
>
> [jfm3@localhost jfm3]$ sudo hdsploader
> hdsploader - firmware loader for RME Hammerfall DSP cards
> Looking for HDSP + Multiface or Digiface cards :
> Card 0 : RME Hammerfall DSP at 0xe9020000, irq 12
> Upload firmware for card hw:0
> Firmware uploaded for card hw:0
> Card 1 :
>

Note thant you don't need to run hdsploader as root.
If the hdsp appears as card 0, I suspect the modules get loaded at some
point by some other mechanism. Did you tweak your init scripts ?

> The red light goes out. I can get sound if I mess around with gamix and
> amixer enough, although I still haven't figured out what all the numbers
> mean.
>
> Shouldn't that be card 3 as the hdsp? In modules.conf I have the hdsp at
> index 3. I don't understand exactly what the card "index" means.
>
> If I have snd-virmidi not commented out and follow the above procedure,
> I get a kernel oops when I run hdsploader but otherwise the same
> results.
>

I thought the maximum alsa snd_card_limit was 8, maybe I'm wrong ? That
could explain the oops...

Why do you use the -k flag with options ?

Thomas





-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
