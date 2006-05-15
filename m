From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Date: Mon, 15 May 2006 10:04:29 -0700
Message-ID: <20060515100429.5069f6ca.akpm__16559.1641133235$1147713862$gmane$org@osdl.org>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605150940l647273f0jf4e1b9d5737bbd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 701AF234
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2006 19:07:47 +0200 (MEST)
In-Reply-To: <6bffcb0e0605150940l647273f0jf4e1b9d5737bbd2@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> Hi,
> 
> On 15/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc4/2.6.17-rc4-mm1/
> >
> > - This tree contains a large number of new bugs^H^H^H^Hpatches.
> [snip]
> >  git-alsa.patch
> 
> BUG: sleeping function called from invalid context at
> /usr/src/linux-mm/sound/core/info.c:117
> in_atomic():1, irqs_disabled():0
>  <c1003ef9> show_trace+0xd/0xf   <c100440c> dump_stack+0x17/0x19
>   <c10178ce> __might_sleep+0x93/0x9d   <f988eeb5> snd_iprintf+0x1b/0x84 [snd]
>   <f988d808> snd_card_module_info_read+0x34/0x4e [snd]   <f988f197>
> snd_info_entry_open+0x20f/0x2cc [snd]
>  <c1067a17> __dentry_open+0x133/0x260   <c1067bb7> nameidata_to_filp+0x1c/0x2e
>  <c1067bf7> do_filp_open+0x2e/0x35   <c1068bf2> do_sys_open+0x54/0xd7
>  <c1068ca1> sys_open+0x16/0x18   <c11dab67> sysenter_past_esp+0x54/0x75
> Non-volatile memory driver v1.2
> 
> Here is dmesg http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-dmesg
> Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc4-mm1/mm-config

heh, yes, Takashi baited his hook and pulled in a big one.

snd_card_module_info_read() calls snd_iprintf() under read_lock()..


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
