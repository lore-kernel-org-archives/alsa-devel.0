From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: matrix is complete again
Date: Thu, 25 Nov 2004 09:25:31 +0100 (CET)
Message-ID: <XFMail.20041125092531.pochini@shiny.it>
References: <Pine.LNX.4.58.0411241128580.2062@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8B2E625A
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2004 09:25:28 +0100 (MET)
In-Reply-To: <Pine.LNX.4.58.0411241128580.2062@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 24-Nov-2004 Jaroslav Kysela wrote:

>       I've finished the soundcard matrix conversion to XML.
> The format of XML files is described here:
>
> http://www.alsa-project.org/alsa-doc/cards/README

There is a typo in this file, which is the source of the
errors in the file I sent you:


--- README.old  Thu Nov 25 09:18:17 20
+++ README      Thu Nov 25 09:18:43 2004
@@ -27,7 +27,7 @@
     <link>http://www.mycompany.com/soundcard.html</link>
   </product>
   <chip>
-    <name>DSP0001</chip>
+    <name>DSP0001</name>
     <link>http://www.dsp0001.com/products/dsp0001.html</link>
   </chip>
 </device>


How can I set the link in the "Details(module)" field ?  Since
the driver is not on CVS yet, I would like to make it point to
my page.


--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
