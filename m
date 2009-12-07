From: mark gross <mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH]PM_QOS-to-use-handle-based-requests-cpuidle-update 2/5
Date: Mon, 7 Dec 2009 09:06:16 -0800
Message-ID: <20091207170616.GC5463@linux.intel.com>
Reply-To: mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, aili-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, bruce.w.allan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
List-Id: alsa-devel@alsa-project.org



Signed-off-by: mark gross <mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/processor_idle.c      |    2 +-
 drivers/cpuidle/governors/ladder.c |    2 +-
 drivers/cpuidle/governors/menu.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index bbd066e..1f524a2 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -696,7 +696,7 @@ static int acpi_processor_power_seq_show(struct seq_file *seq, void *offset)
 		   "max_cstate:              C%d\n"
 		   "maximum allowed latency: %d usec\n",
 		   pr->power.state ? pr->power.state - pr->power.states : 0,
-		   max_cstate, pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY));
+		   max_cstate, pm_qos_request(PM_QOS_CPU_DMA_LATENCY));
 
 	seq_puts(seq, "states:\n");
 
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index a4bec3f..5f93084 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -67,7 +67,7 @@ static int ladder_select_state(struct cpuidle_device *dev)
 	struct ladder_device *ldev = &__get_cpu_var(ladder_devices);
 	struct ladder_device_state *last_state;
 	int last_residency, last_idx = ldev->last_state_idx;
-	int latency_req = pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
+	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 
 	if (unlikely(!ldev))
 		return 0;
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 6810443..f75aec5 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -176,7 +176,7 @@ static void menu_update(struct cpuidle_device *dev);
 static int menu_select(struct cpuidle_device *dev)
 {
 	struct menu_device *data = &__get_cpu_var(menu_devices);
-	int latency_req = pm_qos_requirement(PM_QOS_CPU_DMA_LATENCY);
+	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
 	int multiplier;
 
-- 
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
