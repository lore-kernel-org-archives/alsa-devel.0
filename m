From: Wayne <shhuango@hotmail.com>
Subject: to get the detail information of a codec
Date: Wed, 12 Nov 2008 07:17:06 +0000
Message-ID: <BAY107-W168CB3AE4BEA6D898AB65BCE140@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s41.bay0.hotmail.com (bay0-omc2-s41.bay0.hotmail.com
	[65.54.246.177]) by alsa0.perex.cz (Postfix) with ESMTP id BC9002435F
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 08:17:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi all,
 
Now I'm writing a program which can list some capabilities of my
codec, such as what rates and formats my codec supports.
By typing 'cat /proc/asound/card0/codec#0', you can see the
detail of your card. I want to write a program which can show
these information by alsa-lib. However, I couldn't find a function
in alsa-lib which can tell me the formats and rates. Is there a
way to get this detail?
By the way, my card is intel-hda and the codec is alc268.
 
Another question is I've seen the word "element" in many
function, such as snd_ctl_event_elem_get_device. What
"element" means in alsa world? I couldn't find any artile
mentioning it!!!
 
Thanks all!!!
Wayne
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=windows+vista&mkt=en-US&form=QBRE
