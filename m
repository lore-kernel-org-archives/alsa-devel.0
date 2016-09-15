From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: alsa-tools FTBFS on armel: gcc-6 narrowing
	conversions
Date: Thu, 15 Sep 2016 22:11:22 +0900
Message-ID: <2cd8fe48-f8b1-8349-57eb-a74439bfe399@sakamocchi.jp>
References: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>
 <s5hk2edu2w1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 9EE23261A5E
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 15:11:25 +0200 (CEST)
In-Reply-To: <s5hk2edu2w1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Elimar Riesebieter <riesebie@lxtec.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 15 2016 14:51, Takashi Iwai wrote:
> On Mon, 12 Sep 2016 18:52:18 +0200,
> Elimar Riesebieter wrote:
>>
>> Hi all,
>>
>> in Debian a FTBFS was discovered in building alsa-tools:
>>
>> | arm-linux-gnueabi-g++ -DPACKAGE_NAME=\"hdspmixer\" -DPACKAGE_TARNAME=\"hdspmixer\" -DPACKAGE_VERSION=\"1.11\" -DPACKAGE_STRING=\"hdspmixer\ 1.11\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE_URL=\"\" -DPACKAGE=\"hdspmixer\" -DVERSION=\"1.11\" -DSTDC_HEADERS=1 -DHAVE_LIBASOUND=1 -I.   -Wdate-time -D_FORTIFY_SOURCE=2  -g -O2 -fdebug-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -Wformat -Werror=format-security   -I/usr/include/freetype2   -D_THREAD_SAFE -D_REENTRANT -fno-exceptions -MT channelmap.o -MD -MP -MF .deps/channelmap.Tpo -c -o channelmap.o channelmap.cxx
>> | channelmap.cxx:59:1: error: narrowing conversion of '-1' from 'int' to 'char' inside { } [-Wnarrowing]
>> |  };
>> |  ^
>>
>> More Details can be found at:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=837590
>>
>> Could this be fixed for next release?
> 
> Yes, this was already fixed in git tree.

This issue was fixed by this commit.

gcc6 narrowing error
http://git.alsa-project.org/?p=alsa-tools.git;a=commit;h=70118f5f93a4179a0df61925e64baf873f126be0

However, we have never released new alsa-tools package with this fix.
It's still v1.1.0.
http://alsa-project.org/main/index.php/Download

> Jaroslav
Let us release the new alsa-tools package in the timing of kernel 4.8
release, for each distribution project?


Regards

Takashi Sakamoto
