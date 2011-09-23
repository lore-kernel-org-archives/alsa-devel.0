From: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>
Subject: Adding ELD control to alsa-lib hdmi device
Date: Fri, 23 Sep 2011 13:46:00 -0500
Message-ID: <49882.4080256329$1316803577@news.gmane.org>
References: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C92EB103BF2
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 20:46:05 +0200 (CEST)
In-Reply-To: <1316793246-819-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-us
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
List-Id: alsa-devel@alsa-project.org

Hi,
Now that I almost done with exposing a read-only ELD control for HDA/HDMI
outputs, I was wondering how to read it from user-land. PulseAudio and
others rely on the 'hdmi' device, and apparently I can't access this new ELD
control, I have to use the 'hw:x,y' details.
I really don't understand much to alsa-lib... Can I expose this new control
through the ALSA configuration files where the hdmi device is defined? Or is
there a way to infer the card and device number actually used by an alsa-lib
plugin? Or do I have to add code to propagate the information from
hardware-level to higher-level plugins?
Thanks for your feedback!
-Pierre 
