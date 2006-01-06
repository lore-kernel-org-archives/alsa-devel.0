From: Jaroslav Kysela <perex@suse.cz>
Subject: simple PCM helper function
Date: Fri, 6 Jan 2006 21:10:26 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0601062102080.10811@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 579B5139
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 21:10:27 +0100 (MET)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 2916099018
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 21:10:27 +0100 (MET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 0CC652E03F
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2006 21:10:27 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I added three functions to alsa-lib - PCM API:

/*
 * application helpers - these functions are implemented on top
 * of the basic API
 */

int snd_pcm_recover(snd_pcm_t *pcm, int err, int silent);
int snd_pcm_set_params(snd_pcm_t *pcm,
                       snd_pcm_format_t format,
                       snd_pcm_access_t access,
                       unsigned int channels,
                       unsigned int rate,
                       int soft_resample,
                       unsigned int latency);
int snd_pcm_get_params(snd_pcm_t *pcm,
                       snd_pcm_uframes_t *buffer_size,
                       snd_pcm_uframes_t *period_size);

	These functions are intended for "lazy" people who are doing just 
simple command line players or recorders and don't want to bother with
the ALSA details. The implementation comes from strong attitude against
alsa-lib on LKML by some people.
	Please, look to them and tell me, if I missed something useable.
The really "minimalistic" example using these functions is in 
alsa-lib/test/pcm_min.c (compile the code typing 'make pcm_min' in the 
test directory).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
