From: Joachim Deguara <dga@idmt.fraunhofer.de>
Subject: Re: rme 9632 crackling when sound > 0db
Date: Tue, 13 Apr 2004 08:37:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407B8AB3.2030407@idmt.fraunhofer.de>
References: <407A5F99.4040201@wildgooses.com> <407A6A6B.2070201@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgw1.fraunhofer.de (mailgw1.fraunhofer.de [153.96.1.62])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA11972
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2004 08:37:46 +0200
In-Reply-To: <407A6A6B.2070201@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The good news: you don't have a driver problem!  But it sounds like you 
have a Wordclock problem.  Namely, your rme 9632 has a different clock 
than your playback device (D/A) and they are not in Sync.  Check the 
setting for who is (and should be) Wordclock Master and take adjust 
accordingly.  You can set the mode of synchronisation for you card by 
editing /etc/asound.state and the running "alsactl restore".

-joachim

Ed Wildgoose wrote:
> 
>>
>> You can also simulate this simply by turning up the mixer controls so 
>> that normal music starts to clip.  Same effect.
> 
> 
> 
> 
> At risk of creating noise.  Further experimentation shows that you need 
> to set the output levels to +4db in hdspconf for this crackling to 
> occur.  So in fairness this could really be an overdriven output...?
> 
> The -10dbv output level is significantly quieter than any other 
> equipment that I own (I know it's what they call consumer output device 
> level, but still...)
> 
> Ed W
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-- 
Joachim Deguara				Email: dga@idmt.fraunhofer.de
Fraunhofer IDMT, Langewiesener St. 22, 98693 Ilmenau, Germany
Phone: +49 3677/69-4851 		Fax:   +49 3677/69-4399


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
