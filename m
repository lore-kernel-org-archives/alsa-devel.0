From: "Tom Browne" <tbrowne@tbrowne.demon.co.uk>
Subject: Re: snd_pcm_writei not returning (?!?)
Date: Mon, 5 Apr 2004 17:16:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <003d01c41b29$52014300$0100a8c0@burpxp>
References: <Pine.HPX.4.33n.0404051748200.25421-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Tom Browne wrote:
>> Under certain conditions (yet to be established properly - it doesn't
>> happen every single time) with this ICE1712 card (DSP24),
>> snd_pcm_writei doesn't just block... it never comes back.
> 
> What is the state of the PCM device when this happens?
> (see /proc/asound/cardX/pcm0p/*)

state: PREPARED
trigger_time: 1081181127.688456000
tstamp      : 1081181132.845346000
delay       : 0
avail       : 5
avail_max   : 7060
-----
hw_ptr      : 0
appl_ptr    : 6548

- Tom.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
