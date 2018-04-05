From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: SOF 1.1 Release
Date: Thu, 05 Apr 2018 10:42:42 +0100
Message-ID: <1522921362.1923.958.camel@linux.intel.com>
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
To: "sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sound Open Firmware 1.1 has now been released and available here :-

git://git.alsa-project.org/sound-open-firmware.git

git://git.alsa-project.org/sound-open-firmware-tools.git


Significant changes since 1.0 :-

 o  Support for Playback/Capture on Intel Apollolake and Cannonlake platforms.
 o  Initial support for Intel Haswell and Broadwell platforms.
 o  Support for DMA based firmware tracing to host userspace.
 o  SIMD optimisations for SRC on xtensa ISA.
 o  Initial support for running firmware components on host.


Plans for 1.2 :-

 o  Playback/Capture on Haswell/Broadwell.
 o  SIMD optimisations for volume and mixer.
 o  Improved host based component testing.
 o  Initial runtime module support.

SOF Linux driver dependencies for ALSA/ASoC have also started to upstream.
Driver patches will continue to flow in anticipation for base SOF driver in
4.18.

Thanks

Liam 
