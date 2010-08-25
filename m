From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Loopback device conf/alias
Date: Wed, 25 Aug 2010 08:53:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008250845380.10278@eeebox2.perex-int.cz>
References: <AANLkTimpA7QjU0w+EO0Ky_k-zZpB4Y4h2hGHu7mZn=bL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id F0BAA10380B
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 08:53:20 +0200 (CEST)
In-Reply-To: <AANLkTimpA7QjU0w+EO0Ky_k-zZpB4Y4h2hGHu7mZn=bL@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 24 Aug 2010, pl bossart wrote:

> I played with the snd_aloop module that Jaroslav added a couple of
> days ago. It just does what I wanted and seems to work ok :-) Thanks
> for this patch!
>
> I would like however to expose this output as a PulseAudio profile.
> Using a string such as hw:%f conflicts with other analog output

Use 'hw:Loopback' device or assign any other car ID string as the module 
parameters (id=<your_string>) or you may change the card ID string at
runtime using 'echo <your_string> > /sys/class/sound/card1/id', replace 
card1 with the loopback card index (this way may be used in udev scripts 
where you can check the module name (snd_aloop) as well).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
