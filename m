From: "Pablo N. Hess" <pablonhess@gmail.com>
Subject: Re: HDA Conexant: is mic boost possible?
Date: Wed, 05 Sep 2007 12:12:37 -0300
Message-ID: <46DEC765.9020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 447931038FF
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 17:17:12 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so2214715wxc
	for <alsa-devel@alsa-project.org>; Wed, 05 Sep 2007 08:17:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 > I believe mic boost is on by default.  What model are you running this
 > as?  Laptop or Fujitsu?
 >
 > Tobin


I'm running it as model 'laptop'.

Any other hint at what might be causing this different behavior 
depending on the mic being stereo or mono, then?

In case someone needs it, I'll write again the quick description of the 
problem:

 > alsa-driver-1.0.14:
 >    playback: ok
 >    recording:
 >      stereo mic: ok
 >      mono mic: no input at all (very high volume already tried)
 >
 > alsa-driver-1.0.15rc1:
 >    playback: ok (even better than with alsa-driver-1.0.14)
 >    recording:
 >      stereo mic: ok (seems better than with alsa-driver-1.0.14)
 >      mono mic: *very* very low volume, bad quality, lots of low-volume
 > noise, too.

Thanks a lot,
Pablo
