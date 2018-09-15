From: Andre Guedes <andre.guedes@intel.com>
Subject: [RFC v2 - AAF PCM plugin 0/5] Introduce AVTP Audio
	Format (AAF) plugin
Date: Fri, 14 Sep 2018 18:17:13 -0700
Message-ID: <20180915011718.19444-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 24F56267782
 for <alsa-devel@alsa-project.org>; Sat, 15 Sep 2018 03:17:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi all,

This is the version 2 of AAF plugin RFC series. For general context information
about the AAF plugin, please refer to the cover letter from version 1 [1] and
the documentation in doc/aaf.txt.

Code-wise, the main changes in this new version are:

    1) The media clock was generating timestamps in UTC coordinate. However,
    AVTP timestamps are in TAI coordinate system so the media clock was fixed
    to use TAI instead.

    2) All plugin resources (e.g. buffers, fds) are now allocated/freed in
    hw_params/hw_free ioplug callbacks.

    3) The plugin constraints are applied at entry point instead of hw_params
    callback.

Also, in this new version, the commit message from patch "aaf: Implement
Playback mode support" was improved so it discusses the AVTP protocol
restrictions in terms of formats and rates as well as why the plugin uses the
system clock to implement a media clock.

For further information about what has been discussed in the previous version,
please refer to the RFC v1 patch series which starts in [1]. All versions of
this series can be also found in my alsa-plugins tree in github [2].

Best regards,

Andre

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-August/139494.Even
[2] https://github.com/aguedes/alsa-plugins

Andre Guedes (5):
  aaf: Introduce plugin skeleton
  aaf: Load configuration parameters
  aaf: Implement Playback mode support
  aaf: Prepare for Capture mode support
  aaf: Implement Capture mode support

 Makefile.am     |    3 +
 aaf/Makefile.am |    9 +
 aaf/pcm_aaf.c   | 1214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac    |    9 +
 doc/aaf.txt     |  142 +++++++
 5 files changed, 1377 insertions(+)
 create mode 100644 aaf/Makefile.am
 create mode 100644 aaf/pcm_aaf.c
 create mode 100644 doc/aaf.txt

-- 
2.14.4
