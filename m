From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
Subject: Error with snd_pc_sw_params in pcm.c
Date: Fri, 5 Nov 2004 22:55:34 +0100
Message-ID: <20041105215534.GA28584@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all ;),

I'm suffering this error when trying to play a mp3 file with madplay. First
of all, some versions:

kernel 2.6.9
alsa-lib-1.0.7rc2
madplay-0.15.2b

And i got this error:

MPEG Audio Decoder 0.15.2 (beta) - Copyright (C) 2000-2004 Robert Leslie et al.
ALSA lib pcm.c:826:(snd_pcm_sw_params) snd_pcm_sw_params: params->avail_min
problem for start_threshold Unable to set sw params for playback: Invalid
argument
output: Invalid argument

Thanks,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
