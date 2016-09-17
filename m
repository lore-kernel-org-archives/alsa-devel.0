From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: alsa-tools FTBFS on armel: gcc-6 narrowing
	conversions
Date: Sat, 17 Sep 2016 14:14:53 +0200
Message-ID: <20160917121453.sz6lgwhdabehhodw@galadriel.home.lxtec.de>
References: <20160912165218.vys63p73adfi2x76@galadriel.home.lxtec.de>
 <s5hk2edu2w1.wl-tiwai@suse.de>
 <2cd8fe48-f8b1-8349-57eb-a74439bfe399@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id 75F442606F8
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 14:14:55 +0200 (CEST)
Received: from h06.hostsharing.net (h06.hostsharing.net [83.223.95.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mailout3.hostsharing.net (Postfix) with ESMTPS id C3023101E698A
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 14:14:54 +0200 (CEST)
Received: from mail.home.lxtec.de
 (HSI-KBW-46-223-54-142.hsi.kabel-badenwuerttemberg.de [46.223.54.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h06.hostsharing.net (Postfix) with ESMTPSA id 87919603DBA0
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 14:14:54 +0200 (CEST)
Received: from localhost ([127.0.0.1])
 by mail.home.lxtec.de with esmtp (Exim 4.87 2 (LXTEC))
 id 1blEWD-00038G-K5
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 14:14:53 +0200
Received: from mail.home.lxtec.de ([IPv6:::1])
 by localhost (baumbart.home.lxtec.de [IPv6:::1]) (amavisd-new, port 10024)
 with ESMTP id B2Mo5WFGrqx3 for <alsa-devel@alsa-project.org>;
 Sat, 17 Sep 2016 14:14:53 +0200 (CEST)
Received: from galadriel.home.lxtec.de ([192.168.200.207])
 by mail.home.lxtec.de with smtp (Exim 4.87 2 (LXTEC))
 id 1blEWD-00038B-DV
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 14:14:53 +0200
Content-Disposition: inline
In-Reply-To: <2cd8fe48-f8b1-8349-57eb-a74439bfe399@sakamocchi.jp>
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
List-Id: alsa-devel@alsa-project.org

* Takashi Sakamoto <o-takashi@sakamocchi.jp> [2016-09-15 22:11 +0900]:

> Hi,
> 
> On Sep 15 2016 14:51, Takashi Iwai wrote:
> > On Mon, 12 Sep 2016 18:52:18 +0200,
> > Elimar Riesebieter wrote:
> >>
> >> Hi all,
> >>
> >> in Debian a FTBFS was discovered in building alsa-tools:
> >>
> >> | arm-linux-gnueabi-g++ -DPACKAGE_NAME=\"hdspmixer\" -DPACKAGE_TARNAME=\"hdspmixer\" -DPACKAGE_VERSION=\"1.11\" -DPACKAGE_STRING=\"hdspmixer\ 1.11\" -DPACKAGE_BUGREPORT=\"\" -DPACKAGE_URL=\"\" -DPACKAGE=\"hdspmixer\" -DVERSION=\"1.11\" -DSTDC_HEADERS=1 -DHAVE_LIBASOUND=1 -I.   -Wdate-time -D_FORTIFY_SOURCE=2  -g -O2 -fdebug-prefix-map=/<<PKGBUILDDIR>>=. -fstack-protector-strong -Wformat -Werror=format-security   -I/usr/include/freetype2   -D_THREAD_SAFE -D_REENTRANT -fno-exceptions -MT channelmap.o -MD -MP -MF .deps/channelmap.Tpo -c -o channelmap.o channelmap.cxx
> >> | channelmap.cxx:59:1: error: narrowing conversion of '-1' from 'int' to 'char' inside { } [-Wnarrowing]
> >> |  };
> >> |  ^
> >>
> >> More Details can be found at:
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=837590
> >>
> >> Could this be fixed for next release?
> > 
> > Yes, this was already fixed in git tree.
> 
> This issue was fixed by this commit.
> 
> gcc6 narrowing error
> http://git.alsa-project.org/?p=alsa-tools.git;a=commit;h=70118f5f93a4179a0df61925e64baf873f126be0

Thanks for the hint!

Elimar
-- 
  "Talking much about oneself can also
   be a means to conceal oneself."
         -Friedrich Nietzsche
