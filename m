From: Florian Bomers <Florian.Bomers@sun.com>
Subject: [Fwd: use new API ?]
Date: Mon, 11 Nov 2002 14:00:11 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD0286B.9E49DD86@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Please apologize for the repetition of my question. I probably don't have to
tell you that in commercial software engineering I have to deal with hard
dead-lines and longer development and test cycles. I guess most of you don't
even care... but I think it would be a pity for many people if Sun's Java still
wouldn't support ALSA in the next years, just because I did not choose the
0.9.0-compatible way.

If there are other reasons why answers were pretty rare to my following
question, please tell me. Being a OSS developer myself I know that commitment is
unpopular (and "urgent" requests even more so), but then I'd appreciate at least
to hear that you don't have any plans for 0.9.0rc5's compatibility with future
versions.

--------

Is it more likely that 

1) the already changed function prototypes, which are usable 
  by defining ALSA_PCM_NEW_HW_PARAMS_API, change in future,
or
2) that the deprecated functions will be removed ?

I am talking here e.g. of  snd_pcm_hw_params_get_period_size()

Are there any incompatibilities likely from 0.9.0rc5 to 0.9.0FCS ?

Thanks,
Florian



-------- Original Message --------
Subject: [Alsa-devel] save to use new API ?
Date: Mon, 04 Nov 2002 11:38:41 -0800
From: Florian Bomers <Florian.Bomers@Sun.COM>
Organization: Sun Microsystems, Inc.
To: ALSA devel <alsa-devel@lists.sourceforge.net>

Hi,

if I released a program now in binary form, is it safer to use the new function
prototypes of alsa-lib by defining ALSA_PCM_NEW_HW_PARAMS_API or better use the
old, deprecated ones ?

My program compiles with or without, and I'd prefer to use the new API, but I
noticed that when I compile against rc5, it doesn't even run with rc4, so I fear
that my binary compiled against rc5 won't run with later versions of ALSA lib.

Thanks for letting me know.
Florian

-- 
Florian Bomers
Java Sound
Java Software/Sun Microsystems, Inc.
http://java.sun.com/products/java-media/sound/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
