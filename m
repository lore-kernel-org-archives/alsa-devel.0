From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: rme 9632 crackling when sound > 0db
Date: Tue, 13 Apr 2004 16:15:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407C041D.6040503@wildgooses.com>
References: <407A5F99.4040201@wildgooses.com> <407A6A6B.2070201@wildgooses.com> <407B8AB3.2030407@idmt.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xunil.mail.wildgooses.com (xunil.mail.wildgooses.com [81.6.236.5])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA23458
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2004 17:16:37 +0200
In-Reply-To: <407B8AB3.2030407@idmt.fraunhofer.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joachim Deguara <dga@idmt.fraunhofer.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Joachim Deguara wrote:

> The good news: you don't have a driver problem!  But it sounds like 
> you have a Wordclock problem.  Namely, your rme 9632 has a different 
> clock than your playback device (D/A) and they are not in Sync.  Check 
> the setting for who is (and should be) Wordclock Master and take 
> adjust accordingly.  You can set the mode of synchronisation for you 
> card by editing /etc/asound.state and the running "alsactl restore".


Hi, Thanks for the thought, but I don't see how this could be the 
issue?  I am reading input from the HD, writing it to the card via 
either oss or alsa, and the output is analogue to a pre-amp and then on 
to an amplifier.  The crackle only occurs when I use +4db as the output 
level, and then either find a song which clips anyway, or crank up the 
mixer so that the output clips.  It could actually be some sort of 
electrical issue at the pre-amp to be fair, it's just that I don't 
remember it happening before?  It doens't seem to be a problem if I drop 
the output level to the -10bdv setting for example.

The main thing I would prefer to debug right now anyway is why mplayer 
doesn't work with this card.  A cursory glance at the mplayer output 
code suggests that everything looks fine...  Oh well, will need to break 
out that code and study it a bit more - most other apps are working now 
though

Thanks

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
