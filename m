From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Thu, 31 Jan 2019 14:30:46 +0100
Message-ID: <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk> <s5hsgx9ckrf.wl-tiwai@suse.de>
 <20190131122624.GA20797@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BB9AD26797E
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2019 14:30:52 +0100 (CET)
In-Reply-To: <20190131122624.GA20797@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Phil Burk <philburk@google.com>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

Dne 31.1.2019 v 13:26 Mark Brown napsal(a):
> On Thu, Jan 31, 2019 at 09:08:04AM +0100, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>> anything O_APPEND based.  My understanding is that this is fundamentally
>>> a risk mitigation thing - by not having any of the sound kernel
>>> interfaces available to the applications affected there's no possibility
>>> that any problems in the sound code can cause security issues.
> 
>> The patch 2 implements exactly that kind of access restriction, so
>> that the passed fd won't do anything else than wished.
> 
> Yeah.
> 
>> If we want to be super-conservative, the implementation could be even
>> simpler -- instead of filtering, we may pass a minimum fd ops that
>> contains only mmap and release for the anon-dup fd...
> 
> I think that'd definitely help address the concerns.

A possible implementation:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=ca15bc69a984cc0eae2c43d0a49c66a20c937f39

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
