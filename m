From: Konstantin Ozerkov <kozerkov@parallels.com>
Subject: [PATCH 3/3] alsa-driver: Fix build intel8x0
Date: Wed, 9 Nov 2011 19:28:56 +0400
Message-ID: <1320852536-11786-4-git-send-email-kozerkov@parallels.com>
References: <1320852536-11786-1-git-send-email-kozerkov@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1320852536-11786-1-git-send-email-kozerkov@parallels.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: "Denis V. Lunev" <den@openvz.org>, alsa-devel@alsa-project.org, Konstantin Ozerkov <kozerkov@parallels.com>
List-Id: alsa-devel@alsa-project.org

Fix build alsa-driver with recent changes in intel8x0 (improved
virtualization detection).

"#ifdef X86_FEATURE_HYPERVISOR" check now placed in main code, no
additional patching required.

Signed-off-by: Konstantin Ozerkov <kozerkov@parallels.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>

diff --git a/pci/intel8x0.patch b/pci/intel8x0.patch
index 3b4b16f..6b3ce6c 100644
--- a/pci/intel8x0.patch
+++ b/pci/intel8x0.patch
@@ -43,17 +43,6 @@
  }
  #else
  #define fill_nocache(buf, size, nocache) do { ; } while (0)
-@@ -3247,8 +3258,10 @@
- 		/* detect KVM and Parallels virtual environments */
- 		inside_vm = kvm_para_available();
- #if defined(__i386__) || defined(__x86_64__)
-+#ifdef X86_FEATURE_HYPERVISOR
- 		inside_vm = inside_vm || boot_cpu_has(X86_FEATURE_HYPERVISOR);
- #endif
-+#endif
- 	}
- 
- 	if ((err = snd_intel8x0_create(card, pci, pci_id->driver_data,
 @@ -3320,3 +3333,5 @@
  
  module_init(alsa_card_intel8x0_init)
-- 
1.7.1
