From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Sat, 2 Oct 2010 08:51:53 +0800
Message-ID: <AANLkTimvVfeJuHoostHccffcFewdVXQM-wQFTBfLPa6c@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de> <4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<s5hmxs0h437.wl%tiwai@suse.de> <4C809DB3.9090201@canonical.com>
	<alpine.LNX.2.00.1009030905210.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C7CA10382E
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 02:51:53 +0200 (CEST)
Received: by eye27 with SMTP id 27so1477920eye.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 17:51:53 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1009030905210.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/3 Jaroslav Kysela <perex@perex.cz>

> On Fri, 3 Sep 2010, David Henningsson wrote:
>
> > What would be really helpful would be if snd_mixer_open() took an
> > optional pcm handle, and then only returned the mixer controls that
> > affects the signal path of that pcm.
>
> This will be solved by another mechanism like ucm (use case manager). The
> idea is to return the PCM handle and associated mixer controls (master +
> pcm) for specified use case (like hdmi output etc.).
>
>                                        Jaroslav
>
>
How about those [Volume Knob Widget] , can the driver read back the step or
dB of the volume knob from the codec ?


Node 0x24 [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=0, val=127
  Connection: 4
     0x02 0x03 0x04 0x05
