From: Paul Davis <pbd@op.net>
Subject: Re: 1869 trouble with snd-es18xx
Date: Thu, 27 Jun 2002 10:10:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206271408.g5RE8VD25834@post2.fast.net>
References: <3D1B0307.8080002@303.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 27 Jun 2002 14:20:23 +0200."
             <3D1B0307.8080002@303.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kasper Souren <kasper@303.nu>
Cc: alsa devel <alsa-devel@lists.sourceforge.net>, abramo@alsa-project.org, fishbach@pool.informatik.rwth-aachen.de
List-Id: alsa-devel@alsa-project.org

>Isn't there any option to use a 'virtual' ALSA device? Like snd-pcm-oss, but 
>then the other way around. snd-oss-pcm module? Then you could use ALSA with 
>a working OSS driver, and no working ALSA driver...

ALSA has a significantly different internal architecture than OSS. It
is not possible to use an OSS driver to support the ALSA "midlevel"
code.

--p


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
