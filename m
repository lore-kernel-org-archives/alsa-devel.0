From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: struct _snd_pcm_hardware
Date: Thu, 29 Aug 2002 13:57:16 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020829205716.2839.qmail@web11502.mail.yahoo.com>
References: <s5hsn0z9h55.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11502.mail.yahoo.com (web11502.mail.yahoo.com [216.136.172.47])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA28869
	for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2002 23:01:43 +0200
In-Reply-To: <s5hsn0z9h55.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a problem with supporting multiple audio formats in that my hardware
defines its buffers in a number of frames rather than bytes.

I evaluated the changes required to support description of a hardware's period
contraints in frame AND bytes. Essentially, this would mean adding 'size_t
period_size_min' and 'size_t period_size_max' to the stucture _snd_pcm_hardware
in pcm.h, and then add a constraint in snd_pcm_hw_constraints_complete() in
pcm_native.c such that the period size is within those min and max values.
Other drivers wouldn't be affected if the period_size_min/max default values
are properly chosen (i.e. 0 and MAX_UINT, respectively).

Would you consider such a change in the ALSA code base?

Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
