From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: playback audio overwritten before it is sent to the card
Date: Fri, 26 Jul 2002 13:51:01 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020726205101.32789.qmail@web11502.mail.yahoo.com>
References: <20020726152823.73135.qmail@web11507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11502.mail.yahoo.com (web11502.mail.yahoo.com [216.136.172.47])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA31643
	for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2002 22:51:07 +0200
In-Reply-To: <20020726152823.73135.qmail@web11507.mail.yahoo.com>
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


I am getting to know all the internals (although I didn't really want to)...
the ops->pointer() is called only from snd_pcm_update_hw_ptr(), which updates
the runtime->status->hw_ptr. But it doesn't:

  playback_copy() on sound dev0,  hwoff:0  pos:0 ->160

  playback_pointer() on sound dev0,  last:160  pos:160
     ptr:160  {hw:0, appl:160}
     hw_ptr_base:0  min_align:1  avail_min:160  avail_max:0

So far, so good. In snd_pcm_update_hw_ptr(), new_hw_ptr = runtime->hw_ptr_base
+ pos = 160, so the next time around it should read "hw:160"...

  playback_prepare() on sound dev0,  bsize:320  boundary:1342177280

Is it normal that boundary is so high?

  playback_copy() on sound dev0,  hwoff:0  pos:160 ->320

  playback_pointer() on sound dev0,  last:160  pos:320  ptr:160
     {hw:0, appl:160}
     hw_ptr_base:0  min_align:1  avail_min:160  avail_max:320

Ouch! "hw:0"... Why didn't change? And runtime->control->appl_ptr hasn't
changed either?

  playback_copy() on sound dev0,  hwoff:160  pos:0 ->160

Keep copying to the buffer in runtime->dma_area...

  playback_prepare() on sound dev0,  bsize:320  boundary:1342177280
  playback_copy() on sound dev0,  hwoff:0  pos:160 ->320

Ouch! This one hasn't been sent to the card yet.

Looks like I am having serious trouble here. Any hint very welcome.

Guilhem.


__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
