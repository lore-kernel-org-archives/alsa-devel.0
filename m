From: Stephen Hassard <steve@hassard.net>
Subject: Updating Linux kernel 2.5 ALSA from CVS
Date: Wed, 19 Mar 2003 09:20:28 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030319172028.GB19604@www.angio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

I'm trying to update the version of Alsa in the Linux kernel v2.5.65 from CVS.

Their doesn't seem to be any documentation on how to do this the *right* way.

It seems that what one should do is copy the CVS/alsa-kernel directory into your /usr/src/linux/sound directory.

If I do this, I get the following error:

>>
make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/conf
make[1]: `scripts/kconfig/conf' is up to date.
./scripts/kconfig/conf -s arch/i386/Kconfig
file sound/core/Kconfig already scanned?
make: *** [include/linux/autoconf.h] Error 1
>>

It doesn't appear as that "sound/core/Kconfig" is getting included twice.

Does anyone have any tips for doing this properly?

Thanks,
Stephen Hassard


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
