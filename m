From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.28 release - request for testing
Date: Fri, 13 Jun 2014 19:17:37 +0200
Message-ID: <539B3231.10105@perex.cz>
References: <1402647348-25604-1-git-send-email-david.henningsson@canonical.com>	<539AB5C7.6020501@perex.cz>	<539ABEF0.7020508@canonical.com>
 <s5hfvj9go7w.wl%tiwai@suse.de> <539AC54C.60504@canonical.com>
 <539ACD9A.5040209@perex.cz> <539AD7F4.7070302@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id A2E76261A7C
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 19:17:38 +0200 (CEST)
In-Reply-To: <539AD7F4.7070302@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Date 13.6.2014 12:52, David Henningsson wrote:
> 
> 
> On 2014-06-13 12:08, Jaroslav Kysela wrote:
>> Hello all,
>>
>>    ALSA 1.0.28 packages are available for testing at
>>
>> ftp://ftp.alsa-project.org/pub/testing/
>>
>>    Please, report any issues. I expect to announce the release on Monday.
> 
> Thanks!
> 
> I'm testing build of alsa-lib now and I have two questions:
> 
> 1) the final so version seems to be libasound.so.2.0.0 for both 1.0.27 
> and 1.0.28. I'm not sure how important it is, but shouldn't this be 
> increased to 2.0.1 or 2.1.0 to reflect code changes?

I think that we had some discussion about this and we use different
system to identify new libraries:

1) there is snd_asoundlib_version() function
2) the packaging system identifies the exact used library version
3) we use deprecated linker warning for obsolete symbols
4) only "current" libtool version number will be changed when
   the library is not backwards compatible, otherwise all symbols must
   be present and compatible

Basically, we haven't found the current:revision:age numbering useable
for our rules and as the libtool documentation states, it should not
reflect the release number at all.

Even if the age is increased, nobody will have/known a correlation
between the package release version and the library version. It means -
we would update a number for nothing in this case.

Eventually (contradicting to the paragraphs above) the age might reflect
the release number in form like:

1.0.28.3  ->  2:0:283

Future alsa-lib numbering:

2.33.5 -> 3:0:335 or 2:1:335 (if the library is backward compatible)

And this makes the question, if the version of packages should be
increased to 2.0.0 in next release to lower the last number :-)

> 2) This probably is not a new issue, but I was wondering about all the 
> extra files created in configure.ac, e g ctl_symbols_list.c. Are they 
> ever cleaned by some "clean", "maintainerclean" or similar rule?

Nobody has required this. Patches are welcome. I'm using the 'git
archive' to obtain the sources without these extra files for the
packaging purposes and 'make dist'.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
