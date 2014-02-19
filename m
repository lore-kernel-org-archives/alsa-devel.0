From: "H. Peter Anvin" <hpa@zytor.com>
Subject: snd_intel8x0_inside_vm()
Date: Tue, 18 Feb 2014 19:48:11 -0800
Message-ID: <5304297B.8050201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EAF92652AA
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 04:48:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Konstantin Ozerkov <kozerkov@parallels.com>, "Denis V. Lunev" <den@openvz.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just stumbled upon the function snd_intel8x0_inside_vm(), and quite
frankly the code seems bizarre:

        /* detect KVM and Parallels virtual environments */
        result = kvm_para_available();
#ifdef X86_FEATURE_HYPERVISOR
        result = result || boot_cpu_has(X86_FEATURE_HYPERVISOR);
#endif
        if (!result)
                goto fini;

Why don't we simply rely on the PCI SSIDs?

	-hpa
