From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Possible bug in alsa-lib. snd_pcm_hw_params_get_periods_max() returning
 512 instead of 2.
Date: Wed, 09 Jun 2004 12:52:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C6F9F2.6040203@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9DA9E1E0
	for <alsa-devel@alsa-project.org>; Wed,  9 Jun 2004 13:52:08 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-34.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BY1cl-000KqI-0Y
	for alsa-devel@alsa-project.org; Wed, 09 Jun 2004 12:52:07 +0100
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

I have the following settings(see below) in my test audigyls driver 
version. Note the periods_min and periods_max both set to 2.
If the application opens the device with "plug:front".
Source code extract: -
dir=0;
err = snd_pcm_hw_params_get_periods_min(params, &periods_min,&dir);
dir=0;
err = snd_pcm_hw_params_get_periods_max(params, &periods_max,&dir);
printf("Periods range from %u to %u\n",periods_min, periods_max);

That will print the message: -
Periods range from 0 to 512

I thought that this should have printed: -
Periods range from 2 to 2

If my app sets the period size first, the buffer size can only be set to 
2*period size, so I would have expected the 
snd_pcm_hw_params_get_periods_max() to return 2 instead of 512.

Is this an alsa-lib bug ?

Cheers
James




static snd_pcm_hardware_t snd_audigyls_playback_hw = {
         .info =                 (SNDRV_PCM_INFO_MMAP |
                                  SNDRV_PCM_INFO_INTERLEAVED |
                                  SNDRV_PCM_INFO_BLOCK_TRANSFER |
                                  SNDRV_PCM_INFO_MMAP_VALID),
         .formats =              SNDRV_PCM_FMTBIT_S16_LE,
         .rates =                SNDRV_PCM_RATE_48000,
         .rate_min =             48000,
         .rate_max =             48000,
         .channels_min =         1,
         .channels_max =         6,
         .buffer_bytes_max =     (32*1024),
         .period_bytes_min =     64,
         .period_bytes_max =     (16*1024),
         .periods_min =          2,
         .periods_max =          2,
         .fifo_size =            0,


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
