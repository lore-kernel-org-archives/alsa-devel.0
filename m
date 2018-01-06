From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] conf/ucm: Add
	chtrt5645-mono-speaker-analog-mic configuration
Date: Sat,  6 Jan 2018 23:03:19 +0100
Message-ID: <20180106220320.5423-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 34CB5266F2E
 for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2018 23:03:23 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

Hi All,

Now that the kernel patch for the "Int Analog Mic" switch is queued for
merging into 4.16, here is a non RFC version of my patch which adds a
configuration for Cherry Trail boards which use a rt5645 codec connected
to a mono speaker and with an analog mic on IN2N + IN2P.

Compared to the RFC version the line setting the Headphone Volume has
been changed to set it to 25 (out of 39) instead of 31 because 31 has
been reported to cause a crackling noise on some devices.

The chtrt5645-mono-speaker-analog-mic/HiFi.conf for this is based on the
latest version from https://github.com/plbossart/UCM/tree/master/chtrt5645
with all the unused input options removed and some changes made to make
the analog mic work.

This has been tested on the following devices:

GPD win
GPD pocket
Teclast X80 Pro

Regards,

Hans
