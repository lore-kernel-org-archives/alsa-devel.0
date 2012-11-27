From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert
 to dt support
Date: Tue, 27 Nov 2012 10:01:43 +0000
Message-ID: <20121127100143.GA6028@sirena.org.uk>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <201211262123.42812.arnd@arndb.de> <50B42B4B.90407@atmel.com>
 <201211270844.29311.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 920E8260305
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 11:01:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201211270844.29311.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 27, 2012 at 08:44:29AM +0000, Arnd Bergmann wrote:

> I think I'm missing context here. What's holding this up? It looks like it should
> have been merged before 531f67e41d, possibly into both arm-soc and asoc.

Jean-Christophe was very insistent that the pinctrl stuff got added and
I'd expect he'd be applying the code as he's maintaining that branch (it
doesn't apply in ASoC due to other dependencies) but I've not seen any
response from him since the code was posted.
