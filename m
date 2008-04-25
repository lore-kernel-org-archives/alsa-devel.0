From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Re: Lenovo 3000 N100 ALC861-VD quirk
Date: Fri, 25 Apr 2008 02:25:47 -0500
Message-ID: <4811877B.9070609@gmail.com>
References: <481175CD.7000500@gmail.com>	<s5hej8u4f8b.wl%tiwai@suse.de>	<48118037.4090007@gmail.com>
	<s5habji4du3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AC17103834
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 09:26:36 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id w49so4068299pyg.36
	for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2008 00:26:35 -0700 (PDT)
In-Reply-To: <s5habji4du3.wl%tiwai@suse.de>
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


>> Just downloaded the lastest HG tarball from:
>> ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver
>> and patch_realtek.c, line #12684 still looks wrong, at least for me.
>>     
>
> It is correct.  The model lenovo is exactly for Lenovo devices.
> So, the right thing is to fix model lenovo properly instead of
> assigining a wrong model.
>
>   
>> I'll get the latest ALSA from HG installed on this machine (Ubuntu 8.04) 
>> and get back to you soon.
>>     
>
> That'll be helpful.  Thanks.
>
>
> Takashi
>
>   
Installed driver tarball hg20080425.
(did not update alsa-libs or alsa-oss)
Removed all module parameters and rebooted.
Module snd-hda-intel loaded fine; yet no sound.
Rebooted with model=3stack and sound works as described before

II can run more tests tomorrow.

Thanks again
