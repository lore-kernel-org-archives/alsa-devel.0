From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Need expert's advice - Fast Track Ultra (8R)
 dropping samples
Date: Tue, 12 Oct 2010 10:18:24 +0200
Message-ID: <4CB419D0.70808@showlabor.de>
References: <4CA60C5B.6010809@ladisch.de>
	<4CA86E1A.30405@showlabor.de>	<4CAAD212.9090805@ladisch.de>
	<4CAC804A.8040806@showlabor.de>	<4CAC89EA.8080207@ladisch.de>
	<4CACA471.2000504@showlabor.de>	<4CAD6AA2.4050205@ladisch.de>	<20101007081010.GZ7159@buzzloop.caiaq.de>	<4CADB077.3060907@showlabor.de>
	<4CAEB9AC.1060208@ladisch.de>
	<20101012071831.GA7159@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id BE99924487
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 10:18:35 +0200 (CEST)
In-Reply-To: <20101012071831.GA7159@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,


Am 12.10.2010 09:18, schrieb Daniel Mack:
>
> Felix, can you add a
>
>    printk(KERN_WARNING "%s() is_playback %d fill_max %d syncpipe %d\n",
>    	 __func__, is_playback, subs->fill_max, subs->syncpipe);
>
> at the end of set_format() in pcm.c and send us the output?
>    


Here you go:

[195791.510900] set_format() is_playback 0 fill_max 0 syncpipe 0
[195791.513495] set_format() is_playback 1 fill_max 0 syncpipe 0


> I have an untested patch ready which should add support for implicit
> feedback, but I'm uncertain about the condition when to activate this
> mode.
>
>    

That sounds great. I'm looking forward to give it a try!

Thanks,

Felix
