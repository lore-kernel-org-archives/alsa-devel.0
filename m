From: Anders Torger <torger@ludd.luth.se>
Subject: RME DIGI96 ADAT input selection bug fix
Date: Tue, 1 Jul 2003 20:14:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307012014.59778.torger@ludd.luth.se>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: stefan mueller <s.mueller@computer.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Stefan Mueller found a bug in my Digi96 driver. Sometimes I write != 
when I mean == or the other way around:

--- rme96.old.c 2003-07-01 20:13:40.000000000 +0200
+++ rme96.new.c 2003-07-01 20:13:26.000000000 +0200
@@ -1318,7 +1318,7 @@
        snd_pcm_set_sync(substream);

        runtime->hw = snd_rme96_capture_adat_info;
-        if (snd_rme96_getinputtype(rme96) != RME96_INPUT_ANALOG) {
+        if (snd_rme96_getinputtype(rme96) == RME96_INPUT_ANALOG) {
                 /* makes no sense to use analog input. Note that analog
                    expension cards AEB4/8-I are RME96_INPUT_INTERNAL */
                 return -EIO;



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
