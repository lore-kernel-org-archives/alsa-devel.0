From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/4] firewire-lib: add payload callback function for each
	driver
Date: Wed, 17 Jul 2013 20:50:44 +0900
Message-ID: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: robert.chamier@googlemail.com, damien@zamaudio.com, linux1394-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,
(CCed Rober von Chamier and Damien Zammit, they work for Dice and 003Rack driver)

Would you please review my patches and comment?

Currently snd-firewire-lib handles the contents of data block for AMDTP packet
in itself.

But to implement drivers for Fireworks(Echo Audio)/BeBoB(BridgeCo), there is an
inconvinience. Fireworks don't use AM824 label for PCM data. BeBoB needs to remap
PCM and MIDI channels depending on devices.

And Dice(TC Applied Technologies) - I think you understand this than me - needs
the mode called as "dual wire". In this mode, the sampling rate is a half of
requested one and each data block includes the data as twice as usual sampling
rate. The each data block handle two PCM frames, usually it's one.

Your snd-firewire-lib in alsa-kprivate.git repository manages to solve these
issue. But it has restriction about the PCM format (S32 only) and for me it
seems to be hard to maintain.

Additionally to implement full duplex with synchronization, I need to restart
streams for MIDI. Then current amdtp_out_stream_set_pcm_format() is not
convinient. I want to add condition for PCM format into each drivers.

Furthermore, 003Rack(Digidesign) - I don't work for this - has more issue. The
differences related to payload are:
 - the value of syt field in AMDTP packet is always zero
 - The data in each channel is encoded by its own way
The driver needs to refer to and modify the contents of payload.

To solve these device-dependent issues, I want to move the processing
of contents in payload from firewire-lib to each devices. This series of
patches is for this purpose.

sakamocchi (4):
  firewire-lib: add helper function to set data block size
  firewire-lib: add callback function for payload
  firewire-lib: remove unused members and functions
  firewire-speakers: add functions to handle payload

 amdtp.c    |  144 ++++++------------------------------------------------------
 amdtp.h    |   45 +++++++------------
 speakers.c |   94 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 117 insertions(+), 166 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
