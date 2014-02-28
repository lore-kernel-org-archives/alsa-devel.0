Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from cnbjrel01.sonyericsson.com (cnbjrel01.sonyericsson.com
 [219.141.167.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B1A26512B
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 09:15:29 +0100 (CET)
From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Date: Fri, 28 Feb 2014 16:15:23 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
Content-Language: en-US
MIME-Version: 1.0
Subject: [alsa-devel] change kmalloc into vmalloc for large memory
	allocations
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-msm@vger.kernel.org'" <linux-arm-msm@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>, "'balbi@ti.com'" <balbi@ti.com>, "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>, "'lrg@ti.com'" <lrg@ti.com>, "'broonie@opensource.wolfsonmicro.com'" <broonie@opensource.wolfsonmicro.com>, "'perex@perex.cz'" <perex@perex.cz>, "'tiwai@suse.de'" <tiwai@suse.de>, "'pablo@netfilter.org'" <pablo@netfilter.org>, "'kaber@trash.net'" <kaber@trash.net>, "'davem@davemloft.net'" <davem@davemloft.net>, "'rostedt@goodmis.org'" <rostedt@goodmis.org>, "'fweisbec@gmail.com'" <fweisbec@gmail.com>, "'mingo@redhat.com'" <mingo@redhat.com>, "'dmitry.torokhov@gmail.com'" <dmitry.torokhov@gmail.com>, "'rydberg@euromail.se'" <rydberg@euromail.se>, "'linux-usb@vger.kernel.org'" <linux-usb@vger.kernel.org>"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'netfilter-devel@vger.kernel.org'" <netfilter-devel@vger.kernel.org>, "'netfilter@vger.kernel.org'" <netfilter@vger.kernel.org>, "'coreteam@netfilter.org'" <coreteam@netfilter.org>, "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>"'linux-input@vger.kernel.org'" <linux-input@vger.kernel.org>
List-ID: <alsa-devel@alsa-project.org>

Hi 


I find there is some drivers use kmalloc to allocate large 
Memorys during module_init,  some can be changed to use vmalloc
To save some low mem, I add log in kernel to track ,
And list them here:

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/usb/gadget/f_mass_storage.c?h=master#n2724

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/sound/soc/soc-core.c?h=master#n3772

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_ftp.c?h=master#n603
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_h323_main.c?h=master#n1849
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_irc.c?h=master#n247
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/net/netfilter/nf_conntrack_sane.c?h=master#n195

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/drivers/input/evdev.c?h=master#n403


they allocate large memory from 10k~64K , 
this will use lots of low mem, instead if we use 
vmalloc for these drivers , it will be good for some devices
like smart phone, we often encounter some errors like kmalloc failed 
because there is not enough low mem , especially when the device has physical 
memory less than 1GB .


could this module change the memory allocation into vmalloc ?

I was thinking that if we can introduce a helper function in kmalloc.h like this :

Kmalloc(size, flags)
{
	If (size > PAGE_SIZE && flags&CAN_USE_VMALLOC_FLAG)
		return vmalloc(size);
	Else
		return real_kmalloc(size);
}

Kfree(ptr)
{
	If (is_vmalloc_addr(ptr))
		Vfree(ptr);
	Else
		Kfree(ptr);
}


But we need add some flags to ensure always use kmalloc for
Some special use (dma etc..)

How do you think of it ?

Thanks



_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
