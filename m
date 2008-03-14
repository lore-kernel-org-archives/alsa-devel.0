From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Fri, 14 Mar 2008 18:33:57 -0500 (CDT)
Message-ID: <20080314233357.5223BDBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D2AD1037F8
	for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2008 00:34:01 +0100 (CET)
In-Reply-To: "from (env: rct) at Mar 14, 2008 08:13:44 am"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: twhitehe@uwo.ca
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

rct wrote:
> Rene Herman wrote:
> > Okay, and applying the attached just makes your sound completely dead in the 
> > water?
> > (patch to remove es1888_init from a Miata build omitted)
> 
> I'll try a build with the old OSS "sb" driver, and if that works ok, we
> may be able to do away with es1888_init() on the Miata.  Tyson -- I
> think you have a Miata if I'm remembering correctly: can you confirm
> these observations?

Quick followup: OSS "sb" driver works fine without es1888_init().

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
