From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem adding support for digital mixer in codec
Date: Thu, 25 Mar 2010 12:53:38 +0800
Message-ID: <4f3252891003242153y788a583bs9f6045967f957cc7@mail.gmail.com>
References: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f173.google.com (mail-pz0-f173.google.com
	[209.85.222.173])
	by alsa0.perex.cz (Postfix) with ESMTP id BF8C71038A5
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 05:53:39 +0100 (CET)
Received: by pzk3 with SMTP id 3so1978214pzk.24
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 21:53:38 -0700 (PDT)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B904BD8A0@dlee01.ent.ti.com>
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

2010/3/25 Candelaria Villarreal, Jorge <jorge.candelaria@ti.com>

> Hi,
>
> I am trying to add support for a digital mixer. The digital mixer is
> connected like the following example:
>
>
> Path 1 -------\
> Path 2 --------\
>                    MIXER ------> DAC----> ...
> Path 3 --------/
> Path 4 -------/
>
>
>
> However, I think ALSA does not support this configuration, as the DAC
> should be the first element in a route. I tried adding the DAC to the
> route first, and connected its output to the mixer inputs, like this:
>
>          {"Mixer", "Multimedia Ext Switch", "HSDAC Left"},
>        {"Mixer", "Multimedia Ext Switch", "HSDAC Right"},
>
>        {"Mixer", "Voice Switch", "HSDAC Left"},
>        {"Mixer", "Voice Switch", "HSDAC Right"},
>
>        {"Mixer", "Multimedia Uplink Switch", "HSDAC Left"},
>        {"Mixer", "Multimedia Uplink Switch", "HSDAC Right"},
>
>        {"Mixer", "Multimedia Switch", "HSDAC Left"},
>        {"Mixer", "Multimedia Switch", "HSDAC Right"},
>
> But this does not seem to work. Can anyone give me some tips? Any comment
> would be appreciated.
>
> Thanks,
> Jorge
>


Does your DSP support hardware mixing ?
