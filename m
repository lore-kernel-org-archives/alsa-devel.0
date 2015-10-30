From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: firewire-digi00x: add another
	rawmidi character device for MIDI control ports
Date: Sat, 31 Oct 2015 02:43:13 +0900
Message-ID: <1446226996-2299-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD49260687
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 18:43:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Digi 002/003 family uses two ways of MIDI transmission; by isochronous
packet streaming and by asynchronous transmission. The former is for physical
MIDI ports and the latter is for physical controls on device surface.

Currently, all of these ports are handled by a set of operations in one ALSA
rawmidi character device, thus:

$ amidi -l
Dir Device    Name
IO  hw:1,0,0  Digi 002Rack control
IO  hw:1,0,1  Digi 002Rack MIDI 1
 O  hw:1,0,2  Digi 002Rack MIDI 2

Although, it's preferable to have two rawmidi character devices because these
transmission ways are completely different and it's better to assign each set
of operations.

This patchset adds another rawmidi character device to ALSA digi00x driver.
As a result, the driver register two rawmidi character device for each MIDI
ports:

$ amidi -l
Dir Device    Name
IO  hw:1,0,0  Digi 002Rack MIDI 1
 O  hw:1,0,1  Digi 002Rack MIDI 2
IO  hw:1,1,0  Digi 002Rack control

I'm sorry to post this patchset in this time, but next release is a first
version with digi00x driver and it better to includes this intrusive patchset
before releasing.

Takashi Sakamoto (3):
  ALSA: firewire-digi00x: rename identifiers of MIDI operation for
    physical ports
  ALSA: firewire-digi00x: add MIDI operations for MIDI control port
  ALSA: firewire-digi00x: add another rawmidi character device for
    MIDI control ports

 sound/firewire/digi00x/digi00x-midi.c | 197 ++++++++++++++++++++++------------
 1 file changed, 130 insertions(+), 67 deletions(-)

-- 
2.1.4
