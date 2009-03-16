From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: Re: My PC has 6GB memory but the limitation of the
 alsa-driver is 4GB.
Date: Mon, 16 Mar 2009 18:53:02 +0900
Message-ID: <1237197183.3501.64.camel@localhost.localdomain>
References: <1237056610.21086.72.camel@localhost.localdomain>
	<fd3eb9bf0903141235v1878ae03h8e51b8bcebb4c87d@mail.gmail.com>
	<1237061065.2581.3.camel@localhost.localdomain>
	<1237093356.3501.45.camel@localhost.localdomain>
	<s5hocw2rl9y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id DB3FC103812
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 10:53:08 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id c5so2543981rvf.32
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 02:53:07 -0700 (PDT)
In-Reply-To: <s5hocw2rl9y.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at 08:15 +0100 , 2009-03-16 (Mon)
> Hmm, then it's a bug of AMD/ATI controller chip. 
> 
> The problem is however likely only about CORB/RIRB addresses, and not
> about the sample buffers.  So setting 32bit there couldn't be the
> "right" fix.

Yeah, he said so, too. I mistook.

> How about the patch below?

I tried but it says

----
[emmanuel@star1 alsa-driver-1.0.19]$ patch -p1 <
hda_intel_Takashi_Iwai_0903161.diff
patching file sound/pci/hda/hda_intel.c
Hunk #1 FAILED at 2136.
Hunk #2 FAILED at 2218.
Hunk #3 FAILED at 2319.
3 out of 3 hunks FAILED -- saving rejects to file
sound/pci/hda/hda_intel.c.rej
----

Which version of the source shall I patch ? svn ?

-- 
Emmanuel Chanel <emmanuelchanel@gmail.com>
