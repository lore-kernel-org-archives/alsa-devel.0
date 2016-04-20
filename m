From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: GPIO control from ALSA
Date: Wed, 20 Apr 2016 10:33:47 +0200
Message-ID: <57173EEB.5040403@metafoo.de>
References: <571737E4.5030908@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id B7351261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 10:33:48 +0200 (CEST)
In-Reply-To: <571737E4.5030908@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/20/2016 10:03 AM, Petr Kulhavy wrote:
> Hello,
> 
> I'm writing a driver for ASoC "sound card" hardware which uses CPU GPIO to
> mute/unmute an analogue amplifier and another GPIO to control an analogue
> switch for line/mic switching. Is there an abstraction in ALSA to model this
> kind of hardware?

There is no abstraction. Use controls and/or DAPM and the standard GPIO API,
if you grep the sources you'll find a few examples of drivers using GPIOs to
mute amplifiers and similar (e.g. qi_lb60).

- Lars
