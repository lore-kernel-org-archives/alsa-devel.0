From: "Wischer, Timo (ADITG/SW1)" <twischer@de.adit-jv.com>
Subject: Re: FW: Further goals of thread-safe PCM API
Date: Thu, 27 Apr 2017 08:45:55 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D768418D7E@HI2EXCH01.adit-jv.com>
References: <B0FB33DC1499054591F62C0EF1E013D7684182A2@HI2EXCH01.adit-jv.com>
 <s5hpog7m6gh.wl-tiwai@suse.de> <s5hk26dmwi9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C778266949
 for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2017 10:45:58 +0200 (CEST)
In-Reply-To: <s5hk26dmwi9.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

All our test cases are working fine again with your commit [1].
Thanks a lot.

I think all commits which introducing unlocked versions of the API functions can be reverted e.g [2].
Or what do you think? 


[1] http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=1cb217ead9aff029f194208bf484be1ba956b194
[2] http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=24e63b75275e9c923c336b8dba3919b980e8f234

Best regards

Timo Wischer
Software Group I (ADITG/SW1)

Tel. +49 5121 49 6938

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Freitag, 21. April 2017 20:44
To: Wischer, Timo (ADITG/SW1)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] FW: Further goals of thread-safe PCM API

On Thu, 20 Apr 2017 17:42:06 +0200,
Takashi Iwai wrote:
> 
> On Thu, 20 Apr 2017 16:01:47 +0200,
> Wischer, Timo (ADITG/SW1) wrote:
> > 
> > Hi everyone,
> > 
> > I am wondering about the implementation of the new thread-safety feature [1].
> > There are so many issues with deadlocks (e.g. [3]) which were already solved but also which are not yet solved.
> > 
> > Why do you not using a recursive mutex to avoid most of this deadlocks?
> > Using PTHREAD_MUTEX_RECURSIVE as the pthread attribute [2].
> 
> It sounds like a good idea.
> Although the plugin should be written not to cause deadlock, it's 
> better to avoid such a pain by allowing the recursive lock.
> 
> Care to test and submit the proper patch?

Never mind, I committed a quick fix to git repo now.
Thanks for the suggestion!


Takashi
