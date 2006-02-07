From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Building my driver
Date: Tue, 07 Feb 2006 23:48:54 +0000
Message-ID: <1139356135.9199.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id E85301C8
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2006 00:48:58 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k17Nmth8001525
	for <alsa-devel@alsa-project.org>; Tue, 7 Feb 2006 23:48:55 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have got alsa-lib and the alsa-utils built and installed on my
Dreamcast and want to test my driver code (at
http://newgolddream.dyndns.info/repos) (I know it won't work but I want
to see that it is calling the right code and so on).

I have no .asoundrc or alsa.conf so I use this:


 aplay -D hw:0,0 /etc/fstab

Just to test - but I get this output

aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
Aborted

I am just not sure why this assertion is likely to fail


>From the files:
http://newgolddream.dyndns.info/lxr/source/alsa_lib/src/pcm/pcm.c#2115


2108  * \brief Opens a PCM
2109  * \param pcmp Returned PCM handle
2110  * \param name ASCII identifier of the PCM handle
2111  * \param stream Wanted stream
2112  * \param mode Open mode (see #SND_PCM_NONBLOCK, #SND_PCM_ASYNC)
2113  * \return 0 on success otherwise a negative error code
2114  */
2115 int snd_pcm_open(snd_pcm_t **pcmp, const char *name, 
2116                  snd_pcm_stream_t stream, int mode)
2117 {
2118         int err;
2119         assert(pcmp && name);
2120         err = snd_config_update();
2121         if (err < 0)
2122                 return err;
2123         return snd_pcm_open_noupdate(pcmp, snd_config, name, stream, mode);
2124 }



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
