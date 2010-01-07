From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH, beta] Echoaudio, add suspend/resume support
Date: Thu, 7 Jan 2010 23:44:37 +0100
Message-ID: <20100107234437.33f9a2ec@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-OUT05A.alice.it (smtp-OUT05A.alice.it [85.33.3.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 74F8A24335
	for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2010 23:45:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The following patched add suspend/resume support to all echoaudio drivers.
They seem to work fine, but more testing is needed. Some testing have been
performed on an IndigoIOx and a Layla3G (thanks to Mark Hills). The most
important part which has not been tested is rawmidi.

Is someone willing to try ?  The following patches are against
alsa-driver-1.0.22.1, but should be possible to apply them cleanly on other
versions as well because no changes have been done recently.


1/4 Add firmware cache #1:
	When CONFIG_PM is enabled the firmware cannot be released because
	the driver may need it again to resume the card.
	With this patch the firmware is passed as an index of the struct
	firmware card_fw[] in place of a pointer. That same index is then
	uses to locate the firmware in the firmware cache.

2/4 Add firmware cache #2:
	This patch changes get_firmware(), free_firmware() and adds
	free_firmware_cache(). The first two functions implement a very
	simple cache and the latter is used to actually release all the
	stored firmwares when the module is unloaded.
	When CONFIG_PM is not enabled those functions act as before and
	free_firmware_cache() is a nop.

3/4 Add suspend support:
	This patch adds snd_echo_suspend() and snd_echo_resume() callbacks
	and suspend/resume trigger event handlers.
	It also makes hardware initialization and mixer setup two clearly
	distinct stages, so they can be used also in the resume procedure
	without messing the settings up. As a bonus all init_hw() functions
	(one for each card) are a little shorter and cleaner.

4/4 patch the patch:
	Updates pci/echoaudio/echoaudio.patch


The patches are here, in the same order as above:

http://www.webalice.it/g_pochini/ead/fw_cache_1.patch
http://www.webalice.it/g_pochini/ead/fw_cache_2.patch
http://www.webalice.it/g_pochini/ead/pm_suspend_10.patch
http://www.webalice.it/g_pochini/ead/echoaudio.patch.patch

Or if you prefer a single patch (54KB):

http://www.webalice.it/g_pochini/ead/all_echoaudio_suspend.patch

Please test and report, especially the rawmidi part. TIA.


-- 
Giuliano.
