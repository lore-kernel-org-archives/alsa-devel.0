From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6 patch] ALSA PCI drivers: misc cleanups
Date: Sun, 21 Nov 2004 20:57:12 -0500
Message-ID: <1101088632.5119.2.camel__45059.6982300796$1101090013$gmane$org@krustophenia.net>
References: <20041121235855.GI13254@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 24FC428A
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2004 02:57:14 +0100 (MET)
In-Reply-To: <20041121235855.GI13254@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-11-22 at 00:58 +0100, Adrian Bunk wrote:
>   - emu10k1/io.c: snd_emu10k1_voice_set_loop_stop

Please do not remove this function.  I am working on an enhancement to
the emu10k1 driver that uses it.

Thanks,

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
