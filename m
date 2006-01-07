From: Dave Raggett <dsr@w3.org>
Subject: Conditionally compiling for 1.0.9 and later ?
Date: Sat, 7 Jan 2006 11:38:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0601071129490.14151@holly>
References: <Pine.LNX.4.61.0601062102080.10811@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from homer.w3.org (homer.w3.org [128.30.52.30])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E82E13A
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 12:37:57 +0100 (MET)
Received: from localhost (homer.w3.org [128.30.52.30])
	by homer.w3.org (Postfix) with ESMTP id 0A7A34F16C
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 06:37:55 -0500 (EST)
In-Reply-To: <Pine.LNX.4.61.0601062102080.10811@tm8103.perex-int.cz>
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am looking for advice on the best way to conditionally
compile application code to use hardware resampling for
ALSA when this is available. One possible approach is to
do an #ifdef on SNDRV_PCM_HW_PARAMS_NORESAMPLE as show
below, but is there a better way?

#ifdef SNDRV_PCM_HW_PARAMS_NORESAMPLE
   /* set hardware resampling */
   err = snd_pcm_hw_params_set_rate_resample(handle,
                                params, resample);
   if (err < 0)
   {
     printf("Resampling setup failed for playback: %s\n",
                                snd_strerror(err));
     return err;
   }
#endif

p.s. I understand that snd_pcm_hw_params_set_rate_resample()
was first introduced in version 1.0.9 and found that
SNDRV_PCM_HW_PARAMS_NORESAMPLE first appeared in that version.
My goal is allow my code to compile with earlier versions of
ALSA when so needed.

Many thanks,
- -- 
  Dave Raggett <dsr@w3.org>  W3C lead for multimodal interaction
  http://www.w3.org/People/Raggett +44 1225 866240 (or 867351)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDv6glb3AdEmxAsUsRAgUOAKC2ErZLNeCUw5pvd2XgTatNM5O4+wCg4udi
tA6hKBXy77dMokISn+tJmrU=
=ODw7
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
