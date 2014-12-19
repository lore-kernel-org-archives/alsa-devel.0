From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v2 00/10]  audio timestamping evolutions
Date: Fri, 19 Dec 2014 21:38:41 +0100
Message-ID: <54948CD1.4080309@perex.cz>
References: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 0242B2604F2
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 21:38:43 +0100 (CET)
In-Reply-To: <1419009913-3686-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Dne 19.12.2014 v 18:25 Pierre-Louis Bossart napsal(a):
> This series of patches was inspired by recent threads on the alsa
> mailing list, as well issues detected with existing and upcoming
> hardware:

I don't like some aspects in the interface:

1) ext_info member is not required - the standard info field
   has enough free bits
2) the whole struct snd_pcm_status is R/O -
   _IOR('A', 0x20, struct snd_pcm_status); I believe that it's much
   better to add new audio_tstamp_type to sw_params, but see (4)
3) accuracy - I would use uint64_t and report accuracy in pico-seconds
   (range from 0 picoseconds to 18446744 seconds); yes, use next bytes
   from the reserved part of status struct. the __u32 might be used only
   for flags
4) if there is a motivation to call / obtain timestamps for multiple
   purposes (audio tstamp types), then offer to return all these
   timestamps in one shot rather than do multiple queries (again, use
   reserved bytes)

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
