From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-utils: utils: Make default
	sample files be in	/usr/share/sounds/alsa
Date: Tue, 28 Nov 2006 13:58:32 +0100
Message-ID: <m2slg3ybgn.fsf@vador.mandriva.com>
References: <ALOGGER1164558323.59@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <ALOGGER1164558323.59@alsa-project.org> (James Courtier-Dutton's
	message of "Sun\, 26 Nov 2006 17\:25\:23 +0100 \(CET\)")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton <James@superbug.demon.co.uk> writes:

> changeset:   842:0e388f696ac2fc0729067d1f7e2f75a4bd5aa312
> tag:         tip
> user:        james
> date:        Sun Nov 26 16:24:59 2006 +0000
> files:       configure.in po/ja.po
> description:
> utils: Make default sample files be in /usr/share/sounds/alsa

(...)

it looks like you commited unrelated stuff (which killed 2 strings, me
not knowing if it's ok or not):

> diff -r cbb44d7eeab8d8f0c69add0a5df57455408bae20 -r 0e388f696ac2fc0729067d1f7e2f75a4bd5aa312 po/ja.po
> --- a/po/ja.po	Mon Nov 06 17:27:50 2006 +0100
> +++ b/po/ja.po	Sun Nov 26 16:24:59 2006 +0000
> @@ -8,7 +8,7 @@ msgstr ""
>  msgstr ""
>  "Project-Id-Version: alsa-utils 1.0.9a\n"
>  "Report-Msgid-Bugs-To: \n"
> -"POT-Creation-Date: 2006-04-18 15:51+0200\n"
> +"POT-Creation-Date: 2006-11-11 10:45+0000\n"
>  "PO-Revision-Date: 2006-04-18 15:51+0200\n"
>  "Last-Translator: Takashi Iwai <tiwai@suse.de>\n"
>  "Language-Team: Japanese\n"
> @@ -17,11 +17,11 @@ msgstr ""
>  "Content-Transfer-Encoding: 8bit\n"
>  "Plural-Forms: nplurals=1; plural=0;\n"
>  
> -#: aplay/aplay.c:129
> +#: aplay/aplay.c:128
>  msgid "raw data"
>  msgstr "raw データ"
>  
> -#: aplay/aplay.c:130
> +#: aplay/aplay.c:129
>  msgid "VOC"
>  msgstr "VOC"
>  

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
