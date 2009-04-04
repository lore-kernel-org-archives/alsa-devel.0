From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: how to use mcbsp for i2s?
Date: Sat, 4 Apr 2009 17:39:37 +0300
Message-ID: <20090404173937.ba34d888.jhnikula@gmail.com>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
	<bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
	<bd7b27490904020320i714cd812i49bd834676ce4dee@mail.gmail.com>
	<20090402195653.0bcfb59e.jhnikula@gmail.com>
	<fb44c3530904021027r7a1387cag8507c4a1a88811ca@mail.gmail.com>
	<fb44c3530904030914w255d1502pec109d6c494b8f1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id E988A1037F8
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Apr 2009 16:39:41 +0200 (CEST)
Received: by ewy10 with SMTP id 10so1405084ewy.32
	for <alsa-devel@alsa-project.org>; Sat, 04 Apr 2009 07:39:41 -0700 (PDT)
In-Reply-To: <fb44c3530904030914w255d1502pec109d6c494b8f1b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Apr 2009 10:14:45 -0600
Ernesto Torres <skullmate@gmail.com> wrote:

> Im getting this output from muxing:
> 
> MUX: setup AF6_3430_MCBSP3_DX (0xd800216c): 0x0004 ->
> 0x0000
> MUX: setup AE6_3430_MCBSP3_DR (0xd800216e): 0x0004 ->
> 0x0000
> MUX: setup AF5_3430_MCBSP3_CLKX (0xd8002170): 0x0004 ->
> 0x0000
> MUX: setup AE5_3430_MCBSP3_FSX (0xd8002172): 0x0004 -> 0x0000
> 
> Is this correct?
> 
It look likes since debug output says that the muxmode for those pins
are changed from mode 4 (gpio in this case) to 0 (McBSP3 pins in
this case).

Actually all of those pins are configured as outputs in muxing module
point of view but IRCC actually McBSP HW will set the direction
depending on its configuration. At least I didn't notice any
difference what was the muxing direction when I was playing with them
shortly some time ago.

-- 
Jarkko
