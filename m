From: Troy Benjegerdes <hozer@hozed.org>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Tue, 7 Jan 2003 23:37:21 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030108053721.GC10119@kalmia.hozed.org>
References: <20030103042233.GK28177@altus.drgw.net> <s5hof6t9ccy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hof6t9ccy.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 07, 2003 at 05:02:53PM +0100, Takashi Iwai wrote:
> At Thu, 2 Jan 2003 22:22:34 -0600,
> Troy Benjegerdes wrote:
> > 
> > I have a mac G4 (running debian testing), a ymfpci card (MaxiSound
> > Fortissimo) with optical TOSlink out, and a yamaha HTR-5540 receiver with
> > digital optical TOSlink input.
> > 
> > I'm trying to get xine or some other DVD player to output AC/3 sound to 
> > the receiver for watching dvd's, and I have a couple of problems.
> > 
> > 1) xmms (and xine 2-channel sound) works with OSS emulation, but is static
> > 	with native ALSA drivers. This seems like some endian problem
> 
> then most likely it's a bug of alsa output plugin.

It seems the latest xmms source uses 'S16_NE' (which is S16_BE on
big-endian platforms) as the pcm format, which works correctly.

alsa-tools/acdec/output.c also has a problem.. it uses S16_LE on
big-endian platforms.

I am able to successfully open the SPDIF output and output *something*
with a commandline like:

ac3dec -D hw:0,0 -C THX.ac3

However, the hardware decoder (yamaha receiver) is getting garbled data
and plays what sounds like stacatto static.

ac3dec -C THX.ac3 gives the following:

Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
ALSA lib pcm_hw.c:292:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: No such device or address
PCM hw_params failed: No such device or address
Output open failed

Another interesting bit...
If I change S16_LE to S16_BE in output.c, now it works with regular 2
channel audio, but anything with the '-C' option gives:

Using PCM device 'hw:0,0'
Sample format non availableOutput open failed

Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
Sample format non availableOutput open failed


Should the alsa drive be able to byteswap SPDIF data??


-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net   

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
