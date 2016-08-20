From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: locking looks odd
Date: Sat, 20 Aug 2016 14:12:05 +0200
Message-ID: <20160820121205.GK4252@var.home>
References: <20160816210322.GD4466@var.home>
 <0fec7ab2-f72f-a27a-e82b-58642836db88@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.aquilenet.fr (hera.aquilenet.fr [141.255.128.1])
 by alsa0.perex.cz (Postfix) with ESMTP id BBBA226588A
 for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2016 14:12:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0fec7ab2-f72f-a27a-e82b-58642836db88@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela, on Wed 17 Aug 2016 19:46:42 +0200, wrote:
> Dne 16.8.2016 v 23:03 Samuel Thibault napsal(a):
> > - snd_pcm_new seems to initialize pcm->thread_safe to 0 by default, this
> >   does not seem safe. The attached patch initializes it to 1, which
> >   fixes the bug in our tests.
> > 
> > - snd_pcm_hw_open_fd forces it to 1, thus ignoring what snd_pcm_new set.
> 
> The thread_safe has this meaning:
> 
> 0  - the pcm plugin is not thread safe
> 1  - the pcm plugin is thread safe (actually only the hw plugin)
> -1 - disable thread safety

So now with rethinking all of this, I'm starting to understand: from
reading the variable name, I would have thought "thread_safe=1" means
"I want thread safety thanks to a mutex", while apparently it means
"the plugin is already thread-safe, there is no need for a mutex"...
Really, all of this should be documented clearly along the source code,
otherwise people will get it wrong.

I'd just like to check something: do we agree that libasound must be
thread-safe by default (otherwise it breaks the application assumption
that it's thread-safe)?  If so, then there are thread-safety bugs: the
mentioned Debian report is far from alone, the upgrade to the newer
libasound has severely broken quite a few applications, I'm at the point
of advising the Debian maintainer to just revert to the previous version
for Stretch, otherwize we'll be shipping just very-buggy software.

Samuel
