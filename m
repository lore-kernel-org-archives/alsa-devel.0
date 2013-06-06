From: Daniel Mack <zonque@gmail.com>
Subject: Generic clock divider indices
Date: Thu, 06 Jun 2013 15:44:04 +0200
Message-ID: <51B09224.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id A36C5261ACC
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 15:43:37 +0200 (CEST)
Received: by mail-wi0-f181.google.com with SMTP id hi5so367226wib.2
 for <alsa-devel@alsa-project.org>; Thu, 06 Jun 2013 06:43:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Liam,

we're using generic ASoC platform code for some audio devices, which is
agnostic of the actual Codecs that it deals with, as the information is
provided by DT nodes only.

That works very well so far, but I'm now facing a case where I need to
pass a special clock divider information down to the codec driver. The
fact that the IDs of the dividers can be arbitrarily defined by the
drivers leads to the unfortunate situation that I now have to make the
platform code aware of the codec drivers again.

Would it be an idea to define some commonly used dividers in the core?
If they start at 0x80000000, they won't collide with existing ones, and
we could simply add them as alternative case statements to existing drivers.

Some commonly used ones I can think of are

	MCLK / BCLK
	MCLK / LRCLK
	BCLK / LRCLK

That way, platform code could just pass the values dows to the codec
drivers, whether or not they know what to do with it.

What do you think?


Daniel
