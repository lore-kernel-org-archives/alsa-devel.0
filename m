From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Multi ice1712 .asoundrc problem
Date: Sun, 13 Nov 2005 22:31:05 +0000
Message-ID: <20051113223105.GA4822@localhost.localdomain>
References: <E1EbIYV-00019A-4u@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E1EbIYV-00019A-4u@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 13, 2005 at 02:10:03PM +0000, John Rigg wrote:
> I've been trying for some time to get two ice1712 cards (M-Audio Delta 1010)
> to work together, so far unsuccessfully.

The .asoundrc below _almost_ works. I get 16 channels of playback
or 16 channels of capture, but not both. I'm using jack with
MMAP_COMPLEX support added, so the usual route plugin/ttable isn't
needed.
I'm using the following command to start jack:

jackd -d alsa -d multi_duplex -p 128

This fails with a poll time out. If I add the -C or -P option to start
in capture- or playback-only mode, it starts and runs. 
Setup is 2.6.14-rt6 x86_64 SMP kernel (alsa-driver-1.0.10rc1),
alsa-lib-1.0-10rc2, jack-0.100.7 + MMAP_COMPLEX patch, 
Debian unstable amd64.

It looks to me like the asym plugin isn't working (or I'm not using it
correctly). Any ideas?

John
                 __________________________________

# .asoundrc for two Delta 1010s

# Alias for first card
pcm.delta1010_0 {
	type hw
	card 0
}
ctl.delta1010_0 {
	type hw
	card 0
}

# Alias for second card
pcm.delta1010_1 {
	type hw
  	card 1
}
ctl.delta1010_1 {
	type hw
	card 1
}

# Create virtual devices out of multiple soundcards.
# JACK will need MMAP_COMPLEX support to use this. 
# ICE1712 chip has 12 capture channels and 10 playback channels
# so separate playback and capture devices need to be created.
# No. of channels in slaves must equal 12 for capture and 10 for playback
# otherwise "broken configuration" and "invalid argument" errors result.

pcm.multi_playback {
	type multi

	slaves.a.pcm delta1010_0
	slaves.a.channels 10

	slaves.b.pcm delta1010_1
	slaves.b.channels 10

# First 8 channels of first soundcard
 	bindings.0.slave a
 	bindings.0.channel 0
 	bindings.1.slave a
 	bindings.1.channel 1
 	bindings.2.slave a
 	bindings.2.channel 2
 	bindings.3.slave a
 	bindings.3.channel 3
 	bindings.4.slave a
 	bindings.4.channel 4
 	bindings.5.slave a
 	bindings.5.channel 5
 	bindings.6.slave a
 	bindings.6.channel 6
 	bindings.7.slave a
 	bindings.7.channel 7
    
# First 8 channels of second soundcard
 	bindings.8.slave b
 	bindings.8.channel 0
 	bindings.9.slave b
 	bindings.9.channel 1
 	bindings.10.slave b
 	bindings.10.channel 2
 	bindings.11.slave b
 	bindings.11.channel 3
 	bindings.12.slave b
 	bindings.12.channel 4
 	bindings.13.slave b
 	bindings.13.channel 5
 	bindings.14.slave b
 	bindings.14.channel 6
 	bindings.15.slave b
 	bindings.15.channel 7

}

ctl.multi_playback {
	type hw
	card 0
}

pcm.multi_capture {
	type multi
	
	slaves.a.pcm delta1010_0
	slaves.a.channels 12

	slaves.b.pcm delta1010_1
	slaves.b.channels 12

# First 8 channels of first soundcard
 	bindings.0.slave a
 	bindings.0.channel 0
 	bindings.1.slave a
 	bindings.1.channel 1
 	bindings.2.slave a
 	bindings.2.channel 2
 	bindings.3.slave a
 	bindings.3.channel 3
 	bindings.4.slave a
 	bindings.4.channel 4
 	bindings.5.slave a
 	bindings.5.channel 5
 	bindings.6.slave a
 	bindings.6.channel 6
 	bindings.7.slave a
 	bindings.7.channel 7
    
# First 8 channels of second soundcard
 	bindings.8.slave b
 	bindings.8.channel 0
 	bindings.9.slave b
 	bindings.9.channel 1
 	bindings.10.slave b
 	bindings.10.channel 2
 	bindings.11.slave b
 	bindings.11.channel 3
 	bindings.12.slave b
 	bindings.12.channel 4
 	bindings.13.slave b
 	bindings.13.channel 5
 	bindings.14.slave b
 	bindings.14.channel 6
 	bindings.15.slave b
 	bindings.15.channel 7

}

ctl.multi_capture {
	type hw
	card 0
}

# ICE1712 has 10 channels for playback and 12 for capture so asym
# plugin must be used

pcm.multi_duplex {
	type asym
	playback.pcm multi_playback
	capture.pcm multi_capture
}

ctl.multi_duplex {
	type hw
	card 0
}



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
