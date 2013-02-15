From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: Takashi: please help (compiling alsa-driver)
Date: Fri, 15 Feb 2013 19:37:43 +0100
Message-ID: <511E8077.4090900@gmail.com>
References: <511ABB0D.90808@gmail.com> <s5hmwv8vh94.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id E13222625F4
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 19:37:46 +0100 (CET)
Received: by mail-bk0-f53.google.com with SMTP id j10so1721557bkw.12
 for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2013 10:37:46 -0800 (PST)
In-Reply-To: <s5hmwv8vh94.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 13.02.2013 07:51, schrieb Takashi Iwai:
> At Tue, 12 Feb 2013 22:58:37 +0100,
> Jonas Petersen wrote:
>> How do you generate these snapshots?
> You need to have two git trees: sound.git tree containing the complete
> Linux kernel tree, and alsa-driver-build.git containing only the build
> stub for external builds.
>
> In the recent change, alsa-driver-build.git (or equivalent with
> alsa-driver.git in alsa-project.org) contains only README in master
> branch.  Checkout build branch instead.  Then you'll get the whole
> build stuff in alsa/ subdirectory.  Go into alsa subdirectory, then
> run
> 	ALSAKERNELDIR=../../sound ./gitcompile --with-debug=full --enable-dynamic-minors
>
> Alternatively, you can pull the alsa-driver-built git into kernel tree
> directly.  Then go to alsa subdirectory and run gitcompile.  In that
> case, you can omit passing "ALSAKERNELDIR=..." argument.

Thank you very much, that did help!

It didn't exactly answer my distinct question ("How do you generate 
these snapshots?"), but I was able to figure it out by myself now.

After some manual copying and linking and investigating I finally found 
what I need need to do:

$ ./utils/setup-alsa-kernel -c ../../sound

After that I can copy just the 'alsa' folder to another machine and it 
wil build.

The problem is, this procedure requires 1.6 GB of disk space. I'm 
building on another system that does not have that much space right now. 
The mentioned snapshot (and now the result from the 'setup-alsa-kernel' 
script) is consuming only about 100 MB after a full build.

These are all steps required:

~$ mkdir tiwai; cd tiwai
~/tiwai$ git clone git://github.com/tiwai/alsa-driver-build.git
~/tiwai$ git clone git://github.com/tiwai/sound.git
~/tiwai$ cd alsa-driver-build
~/tiwai/alsa-driver-build$ git checkout build
~/tiwai/alsa-driver-build$ cd alsa
~/tiwai/alsa-driver-build/alsa$ ./utils/setup-alsa-kernel -c ../../sound

Now the alsa folder contains everything needed.
Finally:

some-other-machine/alsa$ ./gitcompile --with-debug=full 
--enable-dynamic-minors

Regards
Jonas
