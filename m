From: Pontus Lidman <pontus@lysator.liu.se>
Subject: Capture problems, 'bogus'(?) audio overrun, pcm, via8233
Date: 04 Dec 2002 21:33:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <n665u9wmkz.fsf@saida.lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm experiencing audio overruns when recording with an ALSA
application, but after investigation I'm inclined to consider them
'bogus' because I believe there is no way that the buffer can be
overrun in such a short time. I don't know how I can avoid them, I
hope somebody can help me troubleshoot this.

The application, 'avview' (TV capture software), runs fine for some
time, randomly between 5-30 seconds, independent of sampling rate,
after every snd_pcm_prepare, but then I get an audio overrun
reported. This is invariably when a very short time elapsed since the
last successful read.

I tried to record about 10 minutes, and I got 37 overruns. I measured
the time since the last read, when the buffer is supposedly near
empty, and the intervals are between 3 and 36 microseconds, the
average being 18 microseconds. Obviously something strange is going
on.

When the reading loop is successful, the time between successful reads
depends on the blocksize; since the read call has to block to wait for
data, I assume I'm calling the read function often enough. Since I'm
recording video at the same time, the system is a bit loaded, but
'top' reports constantly more than 50% idle.

My hardware is a MSI KT3 Ultra2 motherboard with 'VIA Technologies,
Inc. VT8233 AC97 Audio Controller (rev 80)' (source: cat /proc/pci).

For ALSA, stop threshold is set to 65536, buffer time is set to
100020, I'm doing blocking reads. I've tried varying these settings,
as well as the size to read in each read call, but with no real
success.

The main recording loop goes something like this:

    snd_pcm_prepare(recording_handle);
    while (cont) {

	a = snd_pcm_readi(recording_handle, buffer, 200);

	if (a > 0) {
	    gettimeofday(&last_success, NULL);
            store_data();
        } else if (a == -EPIPE) {
	    gettimeofday(&now, NULL);
	    report_overrun(&last_success, &now);
	    snd_pcm_prepare(data->recording_handle);
	    goto next;
        }
    next:

    }

If there is any information I forgot to report, please let me know.

Regards,

Pontus

-- 
Pontus Lidman, pontus@lysator.liu.se, Software Engineer
No matter how cynical you get, it's impossible to keep up.
Scene: www.dc-s.com | MUD: tyme.envy.com 6969 | irc: irc.quakenet.eu.org


-------------------------------------------------------
This SF.net email is sponsored by: Microsoft Visual Studio.NET 
comprehensive development tool, built to increase your 
productivity. Try a free online hosted session at:
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr0003en
