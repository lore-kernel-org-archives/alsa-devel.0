From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re:
	[PATCH] emu10k1: add interval timer support)
Date: Sat, 25 Sep 2004 20:55:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096160120.3697.35.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409241546570.2289@pnote.perex-int.cz>
	 <200409241453.i8OErtVR029650@localhost.localdomain>
	 <s5hk6uj3dko.wl@alsa2.suse.de> <1096059735.11589.45.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1096059735.11589.45.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-24 at 17:02, Lee Revell wrote:
> Anyway I will probably start with whatever is easier to get working. 
> This will actually not be a huge patch, and I certainly don't want to
> design a new API.  I am just running through some more complex use cases
> that I know work on Windows to verify I am on the right track.

OK, hopefully I am on the right track.

Here's a normal stereo interleaved pcm being opened.  The L and R voices
have the same start and end addresses because it's interleaved, and the
extra voice is silent, it loops generating the period interrupts.  Here
16 periods per buffer are used.

init voice - master 1 extra 1 start_addr 0x1000 end_addr 0x2000
init voice - master 1 extra 0 start_addr 0x1000 end_addr 0x11000
init voice - master 0 extra 0 start_addr 0x1000 end_addr 0x11000

Here is the multichannel device being opened.  I split the buffer up
into 16 chunks, and allocate a voice for each:

pcm_channel_alloc: voices=16
in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x11000
init voice - master 1 extra 0 start_addr 0x1000 end_addr 0x2000
init voice - master 1 extra 0 start_addr 0x2000 end_addr 0x3000
init voice - master 1 extra 0 start_addr 0x3000 end_addr 0x4000
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:

Looks good, until it Oops'es.  This is because currently the voice
allocator only handles one or two voices at a time, it blows up as soon
as I go to initialize the third voice.  I am working on this.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
