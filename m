From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 2/3] ucm: docs: Fix doxygen formatting for UCM
	main page.
Date: Mon, 29 Jun 2015 16:25:58 +0100
Message-ID: <1435591559-6277-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435591559-6277-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3967C2614AF
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 17:26:13 +0200 (CEST)
In-Reply-To: <1435591559-6277-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Make sure group is defined and lists dipplayed correctly.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/use-case.h | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/use-case.h b/include/use-case.h
index c7789c0..9aac6e2 100644
--- a/include/use-case.h
+++ b/include/use-case.h
@@ -43,15 +43,13 @@ extern "C" {
 #endif
 
 /**
- *  \defgroup Use Case Interface
+ *  \defgroup ucm Use Case Interface
  *  The ALSA Use Case manager interface.
  *  See \ref Usecase page for more details.
  *  \{
  */
 
 /*! \page Usecase ALSA Use Case Interface
- * 
- * ALSA Use Case Interface
  *
  * The use case manager works by configuring the sound card ALSA kcontrols to
  * change the hardware digital and analog audio routing to match the requested
@@ -69,9 +67,9 @@ extern "C" {
  *
  * However there are times when a use case has to be modified at runtime. e.g.
  *
- *  o Incoming phone call when the device is playing music
- *  o Recording sections of a phone call
- *  o Playing tones during a call.
+ *  + Incoming phone call when the device is playing music
+ *  + Recording sections of a phone call
+ *  + Playing tones during a call.
  *
  * In order to allow asynchronous runtime use case adaptations, we have a third
  * optional modifier parameter that can be used to further configure
@@ -79,13 +77,13 @@ extern "C" {
  *
  * This interface allows clients to :-
  *
- *  o Query the supported use case verbs, devices and modifiers for the machine.
- *  o Set and Get use case verbs, devices and modifiers for the machine.
- *  o Get the ALSA PCM playback and capture device PCMs for use case verb,
+ *  + Query the supported use case verbs, devices and modifiers for the machine.
+ *  + Set and Get use case verbs, devices and modifiers for the machine.
+ *  + Get the ALSA PCM playback and capture device PCMs for use case verb,
  *     use case device and modifier.
- *  o Get the TQ parameter for each use case verb, use case device and
+ *  + Get the TQ parameter for each use case verb, use case device and
  *     modifier.
- *  o Get the ALSA master playback and capture volume/switch kcontrols
+ *  + Get the ALSA master playback and capture volume/switch kcontrols
  *     for each use case.
  */
 
-- 
2.1.4
