From: James Wright <james@jigsawdezign.com>
Subject: SND_PCM_ASYNC - why???
Date: Sat, 17 Jan 2004 11:26:45 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040117112645.1c9dce19.james@jigsawdezign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from loki.a-q.co.uk (loki.a-q.co.uk [195.224.50.15])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA04057
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2004 12:28:17 +0100
Received: from neutrino.jigsawdezign.int (cpc1-hatf2-6-0-cust204.lutn.cable.ntl.com [81.109.147.204])
	by loki.a-q.co.uk (Custom (aq) mailer/8.9.3) with SMTP id i0HBLMp06725
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2004 11:21:22 GMT
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Dev <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

  I'm doing much better with ALSA now that i spent a coule of days messing with code. I've got both direct
MMAP PCM playback and a fallback using normal write access with no problems. However, i've
just written in asyncronous notification support and found that if i use the SND_PCM_ASYNC flag in snd_pcm_open()
and then setup my callback function with snd_async_add_pcm_handler(), then the callback function is not called!
When i remove the SND_PCM_ASYNC flag it works fine, so is this flag/mode redundant? 

Thanks,
James



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
