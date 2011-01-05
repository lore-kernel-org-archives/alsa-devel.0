From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix SmartQ compilation
Date: Wed, 05 Jan 2011 20:45:14 +0100
Message-ID: <4D24CA4A.4090105@gmail.com>
References: <4d20d689.cc7e0e0a.6f59.4a1d@mx.google.com>
	<20110105100409.GA6262@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 14BA02433A
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 20:45:18 +0100 (CET)
Received: by ewy19 with SMTP id 19so6487543ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 11:45:17 -0800 (PST)
In-Reply-To: <20110105100409.GA6262@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Op 05-01-11 11:04, Mark Brown schreef:
> On Sun, Jan 02, 2011 at 08:48:23PM +0100, Maurus Cuelenaere wrote:
>> This makes the SmartQ sound driver compile again with recent ASoC changes.
>>
>> Signed-off-by: Maurus Cuelenaere<mcuelenaere@gmail.com>
> As Jassi said this doesn't apply against -next.  I've applied for 2.6.37
> and done a merge but I may have resolved some stuff incorrectly so
> please check.

Hmm, looks like 74bd21e9b301445b57bdcccdd7b5063ad3fbad0f is pretty much the same, so that obsoletes my patch.

Sorry for not checking linux-next.

-- 
Maurus Cuelenaere
