From: Frank.Uepping@t-online.de (Frank Uepping)
Subject: Tropez+
Date: Mon, 11 Mar 2002 19:05:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C8CF1D2.405ED85F@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I have tried to compile the Wavefront soundcard driver
(alsa-driver-0.9.0beta12) but without success.
My configuration is: `--prefix=/usr/local --with-debug=detect
--with-isapnp=no
--with-sequencer=no  --with-oss=no --with-cards=wavefront.`
I use a standard (kernel.org) 2.2.20 kernel.

Following happens:
.../alsa-kernel/isa/wavefront/wavefront.c tries to include a file
linux/isapnp.h, but there is no
such file with the standard 2.2.x kernel!

I tried also to compile `--with-isapnp=yes' and it completes, but
`depmod -e snd-isapnp.o'
complains about the unresolved symbol `release_resource`!

By the way, can someone tell me the status of the driver --
I want to develop a real-time PCM application, is the driver prepared
for that yet?

(P.s.:  All was fine with alsa-driver-0.5.12a.
But I have to upgrade because the 0.5.x API became obsolete.)

Best regards
    FAU



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
