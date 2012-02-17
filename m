From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: Usage of jack_status_check in ASoC GPIO
Date: Fri, 17 Feb 2012 12:21:53 +0530
Message-ID: <4F3DF909.8020602@linux.intel.com>
Reply-To: omair.m.abdullah@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id A5E20103A64
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:51:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, jy0922.shim@samsung.com
List-Id: alsa-devel@alsa-project.org

If I need to call a codec driver function whenever Headset status 
changes (to set various registers, turn off micbias etc.). In such a 
case, can the jack_status_check callback in snd_soc_jack_gpio structure 
be used? If I use it, I would need to modify the callback to pass 
certain parameters (codec pointer, status). Is this the intended use of 
the callback?
