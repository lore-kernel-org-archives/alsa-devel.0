From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/3] hdspm - Series of small corrections
Date: Sun, 12 Jun 2011 17:26:16 +0200
Message-ID: <1307892379-31179-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Here's a series of small corrections to the hdspm driver. First patch
was tested by Joern Nettingsmeier, the remaining two by IOSONO-sound.com
together with me.


Cheers

Adrian Knoth (3):
  ALSA: hdspm - Fix locking in snd_hdspm_midi_input_read
  ALSA: hdspm - Fix jumping external wordclock frequency in AutoSync
    mode
  ALSA: hdspm - Add firmware revision ID for RME MADI PCI version

 sound/pci/rme9652/hdspm.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

-- 
1.7.5.4
