From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: [PATCH 0/5] [RFC]intel_hdmi_audio driver
Date: Mon, 22 Nov 2010 18:59:39 +0530
Message-ID: <12D0C12AF19E15409D57F22566E88EF505ADE562D1@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F483103976
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:29:44 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

Hi

Following emails are series of 5 patches for Intel MID HDMI audio driver. This
driver is for the HDMI audio controller in upcoming Mobile Internet Devices
(MID) platform from Intel.
HDMI Audio Driver supports HDMI audio playback through ALSA interfaces. It
interacts with the display driver to program the HDMI audio subsystem in the
HDMI controller and receive hot plug/unplug events and DMA completion
interrupts. HDMI audio driver is dependent on platform display driver.

The dependant drivers for the platform are not yet available in the upstream.
So please consider these patches only for RFC and provide your comments/suggestions.

The patches are compiled with 0 warnings and checkpatch.pl 

The rest of the patches that follow have a brief description about the contents.

Thanks
Ramesh and Sailaja
