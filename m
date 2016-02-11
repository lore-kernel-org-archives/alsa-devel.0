From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 18/19] ASoC: Intel: Atom: add support for
	RT5642
Date: Thu, 11 Feb 2016 08:00:37 -0600
Message-ID: <56BC9405.3040400@linux.intel.com>
References: <5679871B.1050200@gmail.com> <56798CFC.7040909@gmail.com>
 <567991B8.4060304@linux.intel.com> <56BC5EA3.5020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C0092610B0
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 15:00:33 +0100 (CET)
In-Reply-To: <56BC5EA3.5020701@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luka Karinja <luka.karinja@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


> Are there any updates on the TAF sound? I have been following your
> github, and saw there is a new TAF branch.
> Is it already possible to get sound out of our devices?

Nope, it's a debug branch. The DACs get powered when audio starts 
playing but there is no sound. It's by far the most puzzling problem 
we've seen, we haven't been able to pin-point where the issue is (I2S 
not working, controls, etc). we did get access to the schematics which 
did show some changes on speakers and mics (more quirks, yay) but it's 
not enough.
