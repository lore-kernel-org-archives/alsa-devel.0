From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: Noise Problem
Date: Wed, 14 May 2003 08:17:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030514061752.GA22960@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

 Hi.

I've tried to record a few samples with my M-Audio Audiophile using the
following settings:
Format: 24_3LE, 2 channels, sampling rate 48 kHz, pcm device
pcm.hwmix {
    type plug
    slave {
        pcm "hw:0,0"
        format S32_LE
    }
    ttable.0.10 1
    ttable.1.11 1
}

At the first view everything looked fine, but dragging down all sliders in 
the mixer, there was still a noise at approx. -80dB on channel 1, while 
channel 0 was far bellow -100dB.
The noise has gone, as I changed the above routing table something like this
ttable.0.10 1
ttable.0.8  0.01
ttable.1.11 1
ttable.1.7  0.01

There seems to be a flaw in pcm_route: 
@@ -790,15 +792,7 @@
 #endif
 		dptr->att = att;
 		dptr->nsrcs = nsrcs;
-		if (nsrcs == 0)
-			dptr->func = snd_pcm_route_convert1_zero;
-		else if (nsrcs == 1 && !att) {
-			if (params->use_getput)
-				dptr->func = snd_pcm_route_convert1_one_getput;
-			else
-				dptr->func = snd_pcm_route_convert1_one;
-		} else
-			dptr->func = snd_pcm_route_convert1_many;
+		dptr->func = snd_pcm_route_convert1_many;
 		if (nsrcs > 0) {
 			dptr->srcs = calloc((unsigned int) nsrcs, sizeof(*srcs));
 			if (!dptr->srcs)


params->use_getput should be 1 here, but it is 0, it becomes 1 later on.
The whole case distinction is made again in snd_pcm_route_convert1_many, 
removing it here solves my problem.

  ciao
    gd...

-- 
Gerhard Dirschl
Karlsruhe
Germany


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
