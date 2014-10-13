From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Direct Stream Digital (DSD/DST,
 One Bit Audio) HDMI pass-trough
Date: Mon, 13 Oct 2014 17:56:44 -0500
Message-ID: <543C58AC.9000701@linux.intel.com>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 773EA2604DA
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 00:56:56 +0200 (CEST)
In-Reply-To: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Falout <andrej@falout.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/11/14, 1:33 AM, Andrej Falout wrote:
> Hello,
>
> I am collecting requirements for implementation a DSD HDMI pass-trough,
> according to HDMI specs version 1.2 and 1.3a
>
> I am wondering if anyone previously worked on this, or has any interest in
> this functionality.
>
> Any advice or pointers are gratefully received. Here is my list of the core
> facts so far:
>
>
>     1. hda_eld.c in current kernel git ignores raw DSD (One Bit Audio)
>     labelled AUDIO_CODING_TYPE_SACD ("SACD" because originally DSD formats
>     where only used commercially in SACDs) and compressed DSD (DST) is labelled
>     AUDIO_CODING_TYPE_DST (1)
>     2. It is my understanding that apart from "special handling" denoted in
>     "Table 47 CEA Short Audio Descriptor for Audio Format Codes 9 to 13", (eg
>     setting the format code, etc) this should be a reasonably straightforward
>     stream pass-trough (2)
>     3. Typical use scenario for DSD over HDMI: an DVD/BluRay player that
>     supports SACD (Super Audio CD) outputs a DSD stream over HDMI to a DSD
>     capable receiver. For instance, my Oppo and Sony BluRay players both do
>     that, and all my receivers (Onkyo, Pioneer, Marantz, Yamaha, NAD) have DSD
>     DACs and I can play both stereo and surround music this way, without
>     converting DSD to PCM. There is currently about 30 million DSD capable
>     receivers on the planet, conservatively speaking (Just Onkyo makes 1
>     million a year, and makes DSD capable ones since 2003)
>     4. Wanted scenario: play DSD files using DSD enabled players (Linux:
>     MPD, mplayer, VLC, Squeezeboxserver, etc / Windows: FooBar, JRiver, etc) to
>     an HDMI audio card/device on a PC motherboard or add-on video card with
>     HDMI, connected via HDMI cable to a DSD enabled receiver/DAC
>     5. Note that as far as I know, no proprietary drivers on Windows
>     (ATI/AMD, Nvidia, Intel) support this; It will be the first time a device
>     that is not a SACD player outputs DSD over HDMI, on any OS. I am assuming
>     that this has nothing to do with hardware limitations of the HDMI chips
>     used for video outputs (I could not find any reference for such assumption
>     in any HDMI chips I examined specs for). Therefore, I assume that
>     implementing this has no hardware prerequisites.

HDMI controllers typically don't support DSD in the PC space. It'd be 
easier to convert to high-res PCM (HBR).

>     6. DSD format general info:
>     http://en.wikipedia.org/wiki/Direct_Stream_Digital  http://dsd-guide.com/
>      http://dsd-guide.com/what-dsd-audio-simple-explanation
>
>
>
> Thanks,
> Andrej Falout
>
> References:
> (1)
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/pci/hda/hda_eld.c?id=refs/tags/v3.17
>    - Same source file in Alsa GIT tree:
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=blob;f=sound/pci/hda/hda_eld.c
>
> (2) CEA Standard PDF, page 66, table 47. HDMI specs version 1.3a, pages
> 72-73 for DSD(One Bit Audio) and DST audio packet header and body formats
>
>
> <%2B385%2891%291520436>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
