From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: More CS4630, secondary CODEC output.
Date: Fri, 02 Aug 2002 20:16:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4ACC6D.4060600@cucumelo.org>
References: <3D41D4DC.60004@cucumelo.org> <s5h1y9ic3xs.wl@alsa2.suse.de> <3D4901D9.7040409@cucumelo.org> <s5hwuraalt8.wl@alsa2.suse.de> <s5hptx2agxp.wl@alsa2.suse.de> <3D4A1DDF.2090404@cucumelo.org> <20020802154753.GA718@porky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cucumelo.org (as1-4-7.bn.g.bonet.se [194.236.61.89])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA08164
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 21:06:30 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>    Actually, the codecs are reversed. The CS4297A is the primary 
> codec, and
> the CS4294 is the secondary. And yes, your driver detects them both just
> fine and I can manipulate both with alsamixer and confirm the changes to
> the CS4294 with the changes in the "ac97#0-1regs" file in 
> /proc/asound/card0.
>
Hopefully then the only thing left is too activate the GPIO pins, i'll 
try to write
some code doing this, we will se if it works ...

/Benny





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
