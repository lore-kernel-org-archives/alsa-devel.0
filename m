From: Florian Bomers <Florian.Bomers@sun.com>
Subject: use new API ?
Date: Wed, 06 Nov 2002 09:18:29 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC94EE5.398AA22B@sun.com>
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

Sorry for re-posting, especially if the answer is already "in the queue".

I reformulate the question:

Is it more likely that 

- the already changed function prototypes, which are usable by defining
ALSA_PCM_NEW_HW_PARAMS_API, change in future, or
- that the deprecated functions will be removed ?

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
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
