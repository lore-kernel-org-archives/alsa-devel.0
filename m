From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: Re: emu10k1 MIDI record
Date: Tue, 15 Feb 2005 20:41:24 +0200
Message-ID: <S14073AbVBOSlY/20050215184124Z+12060@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


MIDI-in requires "enable_ir=1" in modules conf.
Both MIDI-in and the infra red remote controls comes
through the MIDI device.

options snd-emu10k1 extin=0x3fc3 extout=0x1fff enable_ir=1

Juhana
-- 
  http://music.columbia.edu/mailman/listinfo/linux-graphics-dev
  for developers of open source graphics software


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
