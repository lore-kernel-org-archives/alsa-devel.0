From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: gitcompile fail
Date: Mon, 9 Jan 2017 03:42:16 +0900
Message-ID: <ec812499-d205-2a92-5a18-b73f06f971b8@sakamocchi.jp>
References: <bf26b6bb-6447-8ec9-bacf-9954a4b924e5@nmmu.ac.za>
 <a5d5a532-c63c-f9a2-5bd5-e9cefbb3d056@nmmu.ac.za>
 <12c78c97-64ee-60ab-d4f3-3523b4d33e31@nmmu.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 155B326669C
 for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2017 19:42:22 +0100 (CET)
In-Reply-To: <12c78c97-64ee-60ab-d4f3-3523b4d33e31@nmmu.ac.za>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brand <mark.brand@nmmu.ac.za>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 9 2017 00:19, Mark Brand wrote:
> I now enable my new module for compilation by make menuconfig in the
> source tree root.  This adds the line CONFIG_SND_MQ8PORTSE=m to .config
> in that folder.

When working with out-of-tree sources, no need to care of .config and 
Kconfig on the tree, because built-tree already includes relevant 
information about it. In your case, 
'/usr/src/linux-headers-4.4.0-57-lowlatency/' is the built-tree, 
including enough stuffs for module building.

So what you need is to give CONFIG_SND_MQ8PORTSE=m to Make environment 
of the built-tree. Let's try:

$ CONFIG_SND_MQ8PORTSE=m make -C /lib/modules/$(uname -r)/build M=$(pwd) 
snd-mq8portse.ko

Kernel build system, called Kbuild, is enough complicated to me. So I 
cannot explain about the overall. Documentation in 
'Documentation/kbuild/kbuild.txt'[0] and 
'Documentation/kbuild/modules.txt'[1] will help you for more detail and 
good entry points into kernel world.

[0] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kbuild.txt
[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/modules.txt


Regards

Takashi Sakamoto
