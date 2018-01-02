From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/1] conf/ucm: Add
	chtrt5645-mono-speaker-analog-mic configuration
Date: Tue,  2 Jan 2018 20:01:09 +0100
Message-ID: <20180102190110.17281-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 258AD2674CE
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 20:01:12 +0100 (CET)
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

Here is a patch which adds a configuration for Cherry Trail boards which use a rt5645 codec
connected to a mono speaker and with an analog mic on IN2N + IN2P.

The chtrt5645-mono-speaker-analog-mic/HiFi.conf for this is based on the
latest version from https://github.com/plbossart/UCM/tree/master/chtrt5645
with all the unused input options removed and some changes made to make
the analog mic work.

This patch is currently RFC and should not be applied (yet) because it
depends on a new "Int Analog Mic" DAPM widget for which kernel patches
are pending upstream. Once the "Int Analog Mic" DAPM widget name is
finalized this patch can be merged.

This has been tested on the following devices:

GPD win
GPD pocket
Teclast X80 Pro

Regards,

Hans
