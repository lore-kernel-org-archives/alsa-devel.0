From: Gabriele Melia <gabmelia84@msn.com>
Subject: Broken playback
Date: Wed, 21 Nov 2007 09:46:22 +0100
Message-ID: <BLU107-W438E9F5D7EFEF18ED543BDC1780@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s5.blu0.hotmail.com (blu0-omc3-s5.blu0.hotmail.com
	[65.55.162.159]) by alsa0.perex.cz (Postfix) with ESMTP id EAA3E2483F
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 09:46:23 +0100 (CET)
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


Hi All,
 
i'm new so sorry in advance if i do any errors.
 
I have integrated my hw decoder inside ffmpeg that is working fine, but while playing through alsa the sound comes broken in the sense that it is playing for 3 seconds, stops for 1 plays again for 3 sec and stop again and so on.
 
How I can delay the palyback in order to accumulate some decoded buffers to prevent this and to not afflict the decoder when playback is stopping?
 
Thanks,
Gabriele
_________________________________________________________________
Scarica GRATIS le emoticon della tua squadra del cuore e il calendario di serie A!
http://www.emoticons-livemessenger.com/pages/msnitcalcio/index.htm
