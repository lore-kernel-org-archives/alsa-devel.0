From: "Juan Carlos Granda" <granda@telecable.es>
Subject: Re: Audio and Video sync. Getting Timestamps
Date: Fri, 7 May 2004 01:32:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <002501c433c2$70a06b90$a6b06153@palmian>
References: <1083748400.4098b030eeb58@www.telecable.es> <s5hn04n1aer.wl@alsa2.suse.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

That's my app does:

1.- Open the device for capture
2.- Set the access mode SND_PCM_ACCESS_RW_INTERLEAVED
3.- Set format 16 bits (SND_PCM_FORMAT_S16_LE)
4.- Set channels 2 (stereo)
5.- Set buffer time near 1 second
6.- Set period time near 0.1 seconds
7.- Copy the hardware params to alsa
8.- Set start threshold (0x7fffffffff -> Explicit start)
9.- Set transfer align 1
10.- Copy the software params to alsa

read loop:
    - Read 'period size' frames (snd_pcm_readi)

How can i get the timestamp of the first frame read? If i use
snd_pcm_status_get_trigger_tstamp i obtain the same timestamp all the times.
If i use snd_pcm_status_get_tstamp i obtain the "now" time. Is there any way
to get the timestamp of every period.

Thanks






-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
