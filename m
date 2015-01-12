From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Card name size?
Date: Mon, 12 Jan 2015 22:25:34 +0000
Message-ID: <201501122225.34229.gineera@aspect135.co.uk>
References: <201501112052.00328.gineera@aspect135.co.uk>
 <s5hbnm4j5uy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 5.array2.smtp.34sp.com (5.array2.smtp.34sp.com [46.183.10.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F6932612D1
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 23:24:42 +0100 (CET)
Received: from smtpauth1.array1.smtp.34sp.com (lvs3.34sp.com [80.82.124.221])
 by 5.array2.smtp.34sp.com (Postfix) with ESMTP id 3DF4A205BA
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 22:24:36 +0000 (GMT)
In-Reply-To: <s5hbnm4j5uy.wl-tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 12 January 2015 16:55, Takashi Iwai wrote:
> At Sun, 11 Jan 2015 20:52:00 +0000, Alan Horstmann wrote:
> > Just a quick question...
> > is there a (guaranteed) max size to the name string returned by
> >    snd_ctl_card_info_get_name()
> > or is it just whatever the driver sets?
>
> It's max 32 letters (including NUL).
> longname and mixername are max 80, id and driver are max 16.

Thanks very much; so I am OK to use a fixed 32 char array (with strncpy() just 
to be safe).

BTW my original post didn't seem to make it to the list. Any idea why?

Regards

Alan
