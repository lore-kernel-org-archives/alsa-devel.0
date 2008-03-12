From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 12 Mar 2008 09:40:21 -0500 (CDT)
Message-ID: <20080312144021.3FE57DBA2@gherkin.frus.com>
References: <ED0F0070-B876-4D8B-8F88-879E01AB4326@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 431E42449F
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 15:40:38 +0100 (CET)
In-Reply-To: <ED0F0070-B876-4D8B-8F88-879E01AB4326@orcon.net.nz>
	"from Michael Cree at Mar 12, 2008 09:00:13 am"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Cree <mcree@orcon.net.nz>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Well, I built a 2.6.22 kernel last night, and in tests this morning
there's no difference relative to the ALSA behavior seen in 2.6.25-rc4.
Since the question came up (or was strongly implied), I took the time to
check the status of IRQ 5 in /proc/interrupts, and while it shows up as
assigned to the sound card, no interrupts are being seen/processed by
the es18xx driver.  When I remove the snd-es18xx module and install the
snd-sb8 module with the same parameters (other than there's no second
DMA channel), the /proc/interrupts counter for IRQ 5 increments as
expected when playing sound files.

At this point I'm pretty sure the es18xx issue isn't a regression: it's
"just" a bug that has been around since I first loaded 2.6.X on my
Alpha.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
