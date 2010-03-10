From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Wed, 10 Mar 2010 20:54:56 +0800
Message-ID: <20100310125456.GA18509@localhost>
References: <s5htyswpb18.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD557@HKMAIL01.nvidia.com>
	<s5hvddcnlr6.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD558@HKMAIL01.nvidia.com>
	<a3ef07921003071121r24979a0breac27e3b0475bbcb@mail.gmail.com>
	<6B4D417B830BC44B8026029FD256F7F1C16B1AD562@HKMAIL01.nvidia.com>
	<20100308044614.GA29026@localhost>
	<a3ef07921003092142g23b93903v2b4af9c6b691bea0@mail.gmail.com>
	<alpine.LNX.2.00.1003100856420.4672@eeebox2.perex-int.cz>
	<a3ef07921003100005k6c7da149k99069cc13b3c8183@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F16D1038F8
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:55:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a3ef07921003100005k6c7da149k99069cc13b3c8183@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: Wei Ni <wni@nvidia.com>, alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <jkysela@redhat.com>, akpm <akpm@linux-foundation.org>, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

> > Could you do strace for ALSA ioctls? At least having the error code might
> > help to identify this issue.
> 
> I don't know how but I'm willing to try if you want to tell me how to
> do it.  Please keep in mind, I'm just an end-user -- not a developer
> or even c coder.  The most I've done is run xine in gdb to help supply
> bug info to those devs.

strace -o alsa-strace  speaker-test -Dhw:0,3 -t wav -c2 -l1                

Or 

strace -o alsa-strace  mplayer -ao alsa:device=hw=0.3 XXXXXXXX.mp3


Do you see error messages when playing via other audio devices, eg.

        mplayer -ao alsa:device=hw=0.0 XXXXXXXX.mp3

?

Thanks,
Fengguang
