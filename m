From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Please add snd-ice1712 problem to "Known bugs" page
Date: Tue, 9 Sep 2003 09:44:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0309090939380.12936@pnote.perex-int.cz>
References: <1630-86930@sneakemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1630-86930@sneakemail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sam <4l8uie002@sneakemail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Sep 2003, Sam wrote:

> Hi,
>
> I purchased a Delta 44 for playback with my consumer grade Sony ES
> receiver.  Installation of ALSA went smoothly, and I can hear music
> okay, but it sometimes clips.  I believe this is because the analog
> signal level is set inappropriately and there's no way using Linux
> software for me to fix it.  Here's an excerpt from the Delta 44 manual:
>
>         The Delta 44 Digital Recording Interface's analog inputs and
>         outputs are compatible with a wide variety of audio products.
>         The Delta Control Panel software allows you to configure the
>         signal levels of each input individually, and all outputs as a
>         group.  Signal level settings of +4/Consumer/-10 are available.
>         Selecting the +4 radio button configures the channel(s) for use
>         with +4dBu signal levels, compatible with most musical
>         instruments and professional mixers.  Selecting the -10 setting
>         sets up the channel(s) for -10dBV nominal signal levels,
>         commonly used with consumer equipment such as CD, MiniDisc,
>         cassette tape and DAT players.  The Consumer setting is
>         preferred for semi-pro audio equipment and some consumer
>         equipment that is too hot for the -10 setting.  The Consumer
>         setting offers approximately 6dB more headroom than does the -10
>         setting.  Semi-pro and consumer devices signal levels vary from
>         manufacturer-to-manufacturer and even product-to-product, so a
>         little experimentation between Consumer and -10 settings may be
>         required for optimal results.
>
> The screen shot of the Windows driver shows the choices for +4dBu,
> Consumer, and -10dbV.  I was unable to find any way of setting these
> using Linux software, including envy24control, and don't see any mention
> of them in the ice1712 source code.
>
> I'm disappointed because I spent extra money on this card to get good
> quality playback for my music.  I would not have purchased it had I
> known this is a problem.  Please make it clear on the Known bugs page or
> Soundcard Matrix so no one else makes the same mistake.

I think that your problems are probably caused by underruns (system does
not deliver samples to the DMA buffer for your card in time). The analog
levels can be changed using alsamixer or envy24control (use analog
section). The driver fully supports your hardware and yes, it is difficult
to make reliable sound output for the ICE1712 chip with the standard linux
kernels. Look for lowlatency patches.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
