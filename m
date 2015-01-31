From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH v4 05/10] ALSA: core: selection of
 audio_tstamp type and accuracy reports
Date: Sat, 31 Jan 2015 12:37:58 +0500
Message-ID: <54CC8656.5080506@gmail.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1422662163-7391-6-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C9EC42604DD
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 08:38:01 +0100 (CET)
Received: by mail-wg0-f47.google.com with SMTP id n12so30498527wgh.6
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 23:38:01 -0800 (PST)
In-Reply-To: <1422662163-7391-6-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

31.01.2015 04:55, Pierre-Louis Bossart wrote:
> Audio timestamps can be extracted from sample counters, wall clocks,
> PHC clocks (Ethernet AVB), on-demand synchronized snapshots. This
> patch provides the ability to report timestamping capabilities, select
> timestamp types and retrieve timestamp accuracy, if supported.
> Details can be found in Documentations/sound/alsa/timestamping.txt

I think that it is a good idea to add some example ./audio_time output 
on a card that is neither HDAudio nor USB audio (i.e. a card not 
specifically touched by your patches), so that the fallback behavior is 
known.

-- 
Alexander E. Patrakov
