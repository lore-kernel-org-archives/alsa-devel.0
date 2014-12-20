From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 10/10] ALSA: hda: replace .wallclock by
 .get_time_info
Date: Sat, 20 Dec 2014 11:50:45 -0600
Message-ID: <5495B6F5.2050603@linux.intel.com>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1419009913-3686-11-git-send-email-pierre-louis.bossart@linux.intel.com>
 <CAN8cciZS2d68UFRN08dHcyjN8Ajud-_JRyoMLcK9-ZEp2cQhTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EE1B6260494
 for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2014 18:50:45 +0100 (CET)
In-Reply-To: <CAN8cciZS2d68UFRN08dHcyjN8Ajud-_JRyoMLcK9-ZEp2cQhTw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>> +               audio_tstamp_report->accuracy_m = 42; /* 24 MHz WallClock
> == 42ns resolution */
>> +               audio_tstamp_report->accuracy_e = 0;
>> +
>
> Do you mean wall clock run at 48000 * 500 Hz ? 42.666ns

HDAudio wall clock (and bit clock) runs at 24MHz. So yes that's 48000 * 500.

> Those aureal sound cards also can provide time stamp using VORTEX_SMP_TIME
> mmio register which tick at 48000 * 256 Hz ?

then it should be fairly easy to implement the same feature...
