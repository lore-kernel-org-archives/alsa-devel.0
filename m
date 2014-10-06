From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] alsa-tools: Add a small "hdajacksensetest"
	helper
Date: Mon, 06 Oct 2014 13:13:54 +0200
Message-ID: <54327972.3050008@canonical.com>
References: <1412587852-14203-1-git-send-email-david.henningsson@canonical.com>
 <s5hzjd9xxlu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DC8D1260497
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 13:13:52 +0200 (CEST)
In-Reply-To: <s5hzjd9xxlu.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2014-10-06 13:10, Takashi Iwai wrote:
> At Mon,  6 Oct 2014 11:30:52 +0200,
> David Henningsson wrote:
>>
>> I previously had a small python script doing the same thing,
>> but it depended on hda-analyzer, which always breaks when something
>> new is added to the codec proc file.
>>
>> I got tired and rewrote it as a small C program instead, which I
>> hope will be a useful addition to alsa-tools.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   Makefile                            |   2 +-
>>   hdajacksensetest/Makefile.am        |  12 +++
>>   hdajacksensetest/configure.ac       |  10 +++
>>   hdajacksensetest/gitcompile         |  13 ++++
>>   hdajacksensetest/hdajacksensetest.c | 145 ++++++++++++++++++++++++++++++++++++
>>   5 files changed, 181 insertions(+), 1 deletion(-)
>>   create mode 100644 hdajacksensetest/Makefile.am
>>   create mode 100644 hdajacksensetest/configure.ac
>>   create mode 100755 hdajacksensetest/gitcompile
>>   create mode 100644 hdajacksensetest/hdajacksensetest.c
>>
>> diff --git a/Makefile b/Makefile
>> index b2da046..72f95e2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -3,7 +3,7 @@ TOP = .
>>   SUBDIRS = as10k1 envy24control hdsploader hdspconf hdspmixer \
>>   	  mixartloader pcxhrloader rmedigicontrol sb16_csp seq sscape_ctl \
>>   	  us428control usx2yloader vxloader echomixer ld10k1 qlo10k1 \
>> -	  hwmixvolume hdajackretask hda-verb
>> +	  hwmixvolume hdajackretask hda-verb hdajacksensetest
>>
>>   all:
>>   	@for i in $(SUBDIRS); do \
>> diff --git a/hdajacksensetest/Makefile.am b/hdajacksensetest/Makefile.am
>> new file mode 100644
>> index 0000000..795373c
>> --- /dev/null
>> +++ b/hdajacksensetest/Makefile.am
>> @@ -0,0 +1,12 @@
>> +MYNAME = hdajacksensetest
>> +AUTOMAKE_OPTIONS = foreign
>> +bin_PROGRAMS = hdajacksensetest
>> +AM_CFLAGS = @GLIB_CFLAGS@ -I "../hdajackretask/" -I "../hda-verb/"
>> +hdajacksensetest_SOURCES = hdajacksensetest.c ../hdajackretask/sysfs-pin-configs.c
>> +hdajacksensetest_LDADD = @GLIB_LIBS@
>> +
>> +alsa-dist: distdir
>> +	@rm -rf ../distdir/$(MYNAME)
>> +	@mkdir -p ../distdir/$(MYNAME)
>> +	@cp -RLpv $(distdir)/* ../distdir/$(MYNAME)
>> +	@rm -rf $(distdir)
>> diff --git a/hdajacksensetest/configure.ac b/hdajacksensetest/configure.ac
>> new file mode 100644
>> index 0000000..cc1eb84
>> --- /dev/null
>> +++ b/hdajacksensetest/configure.ac
>> @@ -0,0 +1,10 @@
>> +AC_INIT(hda-verb, 0.4)
>
> Should be named differently, I suppose.

Thanks for finding, was there anything else before I send a v2 with that 
fixed?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
