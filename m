From: Antonio Ospite <ao2@ao2.it>
Subject: [alsa-utils] alsaucm should come with a man page
Date: Wed, 27 Jul 2016 11:48:28 +0200
Message-ID: <20160727114828.9d6c709d80084b659426e6cc@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F27E265864
 for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2016 11:48:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Stefan Schmidt <stefan@slimlogic.co.uk>, Justin Xu <justinx@slimlogic.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I used alsaucm to test mixer use cases for an Intel Baytrail tablet, I
wanted to use bare alsa before bringing pulseaudio in, and it took some
time to get my head around it.

The output from the "alsaucm --help" is too terse, I had to look at the
alsa-lib code[1] to see the possible IDENTIFIERs, and even then it was
not clear to me that some operations, like for instance "list _devices",
can only work after setting a _verb in the same _execution_, for
instance this sequence doesn't work:

# alsaucm -c bytcr-rt5640 set _verb HiFi
# alsaucm -c bytcr-rt5640 list _devices

But this command does:
  
# alsaucm -c bytcr-rt5640 -b - <<EOM
set _verb HiFi
list _devces
EOM

Now that I know something more it makes sense: UCM just operates on
mixer settings, it does not have its own external state.

However, my point is that a man page explaining these things can make
the life easier to new users.

It would be better if alsa/UCM developers wrote the man page, but if no
one steps up I guess I could draft a first version myself.

Thanks,
   Antonio

[1]
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=include/use-case.h

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
