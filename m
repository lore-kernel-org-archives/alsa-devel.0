From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 0/5] Alsa: snd-usb: Improve M-Audio Fast Track
	Ultra mixer - v3
Date: Mon, 23 Apr 2012 20:24:22 +0200
Message-ID: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

This is the third try on a series of patches that improves the mixer
for Fast Track Ultra (8R) devices by

      * adding TLV to existing controls
      * adding new controls for the effect section.

In addition, it unifies the control creation for FTU and Ebox-44 devices.

Mark, could you please look at mixer_quirks.c. Do we really need the range settings
in snd_create_std_mono_ctl()? BTW, you might like to add some TLV callback to the
Ebox-44 controls as well.

I hope I really sorted Takashis issues out this time.

Regards,

Felix

Felix Homann (5):
  Unify M-Audio Fast Track Ultra and Ebox-44 mixer quirks.
  Rename and export mixer_vol_tlv
  Add TLV to M-Audio Fast Track Ultra controls
  Rename Fast Track Ultra mixer quirk functions
  M-Audio Fast Track Ultra: Add effect controls

 sound/usb/mixer.c        |   22 ++-
 sound/usb/mixer.h        |    3 +
 sound/usb/mixer_quirks.c |  471 +++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 428 insertions(+), 68 deletions(-)

-- 
1.7.5.4
