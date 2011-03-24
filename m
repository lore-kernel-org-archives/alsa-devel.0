From: Chris Wilson <chris@qwirx.com>
Subject: Re: Loud pops from Intel HDA onboard sound,
 may damage speakers (fwd)
Date: Thu, 24 Mar 2011 22:41:47 +0000 (GMT)
Message-ID: <alpine.DEB.2.00.1103242239350.2342@chris-desktop.fen.aptivate.org>
References: <alpine.DEB.2.00.1103240135291.1780@chris-desktop.fen.aptivate.org>
	<20110324014350.GA8029@localhost>
	<alpine.DEB.2.00.1103240934470.1780@chris-desktop.fen.aptivate.org>
	<s5hhbasvnz9.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1103241205020.13384@top.qwarx.com>
	<s5hpqpgaff6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from top.qwarx.com (top.qwarx.com [80.248.178.170])
	by alsa0.perex.cz (Postfix) with ESMTP id BE97924142
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 23:41:57 +0100 (CET)
In-Reply-To: <s5hpqpgaff6.wl%tiwai@suse.de>
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
Cc: PeiSen Hou <pshou@realtek.com.tw>, alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>, dan.d.kogan@intel.com, andy.kopp@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Takashi and all,

On Thu, 24 Mar 2011, Takashi Iwai wrote:

>>> Does this happen with 2.6.38 kernel, too?
>>
>> I have not tried yet, do you have reason to think it may have changed 
>> since 2.6.32?
>
> Lots of changes since 2.6.32.  I won't be surprised if any of them hits.
>
>> Can I build just the sound driver without replacing the whole kernel?
>
> You can try alsa-driver tarball.

Unfortunately, I can confirm that stock 2.6.38 does NOT resolve the pops 
on suspend and resume.

I was able to build a driver from the alsa-driver tarball, but it refused 
to load on the Ubuntu 2.6.32 kernel due to unresolved symbols for reasons 
unknown.

Cheers, Chris.
-- 
_____ __     _
\  __/ / ,__(_)_  | Chris Wilson <chris+sig@qwirx.com> Cambs UK |
/ (_/ ,\/ _/ /_ \ | Security/C/C++/Java/Ruby/Perl/SQL Developer |
\__/_/_/_//_/___/ | We are GNU : free your mind & your software |
