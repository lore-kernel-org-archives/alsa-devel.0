From: Lance Blisters <geoff@hurl.ugcs.caltech.edu>
Subject: Re: 16-channel recording w/ LAYLA, ALSA, JACK, ARDOUR
Date: Thu, 13 Apr 2006 20:00:33 -0700
Message-ID: <20060414030033.GA13550@hurl.ugcs.caltech.edu>
References: <20060412200957.GA4090@hurl.ugcs.caltech.edu> <1144873089.27496.22.camel@mindpipe> <1144878001.27496.33.camel@mindpipe> <20060413031705.GA9160@hurl.ugcs.caltech.edu> <1144898970.10666.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1144898970.10666.139.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 12, 2006 at 11:29:30PM -0400, Paul Davis wrote:
> On Wed, 2006-04-12 at 20:17 -0700, Lance Blisters wrote:
> 
> > ALSA: cannot configure playback channel
> > cannot load driver module alsa
> 
> i don't believe that "multi" will work without the MMAP_COMPLEX patch to
> JACK that has been outstanding for months and months. its available in
> the patch tracker at jackit.sf.net if you want to try it; otherwise i
> intend to merge it next week or the week after.

is this it?

[ 1289682 ] M-Audio Audiophile USB and other byteswapped devices support

i applied it (had to apply memop.c by hand), but

JACK_DRIVER_DIR=./drivers/alsa/.libs/ ./jackd/jackd -R -t5000 -dalsa -dmulti_playback -r44100 -p256 -n2 -P -s
loading driver ..
apparent rate = 44100
creating alsa driver ... multi_playback|-|256|2|44100|0|0|nomon|swmeter|soft-mode|32bit
configuring for 44100Hz, period = 256 frames, buffer = 2 periods
ALSA: no playback configurations available (Invalid argument)
ALSA: cannot configure playback channel
cannot load driver module alsa
zsh: segmentation fault  JACK_DRIVER_DIR=./drivers/alsa/.libs/ ./jackd/jackd -R -t5000 -dalsa  -r44100

the other three patches don't seem relevant.

> this command: 
> 
>    jackd -d alsa -P hw:0 -C hw:1
> 
> opens different devices for capture and playback

glad i was wrong about this.

  -geoff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
