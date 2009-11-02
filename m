From: "Kp, Jeeja" <jeeja.kp@intel.com>
Subject: question on snd_jack_report
Date: Mon, 2 Nov 2009 23:08:09 +0530
Message-ID: <DC9628ADC672424FAECF61709E90EDDE6A2486FB@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id B616F2413B
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 18:39:34 +0100 (CET)
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
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org



>What is event.c?  If this is some part of the X.Org server then you'd be
>better asking the X folks about how to configure and use the X server,
>it rewraps the data it's getting from the kernel.


Sorry,it's evtest.c( this program polls /dev/input/eventX and prints
the events). Basically when a Headphone is inserted into the jack, driver
send snd_jack_report() with the status of present to ALSA. When the
respective /dev/input/event5 is read from userspace, it must print the
events. I don't see any events when snd_jack_report() is called.
