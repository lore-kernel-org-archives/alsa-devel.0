From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: finally, ALSA 1.0.24 is out
Date: Mon, 31 Jan 2011 16:46:30 +0000
Message-ID: <1296492390.3316.207.camel@odin>
References: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 431C624604
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 17:46:35 +0100 (CET)
Received: by wwe15 with SMTP id 15so5758554wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 08:46:34 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101311605240.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-31 at 16:16 +0100, Jaroslav Kysela wrote:

> * alsa-library
>    - Use Case Manager
> * alsa-utils
>    - alsaloop and alsaucm introduction
>    - alsactl improvements

:)

Btw, any plans to add a basic configure.in, makefile.am, etc to
alsa-ucm-conf.git in order to depend on alsa-lib >= 1.0.24 ?

I could do this at the weekend, although I'm no autotools expert. I'm
thinking all we need is a simple check for alsa-lib version and then to
install the UCM config files in the alsa install directory. Anything
else ?

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
