From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: 2.6.16-rc1-mm4: ALSA oops at remove_proc_entry
Date: Wed, 1 Feb 2006 04:47:21 +0300
Message-ID: <20060201014721.GA7720__37028.6332713023$1138759054$gmane$org@mipter.zuzino.mipt.ru>
References: <20060129144533.128af741.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.198])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B261C1F8
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2006 02:29:12 +0100 (MET)
Received: by uproxy.gmail.com with SMTP id m2so88816ugc
        for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2006 17:29:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My bisect script told me that

Sucker is git-alsa.patch
---------------------------------------------
EIP is at remove_proc_entry
Process rmmod

snd_info_unregister		[snd]
snd_pcm_oss_proc_done		[snd_pcm_oss]
snd_pcm_oss_unregister_minor	[snd_pcm_oss]
snd_pcm_notify			[snd_pcm]
sys_delete_module
do_munmap
syscall_call

.config
-------
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_RTCTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_INTEL8X0=m



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
