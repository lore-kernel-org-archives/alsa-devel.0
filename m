From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problems Playing CDs with the SB Live.  Using "kscd"
Date: Wed, 24 Apr 2002 12:28:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0204241225110.908-100000@pnote.perex-int.cz>
References: <3CC5CA45.3090308@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3CC5CA45.3090308@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Apr 2002, James Courtier-Dutton wrote:

> Hello
> 
> I have trouble with playing CDs with the SB Live.
> The alsamixer "CD" volume control adjusts the volume and the sound comes 
> out the the headphone socket.
> 
> I want the sound to come out of the SPDIF socket.
> 
> If I play a .WAV file, the sound comes out the the SPDIF socket if I 
> toggle "IEC958 Optical Raw" so "MM" appears.
> 
> No matter what I try, CD audio only ever comes out of the headphone socket.

It's ok, CD is connected to AC97 codec which drives only analog outputs 
and contains analog mixing of inputs and outputs. Assuming you're using 
the standard analog output. SB Live cards with LiveDrive has also 
additional digital output which is driven differently.

> Another point: -
> I can be playing a DVD is AC3 passthru mode which disables all the 
> alsamixer controls, meaning that .WAV files will not play while AC3 

All? I don't believe. Only controls associated with S/PDIF should be 
locked. The analog outputs from AC97 should be working properly.

> passthru is playing.
> Even in this mode, the CD still plays via the headphone socket.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com
