From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 10:04:47 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD8DC1F.709754AF@alsa-project.org>
References: <200205080008.g4808se10498@op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA02710
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 10:04:55 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> the h-dsp has some 64 bit registers. the current control API doesn't
> offer a way of representing such values. shall i add
> 
>       SNDRV_CTL_ELEM_TYPE_INTEGER64
> 
> ?

Just for curiosity, what they store that cannot be represented in 32
bits?!?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
