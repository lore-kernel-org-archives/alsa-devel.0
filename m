From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: snd_pcm_wait()  More details required.
Date: Sun, 21 Mar 2004 14:49:00 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405DAB5C.5010106@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-fallback-94.mail.demon.net (anchor-fallback-94.mail.demon.net [194.217.242.94])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA19817
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 00:19:44 +0100
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1064 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-94.mail.demon.net
	with ESMTP id S747710AbUCUTKV (ORCPT
	<rfc822;alsa-devel@alsa-project.org>);
	Sun, 21 Mar 2004 19:10:21 +0000
Received: from superbug.demon.co.uk ([80.176.146.252])
	by anchor-post-30.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1B54CU-000HRm-0U
	for alsa-devel@alsa-project.org; Sun, 21 Mar 2004 14:45:18 +0000
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

I need more details on exactly what snd_pcm_wait() is supposed to do.
The documentation on the www.alsa-project.org gives: -
Wait for a PCM to become ready.

Parameters:
     pcm  	PCM handle
     timeout  	maximum time in milliseconds to wait

Returns:
     a positive value on success otherwise a negative error code (-EPIPE 
for the xrun and -ESTRPIPE for the suspended status, others for general 
errors)

Return values:
     0  	timeout occurred
     1  	PCM stream is ready for I/O



So, when is a PCM ready?
If a PCM is already in SND_PCM_STATE_RUNNING, when is snd_pcm_wait() 
supposed to return ?

I have discovered a problem with xine when using it. I have done a work 
around in xine so that dmix now works in xine. I think that my 
assumptions regarding snd_pcm_wait() might have been wrong, so I want to 
  get accurate details from yourselves.
It also might be a good idea to update the documentation for 
snd_pcm_wait() with more details.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
