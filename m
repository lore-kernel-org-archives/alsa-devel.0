From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: how to define a 2-index control element?
Date: Sat, 04 May 2002 15:18:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CD3DFA3.4395E0B4@alsa-project.org>
References: <200205041245.g44Cjgq07507@op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.libero.it (smtp2.libero.it [193.70.192.52])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA19944
	for <alsa-devel@alsa-project.org>; Sat, 4 May 2002 15:19:39 +0200
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
> i'm looking at the control API, and i can't see how to define a
> control that requires 2 values in order to read or write the control.
> 
> there seems to be an assumption that a control element maps 1:1 onto a
> hardware entity. i want (need) to create a control element that is
> more flexible than that. the basic idea is:
> 
>          control->value.integer.value[0] = source;
>          control->value.integer.value[1] = destination;
> 
>          snd_ctl_read (...)
> 
> or:
> 
>          control->value.integer.value[0] = source;
>          control->value.integer.value[1] = destination;
>          control->value.integer.value[3] = gain;
> 
>          snd_ctl_write (...)
> 
> am i missing something really simple?
> 

I suggest you to use the field index of struct sndrv_ctl_elem_id (one
byte per dimension).

id.index = (source << 8) | destination;


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
