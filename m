From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: usbaudio: curframesize
Date: Tue, 10 Sep 2002 00:47:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020909224716.34317.qmail@web12204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

the curframesize member of struct snd_usb_substream
seams not to be initialized to something different
from 0.

thus the code sequence 

subs->transfer_sched += subs->curframesize;
if (subs->transfer_sched >= runtime->period_size) {
	subs->transfer_sched -= runtime->period_size;
	break;
}

in static int prepare_capture_urb() doesn't make sense
to me. 
should curframesize be initialized with the minimum
estimated number of frames per 1ms?
like 44 for 44100?

karsten


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
