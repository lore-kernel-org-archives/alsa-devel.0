From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] override iec958 definition in .asoundrc?
Date: Sun, 12 Sep 2004 00:04:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094961877.1306.230.camel@krustophenia.net>
References: <20040911150202.GA15014@cloud.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040911150202.GA15014@cloud.net.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hamish Moffatt <hamish@cloud.net.au>
Cc: alsa-user@lists.sf.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-11 at 11:02, Hamish Moffatt wrote:
> Hi,
> 
> I've found that the default ALSA configuration (on Debian at least) in
> /usr/share/alsa/ defines the "iec958" on the EMU10K1 as device 3.
> On my card I have found that device 0 is the one to use though.
> 
> Is it possible for me to redefine iec958 for a particular card through
> ~/.asoundrc?
> 
> I want the simple "iec958" to be "hw:0,2" (my nForce2) currently, but
> I want eg ac3dec to do the right thing when I say:
> 
> hamish@tv:~/ac3$ ac3dec -C -c 1 ac3test-stream
> Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2 CARD 1}'
> AC3 Stream 48.0 KHz 448 kbps
> 
> This uses the default iec958 device on card 1, which is device 3 by
> default. I modified /usr/share/alsa/cards/EMU10K1.conf for now, but
> that change will be lost when the package is upgraded next.
> (Is that a bug in the Debian package? Should users be allowed to
> modify the master configuration files?)
> 

The iec958 passthrough device was moved from hw:0,3 to hw:0,2 in ALSA
1.0.6.  Takashi-san made this change at my suggestion.  Now I am
convinced it was a mistake.

When I suggested this I was new to ALSA and did not understand the
emu10k1 driver at all; I believed that the hw:0,3 device was equivalent
to the ASIO playback device in the Windows driver and that this would
typically be used in full duplex mode with the hw:0,2 capture device. 
Now that I know the driver well, I realize that you would never, ever
use this combination - the AC3 passthrough device and EFX capture device
have nothing to do with each other.

I pointed this out not long after the change was made, but nothing much
came of it.  I would again ask that the iec958 device be moved back to
hw:0,3 before too many people notice, otherwise this is the first of
many many bug reports.

This will be especially important in the near future, as I am working on
a playback device that _does_ correspond to kX ASIO and maps 1:1 onto
the EFX capture device hw:0,2.  If we leave the EFX capture device at
hw:0,2 then the EFX playback device ends up on hw:0,1 or hw:0,4 or
something and it will be a nightmare.

I have already seen a few posts from users surprised that this device
moved for no good reason.  Please, revert this change before it's too
late.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
