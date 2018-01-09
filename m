From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [ANNOUNCE] SOF 1.0 Release
Date: Tue, 09 Jan 2018 19:17:38 +0000
Message-ID: <1515525458.1844.203.camel@linux.intel.com>
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

I'd like to announce the 1.0 release of Sound Open Firmware (SOF) is
available for download on git.alsa-project.org. 

SOF is an open source BSD licensed audio DSP firmware that currently
runs on Cadence xtensa architecture DSPs found on Intel Baytrail,
Braswell and Cherrytrail based devices, however SOF is architecture and
platform independent meaning it's not tightly coupled to xtensa DSPs or
Intel CPUs/SoCs.

The 1.0 release supports limited playback and capture topologies
alongside volume, mixing and sample format conversion.

Information about SOF can be found on the ALSA SOF wiki here :-

https://www.alsa-project.org/main/index.php/Firmware

Development for SOF 1.1 has started which will include support for
Haswell, Broadwell and Apollolake platform alongside support for SRC
and more complex topologies.

Liam
