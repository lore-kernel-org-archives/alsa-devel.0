From: Christian Esken <c.esken@cityweb.de>
Subject: snd_ctl_open()
Date: Fri, 18 Apr 2003 18:19:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200304181819.42994.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hello,

I have a littel problem with snd_ctl_open().
Actually I have no idea what to pass as second parameter. I know I can use 
"default", but how can I find out the valid names of the other non-default 
sound devices.

I would have looked at the docs, but there are none:

The PDF on the Website has no snd_ctl_open() documented.

The docs in the CVS are wrong - they  are missing the crucial parameter:
<FUNCDEF>int<FUNCTION>snd_ctl_open</FUNCTION></FUNCDEF>
<PARAMDEF>snd_ctl_t **<PARAMETER>handle</PARAMETER></PARAMDEF>
<PARAMDEF>int<PARAMETER>card</PARAMETER></PARAMDEF>


I thought I might use the value returned by snd_card_get_name(), but this does 
not work.

If anybody can enlighten me and/or update the documentation I will be glad. 
Anything would help, if you say either amixer or alsamixer shows a good 
example I will take this as reference.

Chris



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
