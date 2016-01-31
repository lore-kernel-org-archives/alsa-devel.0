From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Meaning of the name 'hinawa' and the intension
Date: Sun, 31 Jan 2016 20:44:17 +0900
Message-ID: <56ADF391.7090901@sakamocchi.jp>
References: <56ADEF9C.50303@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <56ADEF9C.50303@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: hayashi@clear-code.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

Hi,

After published libhinwa, I sometimes got a question about the name
of 'hinawa'. Here, I describe it to the persions who are curious.

At first, I split:
FireWire = Fire + Wire

(Japanese/Chinese translation in the meaning)
-> U+706B[0] + U+7E04[1] (in ISO/IEC 10646)

(Japanese translation in the pronounciation)
-> Hi + Nawa

Actually, the meaning of 'Nawa' is near rope. In Japanese history, Hinawa
was used to fire musket guns introduced in Sengoku period, so the musket
gun is called as Hinawa-ju (Ju means general guns). I think there'is a
word in European culture corresponding to the hi-nawa, but I don't know it.

I select this name because in general the name of library (soname) must
be unique in a system. In my case, I judged it better to pick up words
from non-European language group.

[0] U+706B
http://www.unicode.org/cgi-bin/GetUnihanData.pl?codepoint=706b
[1] U+7E04
http://www.unicode.org/cgi-bin/GetUnihanData.pl?codepoint=7e04


Regards

Takashi Sakamoto

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
