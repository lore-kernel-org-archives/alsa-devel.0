From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: ASoC v0.10
Date: Wed, 21 Jun 2006 17:00:37 +0100
Message-ID: <1150905637.28115.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Richard Purdie <rpurdie@rpsys.net>, Dirk Opfer <Dirk@Opfer-Online.de>
List-Id: alsa-devel@alsa-project.org

I'd like to announce that ALSA System on Chip (ASoC) version 0.10 has
now been released and is available here :-

 http://www.rpsys.net/openzaurus/patches/alsa/asoc-v0.10.patch

ASoC is an embedded layer for ALSA aimed at SoC CPU's and portable audio
codecs. More info is available here:-

 http://www.rpsys.net/openzaurus/patches/alsa/info.html


Features in 0.10:-

 o Codec driver architecture independence. Codecs drivers are reusable
between different SoC CPU's. 

 o Dynamic Audio Power Management (DAPM) - manages the audio subsystem
power, so that the minimum amount of power is always used in any usage
scenario.

 o Digital Audio Interface (DAI) configuration - each DAI is configured
for optimal power consumption, depending on rate, sample size, etc

 o Pop and Click reduction.

 o Documentation - There is some "in progress" documentation in
Documentation/sound/alsa/soc


I'm aiming to release version 0.11 in about two weeks and submit the
core and Zaurus support to alsa-kernel (unfortunately, too late for the
current merge window). There are only a few issues outstanding before
0.11, namely:-

 o Finish the documentation.
 o Fix outstanding Zaurus bugs. 

I'd appreciate any comments.


Liam  
