From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: SB Live
Date: Sun, 8 Dec 2002 19:48:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212081934400.629-100000@pnote.perex-int.cz>
References: <20021208084548Z15776-10698+1995@nic.funet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021208084548Z15776-10698+1995@nic.funet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Juhana Sadeharju <kouhia@nic.funet.fi>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 8 Dec 2002, Juhana Sadeharju wrote:

> Hello. Nobody replied to this question:
> 
> What internal sample rate the emu10k1 is using when arecord
> uses 44100 Hz sampling rate? Someone of you claimed emu10k1
> uses 48000 Hz as internal sampling rate. Then does Alsa driver
> do any sample rate conversion between 44100 Hz and 48000 Hz?  

EMU10K1 chip operates with 48kHz internally. The samples are converted to 
other frequencies later (before the DMA engine sends data over PCI to 
memory for capture, but data are ALWAYS sampled at 48kHz). For playback, 
data are up-sampled to 48kHz (note that some revisions don't support raw 
48kHz playback over synthesizer voices whose ALSA uses for PCM playback).

> The site opensource.creative.com has an emu10k1 driver.
> Has any of you tried that driver succesfully?
> Can I use that driver with Alsa? That is, does alsamixer work
> and adjust the emu10k1 driver settings?
> 
> I think RedHat has OSS drivers installed, so, if I don't have to
> compile anything, I would like to try if the mixer problem
> goes away with that other emu10k1 driver.
> 
> Well, basically Creative has sold me a hardware which does not
> work. They had no problems in taking my money, but when it
> comes to giving a minimal information for implementing a working
> Alsa driver for their card, they slam the door at us. (Like a door
> don't open for a nigger in Alabama.) They are discriminating Linux
> users.

Note that we might have still some bugs in the default DSP code which 
controls all digital signal paths. Unfortunately, I haven't access to 
LiveDrive/LiveDrive II and other cards to test all mixer functionality.
The Live cards are hightly non-PnP in focus of detection all available D/A 
and A/D converts.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
