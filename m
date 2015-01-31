From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 05/10] ALSA: core: selection of
 audio_tstamp type and accuracy reports
Date: Sat, 31 Jan 2015 14:01:37 -0600
Message-ID: <54CD34A1.8080303@linux.intel.com>
References: <1422662163-7391-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1422662163-7391-6-git-send-email-pierre-louis.bossart@linux.intel.com>
 <54CC8656.5080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 47A23260488
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 21:01:21 +0100 (CET)
In-Reply-To: <54CC8656.5080506@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 1/31/15 1:37 AM, Alexander E. Patrakov wrote:
> 31.01.2015 04:55, Pierre-Louis Bossart wrote:
>> Audio timestamps can be extracted from sample counters, wall clocks,
>> PHC clocks (Ethernet AVB), on-demand synchronized snapshots. This
>> patch provides the ability to report timestamping capabilities, select
>> timestamp types and retrieve timestamp accuracy, if supported.
>> Details can be found in Documentations/sound/alsa/timestamping.txt
>
> I think that it is a good idea to add some example ./audio_time output
> on a card that is neither HDAudio nor USB audio (i.e. a card not
> specifically touched by your patches), so that the fallback behavior is
> known.

I didn't change the USB behavior, only fixed the way the trigger_tstamp 
is found, and yes it shows what the fallback is. And the documentation 
is already quite long, I wonder how many people will read it to the end 
without falling into a deep coma ;-)
