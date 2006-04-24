From: Andrew Morton <akpm@osdl.org>
Subject: Re: ALSA regression: oops on shutdown
Date: Sun, 23 Apr 2006 18:57:21 -0700
Message-ID: <20060423185721.39ff4207.akpm@osdl.org>
References: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5EE8217E
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 03:58:34 +0200 (MEST)
In-Reply-To: <20060423235730.GA7934@mipter.zuzino.mipt.ru>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> ALSA oops I reported against 2.6.16-rc1-mm4 [1] sneaked into mainline
>  after release.

One wonders why the ALSA developers merged up which was known to cause
oopses.


>  ----------------------------
>  EIP is at remove_proc_entry
>  Process rmmod
> 
>  snd_info_unregister             [snd]
>  snd_pcm_oss_proc_done           [snd_pcm_oss]
>  snd_pcm_oss_unregister_minor    [snd_pcm_oss]
>  snd_pcm_notify                  [snd_pcm]
>  sys_delete_module
>  do_munmap
>  syscall_call
>  ----------------------------
>  Fine-grained bisecting points to commit 21a3479a0b606d36fe24093f70a1c27328cec286
> 
>      [ALSA] PCM midlevel & PCM OSS - make procfs & OSS plugin code optional
> 
>  .config is
> 
>  	CONFIG_SOUND=m
>  	CONFIG_SND=m
>  	CONFIG_SND_TIMER=m
>  	CONFIG_SND_PCM=m
>  	CONFIG_SND_OSSEMUL=y
>  	CONFIG_SND_MIXER_OSS=m
>  	CONFIG_SND_PCM_OSS=m
>  	CONFIG_SND_AC97_CODEC=m
>  	CONFIG_SND_AC97_BUS=m
>  	CONFIG_SND_INTEL8X0=m

Cannot reproduce it.  Please send full .config and precise means of
reproduction, thanks.



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
