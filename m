From: Hynek Hanke <hanke@brailcom.org>
Subject: Re: snd_pcm_drain() always fails
Date: Mon, 1 Aug 2005 20:36:37 +0200
Message-ID: <20050801183637.GF10144@brailcom.cz>
References: <20050801172719.GB10144@brailcom.cz> <Pine.LNX.4.61.0508011953060.12402@tm8103.perex-int.cz> <20050801181015.GE10144@brailcom.cz> <s5hoe8hms06.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out3.iol.cz (smtp-out3.iol.cz [194.228.2.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C59AF176
	for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2005 20:39:49 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5hoe8hms06.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Set avail_min swparams to the buffer size so that poll() won't return
> unless the full buffer size becomes free (i.e. all samples are
> played).  

This would mean, if I understand correctly, that I always send more data only
after the buffer is already empty. Won't that cause unwanted effects
(underrruns etc.)?

With regards,
Hynek Hanke




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
