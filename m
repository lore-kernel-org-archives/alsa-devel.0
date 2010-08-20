From: Stephen Warren <swarren@nvidia.com>
Subject: Re: aplay -l  vs.  aplay -L: Missing PCMs?
Date: Fri, 20 Aug 2010 10:08:45 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE376668@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF02FE376614@HQMAIL01.nvidia.com>
	<alpine.LNX.2.00.1008200802560.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id AB64524348
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 19:08:53 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1008200802560.10278@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@perex.cz>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Thu, 19 Aug 2010, Stephen Warren wrote:
> 
> > The Azalia controller on NVIDIA GPUs gives 4 ALSA hw devices:
> >
> > (on card 1):
> >
> > [swarren@swarren-lx2 ~]$ sudo aplay -l
> > << includes hw=1,3 hw=1,7 hw=1,8 hw=1,9 >>
> > ... all of which appear to work OK.
> >
> > However, the list of available "PCMs" from aplay -L doesn't expose them all:
> >
> > [swarren@swarren-lx2 ~]$ sudo aplay -L
> > <<card 0 "Nvidia" elided>>
> > hdmi:CARD=NVidia_1
> >    HDA NVidia, NVIDIA HDMI
> >    HDMI Audio Output
> >
> > Instead, I imagined that I'd see 4 PCMs listed by "aplay -L"; one for each
> > converter. Is this an incorrect assumption? How would I make that happen?
> 
> There is a bug in alsa-lib to namehint.c. The code assumes that hw device
> number is similar to logical device numbers which is not true in case of
> your HDMI devices:
> 
> 3, 7, 8, 9
> 
> The fallback code is used and only first logical device 0 is created.
> 
> Could you test this patch?
> 
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=97d25c0766405453d3c298bd51dd4916121a4f6a

I tested that, and unfortunately it doesn't seem to work; I get the exact same
aplay -L output.

I debugged this a little, and see that add_card() is calculating the correct
max_devices value for card=1 str=hdmi. However, in the loop that right after
that calls try_config, when device=0, it returns 0, but when device=1, it
returns -2 (-ENOENT). This happens inside try_config where it calls
snd_config_search_definition (line 244 in latest git). At that point, buf is:

hdmi:CARD=NVidia_1,DEV=1

... which seems reasonable.

I'm a little confused about the device numbering though: The max_devices
value is counting values "3, 7, 8, 9" and hence gets 9. However, the loop that
calls try_config loops 0..max_devices-1, but bails out as soon as any error is
found, thus disallowing "holes" in the numbering. That implies that "device" in
that loop is a different numbering space? After I noticed that, I hacked that
loop to continue instead of break on errors, and also removed the "err >= 0"
condition from the loop, expecting that when device==3/7/8/9, try_config might
work. In fact, 0 still works (of course) and 1..8 all fail with err=-2, so I
assume at the same place in try_config.

-- 
nvpublic
