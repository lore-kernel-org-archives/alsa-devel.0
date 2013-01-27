From: Emil Goode <emilgoode@gmail.com>
Subject: [PATCH 2/3] x86: KVM: Simplify function kvm_detect
Date: Sun, 27 Jan 2013 17:40:01 +0100
Message-ID: <1359304802-28240-2-git-send-email-emilgoode@gmail.com>
References: <1359304802-28240-1-git-send-email-emilgoode@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359304802-28240-1-git-send-email-emilgoode@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mtosatti@redhat.com, gleb@redhat.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, avi@redhat.com, mst@redhat.com, perex@perex.cz, tiwai@suse.de, crimsun@ubuntu.com, wfp5p@virginia.edu, peter.senna@gmail.com
Cc: x86@kernel.org, kvm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
List-Id: alsa-devel@alsa-project.org

The first patch in this series changed the kvm_para_available
function to return bool. We can now simplify the kvm_detect function
by directly returning the return value of kvm_para_available.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 arch/x86/kernel/kvm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 2b44ea5..3644908 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -497,9 +497,7 @@ void __init kvm_guest_init(void)
 
 static bool __init kvm_detect(void)
 {
-	if (!kvm_para_available())
-		return false;
-	return true;
+	return kvm_para_available();
 }
 
 const struct hypervisor_x86 x86_hyper_kvm __refconst = {
-- 
1.7.10.4
