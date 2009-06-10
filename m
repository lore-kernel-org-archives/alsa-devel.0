From: sandip gangakhedkar <sandipfloyd@gmail.com>
Subject: no sound in ubuntu 8.10 on AD1986 sound card
Date: Wed, 10 Jun 2009 21:47:34 +0530
Message-ID: <6208da1a0906100917y11b401d8y378af8d7d28e762d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 952CE103817
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 18:17:55 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so424760ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 09:17:54 -0700 (PDT)
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
