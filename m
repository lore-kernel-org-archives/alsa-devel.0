From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: More CS4630, secondary CODEC output.
Date: Fri, 2 Aug 2002 08:47:53 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020802154753.GA718@porky>
References: <3D41D4DC.60004@cucumelo.org> <s5h1y9ic3xs.wl@alsa2.suse.de> <3D4901D9.7040409@cucumelo.org> <s5hwuraalt8.wl@alsa2.suse.de> <s5hptx2agxp.wl@alsa2.suse.de> <3D4A1DDF.2090404@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gotnet.net (mail.gotnet.net [207.173.88.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA05744
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 17:56:21 +0200
Content-Disposition: inline
In-Reply-To: <3D4A1DDF.2090404@cucumelo.org>; from gorm@cucumelo.org on Thu, Aug 01, 2002 at 22:51:27 -0700
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2002.08.01 22:51 Benny Sjostrand wrote:
> On the "Turtle Beach Santa Cruz" now i know that GPIO7/GPIO8 on sec. 
> codec controls back speakers, that's not done yet,
> But I would like to know if current code at least detects the secondary 
> CODEC successfully. In theory it should.
[...]
> Turtle Beach Santa Cruz
> dsp: cs4630
> primary codec: cs4294
> secondary codec: cs4297A
> GPIO7/GPIO8 on secondary codec controls back speakers support


    Actually, the codecs are reversed. The CS4297A is the primary codec, 
and
the CS4294 is the secondary. And yes, your driver detects them both just
fine and I can manipulate both with alsamixer and confirm the changes to
the CS4294 with the changes in the "ac97#0-1regs" file in 
/proc/asound/card0.

-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
