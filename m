From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: emu10k1 capture period sizes?
Date: Fri, 26 Mar 2004 15:58:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403261556030.10157@pnote.perex-int.cz>
References: <406440F5.2030101@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <406440F5.2030101@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Mar 2004, James Courtier-Dutton wrote:

> Extract from ./sound/pci/emu10k1/emupcm.c
> 
> static unsigned int capture_period_sizes[31] = {
>          384,    448,    512,    640,
>          384*2,  448*2,  512*2,  640*2,
>          384*4,  448*4,  512*4,  640*4,
>          384*8,  448*8,  512*8,  640*8,
>          384*16, 448*16, 512*16, 640*16,
>          384*32, 448*32, 512*32, 640*32,
>          384*64, 448*64, 512*64, 640*64,
>          384*128,448*128,512*128
> };
> 
> This makes the minimum period size that I can record from the MIC to be 
> 384 frames.
> 
> I would like period sized to be 20ms (Used by the GSM codec) in length 
> for a VoIP application I am working on. VoIP generally works with 8000Hz 
> sample rate to match that on Telco ISDN/Digital trunk lines.
> 
> If the sample rate is 8000Hz, a period size of 384 frames makes for a 
> 48ms which would add too much latency to the conversation.
> 
> Ideally I would like to set the minimum period size to be 160 frames 
> which is 20ms.
> 
> Is there any technical reason why I cannot just add 160 to the table above?

Yes, hardware cannot handle this size. I suggest to use another master
timer (for example set the playback period to required frequency).
The capture pointer resolution should be good.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
