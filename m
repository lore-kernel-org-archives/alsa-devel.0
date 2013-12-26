From: Giridhara  <giridharakn@gmail.com>
Subject: Re: =?utf-8?q?snd=5Fpcm=5Fdrain=28=29_always_fails?=
Date: Thu, 26 Dec 2013 11:02:11 +0000 (UTC)
Message-ID: <loom.20131226T120057-387@post.gmane.org>
References: <20050801172719.GB10144@brailcom.cz>
 <Pine.LNX.4.61.0508011953060.12402@tm8103.perex-int.cz>
 <20050801180417.GD10144@brailcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F88F2610CA
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2013 12:02:37 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Vw8i1-0007d5-Hn
 for alsa-devel@alsa-project.org; Thu, 26 Dec 2013 12:02:34 +0100
Received: from 19963142252.honeywell.com ([199.63.142.252])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2013 12:02:33 +0100
Received: from giridharakn by 19963142252.honeywell.com with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2013 12:02:33 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hynek Hanke,,, <hanke <at> volny.cz> writes:

> 
> > > Or, what is the correct way to wait until the rest of the sound is 
> > > played when I'm using the poll() approach?
> > Set the blocking mode before drain() is called (and return the mode back 
> > after it, if you want). 
> 
> Not possible. I'm waiting for other events (not comming from ALSA) too in the
> poll().
> 
> > The better way might be setting sw_params to wakeup app after all frames are
> > played and use the standard poll() call to wait in app.
> 
> How do I do this or where can I read about it? Still, I need to receive
other events
> too while waiting for the sound to stop playing.
> 
> Thank you,
> Hynek Hanke
> 
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> 



Hello Team,

Any body successfully run the audio in the non blocking mode. 
I too have the same issues. 
Please suggest me.
Any sample programs are great help for me. 

Thanks and Regards,
Giri
