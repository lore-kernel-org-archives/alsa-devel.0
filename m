From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: ALSA in embedded use (was: Re: future ALSA development)
Date: Wed, 1 Oct 2003 12:37:48 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310011214400.1779-100000@ecabase.localdomain>
References: <s5hadbqefxq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecabase.localdomain (cs78171117.pp.htv.fi [62.78.171.117])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA10224
	for <alsa-devel@alsa-project.org>; Wed, 1 Oct 2003 11:43:46 +0200
In-Reply-To: <s5hadbqefxq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this reply comes a bit late, but I guess this is still very much a 
relevant topic.

On Mon, 7 Jul 2003, Takashi Iwai wrote:
>> Already alsa-lib has some features that are not so good from embedded 
>> perspective:
>> - not a small lib; with default settings around 0.5MB; this 
>>   is an extra 0.5MB compared to just using OSS where there is no lib
> that's true.

I yesterday installed ALSA 0.9.6 on a iPaq and libasound.so was 688kB
when stripped (2.3MB with symbols).

One thing to note is that latest Familiar distro release (0.7) from 
handhelds.org (the most popular distro for iPaqs and various other
handhelds), now includes ALSA kernel drivers (alsa-modules package), but 
no userspace ALSA packages. 

This is a prime example what we need to avoid (ALSA used only for the
OSS-emulation). Now I'm not subscribed to the familiar mailing lists, so
I'm not 100% sure of the reasons why userspace was left out. Also, the
unstable package tree seems to have packages for alsa-lib and alsa-utils,
so situation might change.

Still, my iPaq has only 16MB of space for the root system. After 
installing the basic GPE2 image, I only have 1.1MB left for my apps. 
In this situation the 688kB for alsa-lib plus some more for basic ALSA 
utils is a real problem.

>> - use of more advanced c-lib features such as dynamic loading (dlopen(), 
> it's possible to create a static library which doesn't need dlopen().
> but it will eventually link the whole plugin objects statically.
[...]
> so, maybe a compromise is to add configure options or something to
> choose the components (e.g. plugins) to be built in.  this will reduce
> the size of binary, too.

Ok, this is good to know. Does this already work now (i.e. when dlopen()
is not available)? 

> there are some parts which use glibc's extension (like jump to label
> address or function-in-function).  but these can be fixed with the
> standard style, too.  they are mostly optmizations only.

Hmm, so I guess we'd need someone who actively uses dietlibc (or some 
other) with ALSA. Otherwise it will be hard to keep alsa-lib 
clean from glibc-isms. Any volunteers? :)

>> apps to directly communicate with ALSA's kernel interface.
> mmm, this should be never done.
> one of the reason to have alsa-lib is to avoid this.

But the risk is there, see my comments above about libasound size.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
