From: Martin <mwolf@adiumentum.com>
Subject: Re: problem with bisecting a bug in the alsa driver
Date: Sun, 29 Aug 2010 19:59:05 +0200
Message-ID: <4C7A9FE9.5090500@adiumentum.com>
References: <4C7A8375.3000009@adiumentum.com>	<alpine.LNX.2.00.1008291805250.10278@eeebox2.perex-int.cz>	<4C7A9067.8090809@adiumentum.com>
	<alpine.LNX.2.00.1008291926590.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adiumentum.com (adiumentum.com [83.142.83.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 4966C1037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 19:59:06 +0200 (CEST)
Received: from [192.168.2.26] (p54A87988.dip.t-dialin.net [84.168.121.136])
	by adiumentum.com (Postfix) with ESMTPSA id 238C64400A0
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 19:59:06 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1008291926590.10278@eeebox2.perex-int.cz>
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

i also tried with

  bdl_pos_adj=256

the "error" in the last line went away but the crackling is still there

Am 29.08.2010 19:28, schrieb Jaroslav Kysela:
> On Sun, 29 Aug 2010, Martin wrote:
>
>    
>> hi,
>>
>> thanks for the quick help.
>> here is the diff.txt
>>      
> I would try to play with these two module parameters:
>
>           bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
>           enable_msi : -1
>
> Try to set 'enable_msi=0' and 'bdl_pos_adj=16' for the snd-hda-intel
> module.
>
>   						Jaroslav
>
> -----
> Jaroslav Kysela<perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>    
