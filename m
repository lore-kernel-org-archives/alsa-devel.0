From: tmika@t-online.de (Thorsten Mika)
Subject: Strange crackling noises
Date: Fri, 14 Jan 2005 09:24:00 +0100
Message-ID: <1CpMkT-10g39s0@fwd07.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: ALSA-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello list,

I hope this (and not ALSA-user) is the right place for my question, so
pls let me know if it isn't.

I have to deal with a strange, but reproducable effect since the
beginning of my linux audio experiences. It worsened it the last months,
and up to now it almost leaves important programs unusable for me
(ZynAddSubFX, MusE). After I had first thought that it was a JACK
problem, I found a way to produce it without JACK.

The effect is some crackling noise, which appears under load when for
example MusE plays ZynAddSubFX, but you can easily reproduce it in a
more simple manner:

1. Start ZynAddSubFX
2. Select the "Soft Piano 1" sound.
3. Open the "Virtual Keyboard" (vK)
4. Move fast from left to right and back on the white keys, and after a
short while you will hear this crackling.

My hardware: Duron 1GHz, 512MB RAM, SBLive rev07 (says lspci)
My software: Linux 2.4.23-ck1, ALSA 1.0.8, ZynAddSubFX 2.1.1

Any hint what to do about this? Lee Revell suggested (on the
jackit-devel list) that this might be a driver error.

Thanks in advance,

  t.

-- 
Thorsten Mika                                  mailto: tmika@t-online.de
Muenster / Germany                        +49 - (0) 251 - 200 76 83

Public Key ID: 41338C37 -- http://www.keyserver.net


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
