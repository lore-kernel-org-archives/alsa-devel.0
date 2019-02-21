From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Regarding alsa-utils commit "alsaucm: add alsa-ucm
 udev rules for PAZ00 (Toshiba AC100/Dynabook AZ)."
Date: Thu, 21 Feb 2019 12:51:19 +0200
Message-ID: <c915e9cd989b40647458078a702847260a6998da.camel@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22BF9F80658
 for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2019 11:51:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I'm updating alsa-utils in OpenEmbedded, and I noticed that there's a
new udev rules file, 89-alsa-ucm.rules. It seems to just initialize the
mixer settings for particular hardware (Toshiba AC100/Dynabook AZ), and
doing that in alsa-utils seems weird. Why does this hardware use a udev
rules file for initialization, unlike any other hardware?

I think it would be good to have an explanatory comment in the rules
file.

-- 
Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk
