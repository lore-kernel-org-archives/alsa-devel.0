From: linux@audioscience.com
Subject: [PATCH 6/6] Remove unneeded ;
Date: Tue, 06 Jul 2010 08:37:11 +1200
Message-ID: <1278362231-10160-7-git-send-email-linux@audioscience.com>
References: <1278362231-10160-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1278362231-10160-1-git-send-email-linux@audioscience.com>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpidebug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pci/asihpi/hpidebug.c b/pci/asihpi/hpidebug.c
index 4cd85a4..949836e 100644
--- a/pci/asihpi/hpidebug.c
+++ b/pci/asihpi/hpidebug.c
@@ -111,7 +111,7 @@ make_treenode_from_array(hpi_control_type_strings, HPI_CONTROL_TYPE_STRINGS)
   &hpi_profile_strings,\
   &hpi_control_strings, \
   &hpi_asyncevent_strings \
-};
+}
 	make_treenode_from_array(hpi_function_strings, HPI_FUNCTION_STRINGS)
 
 	compile_time_assert(HPI_OBJ_MAXINDEX == 14, obj_list_doesnt_match);
-- 
1.7.0.4
