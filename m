From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: Pop noise on startup when headphones are plugged
	in (Dell XPS13 9333)
Date: Mon, 20 Apr 2015 21:49:49 +0200
Message-ID: <3004927.Zk5y6zPyn3@xps13>
References: <23057263.IjMh4t6SYF@xps13> <s5h618rwdc8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id CCF7C2654FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 21:49:51 +0200 (CEST)
Received: by widdi4 with SMTP id di4so104709859wid.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 12:49:51 -0700 (PDT)
In-Reply-To: <s5h618rwdc8.wl-tiwai@suse.de>
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

On Monday 20 April 2015 07:58:15 Takashi Iwai wrote:
> At Sun, 19 Apr 2015 19:26:58 +0200,
> Gabriele Mazzotta wrote:
> > 
> > Hi,
> > 
> > I've recently found that commit a551d91473 ("ALSA: hda - Use regmap for
> > command verb caches, too") is somehow causing a pop noise on startup
> > when headphones are plugged in, but I couldn't figure out the exact
> > cause. Was this observed on other systems (mine is a Dell XPS13 9333,
> > Realtek ALC3661)? Does anyone have any idea of what the cause might be?
> 
> Are you sure that the commit is the culprit?  There are lots of other
> changes like the widget-based power saving.

Quite sure. I did a bisection to get it. 5e56bcea5017 ("ALSA: hda -
Allow driver to add vendor-specific verbs for regmap") is OK.
Also, if I revert a551d91473 in the current linux-next tree, the
startup noise goes away.

> In anyway, please give alsa-info.sh output.

http://www.alsa-project.org/db/?f=7d283ebf64ca750482ec5ed6174a1b860fa70631
