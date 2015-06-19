From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Audio Driver Works In Ubuntu but Crash in
	Debian	After 2nd Run
Date: Fri, 19 Jun 2015 10:01:02 +0200
Message-ID: <5583CC3E.1090601@ladisch.de>
References: <CA+k7WwYp8aN0OWmSNjtYq-4w4s+00Ej7tcsjiqbj7BbiJ+MtQQ@mail.gmail.com>	<557FD536.3020906@ladisch.de>	<CA+k7WwZqBc9CyE0DpYnSW7ZVc6otZ8dJQ+9rtUXAsrKyv2j_nA@mail.gmail.com>	<55812940.5050906@ladisch.de>
 <1434531934.2471.9.camel@loki>	<CA+k7WwbSt-sxQePXx=A=2LJgNS2OPTrZQFhHcD2g02HM0P7NYg@mail.gmail.com>
 <CA+k7Wwb7i5n9dgGGVgkgbOpFC-+tsQnehMgkPLCnOebH5AE4oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B20CB26053B
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 10:01:06 +0200 (CEST)
In-Reply-To: <CA+k7Wwb7i5n9dgGGVgkgbOpFC-+tsQnehMgkPLCnOebH5AE4oA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Azizul Hakim <azizulfahim2002@gmail.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Azizul Hakim wrote:
> So when a audio playback starts I initialize the buffer pointer to "0"
> in the *.prepare* function.

This is correct.

> https://gist.github.com/azizulhakim/d24a36ef753f9a1536fa
> https://gist.github.com/azizulhakim/b15b002f74e77f88cd5a

This is not; the code confuses bytes and frames.

When in doubt, give _all_ variables a "_bytes" or "_frames" suffix, and
check that _every_ access uses the correct units.


Regards,
Clemens
