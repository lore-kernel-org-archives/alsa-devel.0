From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: read size using poll
Date: Wed, 24 Apr 2002 15:03:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020424150354.76ab76ae.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA03183
	for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2002 15:05:16 +0200
Received: from [193.145.55.62] (helo=bitone)
	by iuamtg.upf.es with smtp (Exim 3.34 #1 (Debian))
	id 170MPP-0003hD-00
	for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2002 15:02:07 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I was assuming that using poll (snd_pcm_wait), with the
alsa-lib/test/latency.c program would have snd_pcm_read
return period size samples at a time, but this is not
the case.

As far as I understand, the problem is that in the following
code:

	val = !block ? 4 : snd_pcm_hw_params_get_period_size(params, NULL);
	if (tick_time_ok > 0)
		val = 16;
	err = snd_pcm_sw_params_set_avail_min(handle, swparams, val);

val = 4, instead of snd_pcm_hw_params_get_period_size(params, NULL);
(because with poll, block = 0)

Is there any reason for this? Wouldn't it make more sense to
simply do

	val = snd_pcm_hw_params_get_period_size(params, NULL);
	err = snd_pcm_sw_params_set_avail_min(handle, swparams, val);

So, is my assumption wrong, or is the code wrong? If my assumption
is wrong, could you explain me why it is better/more logical that
the latency test is polling for very small buffers, instead of the
latency?

Maarten
