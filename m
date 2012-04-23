From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 0/3] Alsa: USB: Improve M-Audio Fast Track
	Ultra mixer
Date: Mon, 23 Apr 2012 11:16:05 +0200
Message-ID: <1335172568-13502-1-git-send-email-linuxaudio@showlabor.de>
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

This series of patches improves the mixer for Fast Track Ultra (8R)
devices by

	* adding TLV to existing controls
	* adding new controls for the effect section.

It unifies the control creation for FTU and Ebox-44 devices.

Mark, could you please look at mixer_quirks.c. Do we really need the range settings 
in snd_create_std_mono_ctl()? BTW, you might like to add some TLV callback to the
Ebox-44 controls as well.

Regards,

Felix

Felix Homann (3):
  Unify M-Audio Fast Track Ultra and Ebox-44 mixer quirks.
  Add TLV to M-Audio volume controls
  M-Audio FTU: Add effect controls

 sound/usb/mixer.c        |   23 +++
 sound/usb/mixer_quirks.c |  493 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 450 insertions(+), 66 deletions(-)

-- 
1.7.5.4
