From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: asoc SND_SOC_DAPM_AIF_IN question
Date: Wed, 22 Dec 2010 22:39:55 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F7D8244A5
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 18:10:03 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

In the codec driver I am writing I added 2 paths in map, one for Headset and 
second for Speaker. Both of these paths have common PCM port enable button so I 
added that using SND_SOC_DAPM_AIF_IN

So my codec map looks like:
        /*headset map*/
        { "HSDAC Left", NULL, "PCM_In"},
        { "HSDAC Right", NULL, "PCM_In"},
        { "PCM_In", NULL, "Headset Rail"},
        { "Headset Rail", NULL, "Audio Rail"},

        /*speaker map*/
        { "IHFDAC Left", NULL, "PCM_In"},
        { "IHFDAC Right", NULL, "PCM_In"},
        { "PCM_In", NULL, "Speaker Rail"},
        { "Speaker Rail", NULL, "Audio Rail"},

The debugfs tell me this seems right
[root@localhost dapm]# cat PCM_In
PCM_In: Off  in 0 out 5 - R636(0x27c) bit 0
 stream HeadSet Speaker inactive
 in  static Speaker Rail
 in  static Headset Rail
 out static IHFDAC Right
 out static IHFDAC Left
 out static HSDAC Right
 out static HSDAC Left

But when the stream is started now all the widgets get powered on. The debugfs 
entry says
[root@localhost dapm]# cat PCM_In
PCM_In: On  in 1 out 5 - R636(0x27c) bit 0
 stream HeadSet Speaker active
 in  static Speaker Rail
 in  static Headset Rail
 out static IHFDAC Right
 out static IHFDAC Left
 out static HSDAC Right
 out static HSDAC Left

How is this detecting input as 1 (is this due to AIF_IN and thus turning on all 
the widgets in map? (turns on IHFDAC for HeadSet stream as well :(

What could I be doing wrong here? I want to add this PCM button for all streams 
(4 eventually) and this be enabled whenever anyone of them is started.

~Vinod
