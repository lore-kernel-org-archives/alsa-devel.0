From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa formats explained?
Date: Thu, 1 Jul 2004 14:49:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0407011448540.1553@pnote.perex-int.cz>
References: <40E408DA.1090403@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40E408DA.1090403@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 1 Jul 2004, James Courtier-Dutton wrote:

> I need to send 32bits for each sample to a sound card.
> The contents of the value is LE.
> The card only takes notice of the high 24bits. 0xffffff00
> 
> Which alsa format string should I use in the alsa driver to tell 
> alsa-lib to send samples in this format.
> 
> I want alsa-lib to be able to do the correct conversions:
> E.g. 8bit samples -> 0xff000000
>      16bit samples -> 0xffff0000
>      24bit samples -> 0xffffff00
>      32bit samples -> 0xffffffff  (but the lower 8 bits 0x000000ff will 
> be dropped by the hardware.)
> 
> I think I should use S32_LE, but I wanted to verify that here first.

Correct.

> I can find a bit of the alsa docs explaining this, but it seems a bit 
> unclear to me. Maybe a diagram should be added or something like this:
> S32_LE,  alsa-lib sends to the hardware 24bit samples -> 0xffffff00
> S24_LE,  alsa-lib sends to the hardware 24bit samples -> 0x00ffffff
> (^ I think it works like that ^)

Correct.

> Here is what I found:
> "24-bit linear samples are using three low bytes from the 32-bit word. 
> When hardware uses 24-bit format in 32-bit linear samples (the low byte 
> is ignored), then the sample format is 32-bit, and the msbits_per_sample 
> member from the snd_pcm_channel_setup_t structure shows count of most 
> significant bits being used (24 in this case). The other formats (for 
> example 20-bit linear sample stored in the 32-bit linear sample) may 
> follow this example as well."

What's unclear?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
