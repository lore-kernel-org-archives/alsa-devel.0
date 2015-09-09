From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH lib 0/5] alsa-lib topology trivial fixes
Date: Wed, 09 Sep 2015 11:08:57 +0100
Message-ID: <1441793337.2439.42.camel@loki>
References: <1441743701-28165-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CDAD52604AF
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 12:09:00 +0200 (CEST)
In-Reply-To: <1441743701-28165-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-09-08 at 22:21 +0200, Takashi Iwai wrote:
> Hi,
> 
> here is a series of trivial fixes that have been spotted by gcc
> warnings.
> 

Thanks, Takashi. Dont know why we missed these.

Fwiw, I still see some deprecated API warnings for snd_pcm_hwsync() and
an unused variable warning :-

make[3]: Entering directory '/home/lrg/source/alsa-lib/modules/mixer/simple'
  CC       sbase.lo
sbase.c: In function 'simple_event_add1':
sbase.c:327:16: warning: variable 'values' set but not used [-Wunused-but-set-variable]
  unsigned long values;

Thanks

Liam
