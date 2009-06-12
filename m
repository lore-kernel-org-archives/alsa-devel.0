From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: no sound in ubuntu 8.10 on AD1986 sound card
Date: Fri, 12 Jun 2009 05:35:53 -0400
Message-ID: <604760770906120235q6813b68etf581338ac2833d75@mail.gmail.com>
References: <6208da1a0906100917y11b401d8y378af8d7d28e762d@mail.gmail.com>
	<604760770906120233x62aa85c4j542d7def459eae51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DE2C24627
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 11:35:57 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2044520bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2009 02:35:56 -0700 (PDT)
In-Reply-To: <604760770906120233x62aa85c4j542d7def459eae51@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sandip gangakhedkar <sandipfloyd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Your 'PCM' is muted - is that intentional? Also, unless you're explicitly
using digital out, you should mute 'IEC958'. Lastly, if you're using
headphones, unmute that element, too.

On Jun 10, 2009 12:18 PM, "sandip gangakhedkar" <sandipfloyd@gmail.com>
wrote:

Hi all,

I am facing a very perplexing issue with sound in Ubuntu 8.10 which I have
never encountered before with linux. I do not hear any sound from my
speakers. The sound card is AD 1986 (Analog Devices) and it worked
wonderfully without any hiccups before on 8.10 and other Ubuntu versions.

My alsa-info script is here:
http://www.alsa-project.org/db/?f=7f34b4e28d97178d7f709740f91ff66ea08a9468

I suspect pulseaudio is the culprit:
Output of : /var/log/syslog | grep pulseaudio is here:
http://paste.ubuntu.com/192629/

Running : speaker-test -c2 -D hw:0,0 -t wav -l1 gives no sound.

My motherboard is ASUS A8N-VM on a AMD 64 Athlon 3200 Desktop PC.The sound
card is detected so no problems there.

I have reinstalled ALSA, pulseaudio and all the related packages but to no
avail.

I am pretty sure this is not a problem of inadeuate support because sound
was working before without any issues.

Any ideas/suggestions on how to fix this problem will be greatly
appreciated. I am also raising an email bug report at alsa-devel so anyone
can canter around there and provide expert help :)

Thanks,

Sandip
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
