From: <ico@fuse.net>
Subject: Does ALSA offer built-in PLUG for JACK and non-interleaved cards?
Date: Tue, 20 Apr 2004 13:38:38 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040420133839.RTOO4748.smtp1.fuse.net@smtp.fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
Cc: ico@fuse.net
List-Id: alsa-devel@alsa-project.org

Hi all,

2 quick questions:

1) A while ago I heard that the JACK plug has been included into the ALSA's default array of plugs. Also today I found this on the Web (for the asoundrc):

pcm.jackplug {
	type plug
	slave { pcm "jack" }
}

pcm.jack {
	type jack
	playback_ports {
		0 alsa_pcm:playback_1
		1 alsa_pcm:playback_2
	}
	capture_ports {
		0 alsa_pcm:capture_1
		1 alsa_pcm:capture_2
	}
}

Does this mean that now one can channel ALSA-only aware apps directly to JACK and if so, are there any penalties of doing it this way as oposed to using JACK-aware apps (i.e. Sample-sync?)?


2) Is there also a plug in ALSA that allows for non-interleaved cards (i.e. hdsp) to be directly talked to (i.e. using aplay) since by default aplay complains how the soundcard is not interleaved and hence it fails.

Apologies if these questions have been answered before. I did a bit of looking through the archives but was unable to find anything of relevance.

Many thanks for your help!

Best wishes,

Ico



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
