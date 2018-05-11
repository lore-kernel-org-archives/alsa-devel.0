From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v4 0/4] ALSA: usb: UAC3 new features.
Date: Fri, 11 May 2018 16:25:33 +0100
Message-ID: <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E619267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 17:25:44 +0200 (CEST)
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>, ruslan.bilovol@gmail.com
List-Id: alsa-devel@alsa-project.org

v4 Updates:
 - Removes already applied patch from v2 of this patchset.
 - Adds small patch to parse Feature Unit number of channels.
 - Rebased onto latest linux-next tag as today.

Now that the UAC3 patch [1] has made it to linux-next I have some extra
features to make a UAC3 devices fully work in Linux. Including Jack 
insertion control that I have put on top of this other patch [2] for 
UAC2. Also adding support for the UAC3 Mixer Unit which is most likely
to appear in most headset type devices.

UAC3 devices also require to have a Basic Audio Device (BADD) in a separate 
config for which both Ruslan Bilovol and myself have submited different 
approaches[3][4]. After an ongoing discussion between Ruslan and myself
we have decided that the patch from Ruslan[3] implements a simpler and
yet more robust BADD driver.

All this features are tested with an actual UAC3 device that is still in
development. For this patch series, only the legacy config (#1. UAC1/UAC2)
and the UAC3 config have been tested. The BADD config will come in
a different patch from Ruslan.

[1]: https://patchwork.kernel.org/patch/10298179/
[2]: https://patchwork.kernel.org/patch/10305847/
[3]: https://patchwork.kernel.org/patch/10340851/
[4]: https://www.spinics.net/lists/alsa-devel/msg71617.html

Based on linux-next tag: next-20180510

Jorge Sanjuan (4):
  ALSA: usb-audio: UAC3. Add support for mixer unit.
  ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
  ALSA: usb-audio: UAC3 Add support for connector insertion.
  ALSA: usb-audio: UAC3: Parse Input Terminal number of channels.

 include/linux/usb/audio-v2.h   |   7 ++
 include/linux/usb/audio-v3.h   |  14 +++
 include/uapi/linux/usb/audio.h |  19 +++-
 sound/usb/mixer.c              | 200 ++++++++++++++++++++++++++++++++++++-----
 sound/usb/stream.c             |   9 +-
 5 files changed, 222 insertions(+), 27 deletions(-)

-- 
2.11.0
