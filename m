From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Wed, 12 Mar 2008 23:24:02 -0500 (CDT)
Message-ID: <20080313042402.CE3D7DBA2@gherkin.frus.com>
References: <47D8473A.3060806@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 70D631038DA
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 05:24:06 +0100 (CET)
In-Reply-To: <47D8473A.3060806@keyaccess.nl> "from Rene Herman at Mar 12, 2008
	10:12:26 pm"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> Okay, and applying the attached just makes your sound completely dead in the 
> water?
> (patch to delete es1888_init function)

Oddly enough, the patch had no effect whatsoever (at least with the
ALSA drivers: I didn't try building a kernel with the OSS "sb" driver).
Just to make sure I wasn't "benefiting" from initialization inherited
from a prior boot, I even powered-down the machine for 30 seconds
before booting on the new kernel.  snd-sb8 still works, and snd-es18xx
is still broken (in exactly the same way as before).

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
