From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH RFC 0/4] Driver for RME MADI FX
Date: Fri,  1 Feb 2013 13:48:37 +0100
Message-ID: <1359722921-18769-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

I've been developing an out-of-tree driver for the RME MADI FX. History
is available at

   https://github.com/adiknoth/madifx

but doesn't follow any kernel convention regarding commit isolation, it
was basically a backup/scratchpad during development.

I don't have too much feedback, yet, but I guess it makes sense to
mainline it earlier than later, increase the driver's exposure and fix
any problems when the card is in more widespread use.

Note that this patch series is essentially RFC right now to gather
developer feedback.



Cheers

Adrian Knoth (4):
  ALSA: madifx - Makefile entries for RME MADI FX
  ALSA: Add RME MADI FX Kconfig entries
  ALSA: madifx - Expose preliminary userspace interface
  ALSA: madifx - Add support for RME MADI FX

 include/uapi/sound/madifx.h |  173 ++
 sound/pci/Kconfig           |   21 +
 sound/pci/rme9652/Makefile  |    2 +
 sound/pci/rme9652/madifx.c  | 3986 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 4182 insertions(+)
 create mode 100644 include/uapi/sound/madifx.h
 create mode 100644 sound/pci/rme9652/madifx.c

-- 
1.7.10.4
