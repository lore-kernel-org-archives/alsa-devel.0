From: andoru <andoru.blah@gmail.com>
Subject: Re:
	=?utf-8?q?Invalid_PCM_pointer_with_CMI8738_and_pcm?=
	=?utf-8?q?=2Ec_buffer=09underuns?=
Date: Sat, 5 Apr 2014 18:29:25 +0000 (UTC)
Message-ID: <loom.20140405T202230-761@post.gmane.org>
References: <loom.20140404T175952-945@post.gmane.org>
 <CAN8cciaF9ZbyOoz4A3f3GyTkmzzbvskFtqqKUv2rjgVAXbjCcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C4A526513A
 for <alsa-devel@alsa-project.org>; Sat,  5 Apr 2014 20:29:38 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WWVLV-0006DE-GR
 for alsa-devel@alsa-project.org; Sat, 05 Apr 2014 20:29:37 +0200
Received: from cl-86-125-143-65.cablelink.mures.rdsnet.ro ([86.125.143.65])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 05 Apr 2014 20:29:37 +0200
Received: from andoru.blah by cl-86-125-143-65.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 05 Apr 2014 20:29:37 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Raymond Yau <superquad.vortex2 <at> gmail.com> writes:
> 
> does the hardware really support (16384/1764)
> 9.27 periods?
> does the error occur in the last period ?

I have no idea, how do I find out? What last period?

> Do the clippping occur with oss emulation which use 
> power of 2 period size
> 
> or
> 
> add
> 
> snd_pcm_hw_constraint_integer(runtime,
> SNDRV_PCM_HW_PARAM_PERIODS)

Add that line where? I'm not sure if I'm using oss emulation.
_______________________________________________________________________
