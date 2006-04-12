From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Wed, 12 Apr 2006 16:18:08 -0400
Message-ID: <1144873089.27496.22.camel@mindpipe>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060412200957.GA4090@hurl.ugcs.caltech.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-04-12 at 13:09 -0700, Lance Blisters wrote:
> I bought a Layla24 and Cardbus adaptor.  Works beatifully with ALSA/JACK/ARDOUR up to 8 channels.  However, the soundcard presents the 8 analog channels as device 0 and 8 digital channels as device 1.  JACK will only open one device at a time.  So in order to record 16 channels with Ardour, I apparently need to create a virtual ALSA device combining the two LAYLA subdevices.
> 
> Has anyone solved this problem for this device?  I know ".asoundrc" and 
> "multi" and company, but that is far from a complete answer - what
> I really need is an actual functional .asoundrc.
> 
> Please CC me, as I had to drop off the list about five years ago due to
> bandwidth limitations.

Maybe someone can explain why this .asoundrc does not work, AFAICT it
should.  The error is:

ALSA lib conf.c:1592:(snd_config_load1)_toplevel_:606:27:Unexpected char
ALSA lib conf.c:2837:(snd_config_hook_load)/root/.asoundrc may be old or
corrupted consider to remove or fix it

Character 27 is either the '1' or the newline.

The analog device is "hw:0,0" and digital "hw:0,1", right?

# .asoundrc for layla 
#
# Create virtual devices out of multipls subdevices
# JACK will need MMAP_COMPLEX support to use this. 

pcm.multi_capture {
	type multi
	slaves.a.pcm hw:0,0
	slaves.a.channels 8
	slaves.b.pcm hw:0,1
	slaves.b.channels 8

# First 8 channels of first soundcard (capture)
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
    
# First 8 channels of second soundcard (capture)
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

pcm.multi_playback {
	type multi
	slaves.a.pcm hw:0,0
	slaves.a.channels 8
	slaves.b.pcm hw:0,1
	slaves.b.channels 8

# First 8 channels of first soundcard (playback)
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

# First 8 channels of second soundcard (playback)
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






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
