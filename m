From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: alsa-utils-1.0.8 make error
Date: Sat, 15 Jan 2005 18:41:59 -0500
Message-ID: <41E9AA47.3040107@zhevny.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I got the following error when attempting to make alsa-utils-1.0.8:

Making all in po
make[2]: Entering directory 
`/home/eric/audio_code/recent_releases/alsa-utils-1.0.8/alsaconf/po'
mv: cannot stat `t-ja.gmo': No such file or directory
make[2]: *** [ja.gmo] Error 1
make[2]: Leaving directory 
`/home/eric/audio_code/recent_releases/alsa-utils-1.0.8/alsaconf/po'

this patch to alsa-utils-1.0.8/alsaconf/po/Makefile.in lets it compile 
... but, I don't understand what I've done:


--- Makefile.in 2005-01-15 18:27:52.000000000 -0500
+++ Makefile.in.ok      2005-01-15 18:29:25.000000000 -0500
@@ -24,19 +24,15 @@
  MSGMERGE_UPDATE = @MSGMERGE@ --update

  DISTFILES = $(POFILES) Makefile.in
-CATALOGS = $(POFILES:.po=.gmo)
+CATALOGS = $(POFILES:.po)

  all: $(CATALOGS)

-.SUFFIXES: .po .gmo .mo
+.SUFFIXES: .po .mo

  .po.mo:
         $(MSGFMT) -c -o t-$@ $< && mv t-$@ $@

-.po.gmo:
-       @lang=`echo $* | sed -e 's,.*/,,'`; \
-       rm -f $${lang}.gmo && $(GMSGFMT) -c --statistics -o 
t-$${lang}.gmo $${lang}.po && mv t-$${lang}.gmo $${lang}.gmo
-
  $(DOMAIN).pot: $(GETTEXT_SRC)
         $(XGETTEXT) -o$@ --default-domain=$(DOMAIN) \
           --add-comments=TRANSLATORS: --language=Shell \



-Eric Rz.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
