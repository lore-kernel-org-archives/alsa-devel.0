From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] ALSA: intel8x0: Check return value
	before assigning
Date: Sun, 27 Jan 2013 08:40:36 -0800
Message-ID: <868012ba-3527-4bcb-ba1b-f976024c221b@email.android.com>
References: <1359304802-28240-1-git-send-email-emilgoode@gmail.com>
 <1359304802-28240-3-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F770264FEF
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2013 17:40:49 +0100 (CET)
In-Reply-To: <1359304802-28240-3-git-send-email-emilgoode@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Emil Goode <emilgoode@gmail.com>, mtosatti@redhat.com, gleb@redhat.com, tglx@linutronix.de, mingo@redhat.com, avi@redhat.com, mst@redhat.com, perex@perex.cz, tiwai@suse.de, crimsun@ubuntu.com, wfp5p@virginia.edu, peter.senna@gmail.com
Cc: alsa-devel@alsa-project.org, x86@kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Wtf?
 
This patch seems semibogus at best and the description is even more ridiculous...

Emil Goode <emilgoode@gmail.com> wrote:

>The first patch in this series changes the return type of function
>kvm_para_available to bool. In the function snd_intel8x0_inside_vm
>we now need to check it's return value before assigning a value to
>the result variable.
>
>Signed-off-by: Emil Goode <emilgoode@gmail.com>
>---
> sound/pci/intel8x0.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
>index 3b9be75..fa9337e 100644
>--- a/sound/pci/intel8x0.c
>+++ b/sound/pci/intel8x0.c
>@@ -2982,7 +2982,7 @@ static int snd_intel8x0_inside_vm(struct pci_dev
>*pci)
> 	}
> 
> 	/* detect KVM and Parallels virtual environments */
>-	result = kvm_para_available();
>+	result = kvm_para_available() ? 1 : 0;
> #ifdef X86_FEATURE_HYPERVISOR
> 	result = result || boot_cpu_has(X86_FEATURE_HYPERVISOR);
> #endif

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
