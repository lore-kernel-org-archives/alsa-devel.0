From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [Pkg-alsa-devel] Bug#658760: alsactl -h advertises
 non-existent command "names"
Date: Mon, 6 Feb 2012 13:30:05 +0100
Message-ID: <20120206123004.GA2520@samweis.home.lxtec.de>
References: <20120205211832.GA32488@home.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
	[176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id 1D99D103ABE
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 13:30:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120205211832.GA32488@home.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yann Dirson <ydirson@free.fr>, 658760@bugs.debian.org
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

forwarded 658760 alsa-devel@alsa-project.org
tags 658760 patch
thanks

* Yann Dirson [120205 22:18 +0100]:

> Package: alsa-utils
> Version: 1.0.24.2-4
> Severity: normal
> 
> # alsactl -h
> Usage: alsactl <options> command
> 
> [...]
> 
> Available commands:
>   store   <card #> save current driver setup for one or each soundcards
>                    to configuration file
>   restore <card #> load current driver setup for one or each soundcards
>                    from configuration file
>   init    <card #> initialize driver to a default state
>   names   <card #> dump information about all the known present (sub-)devices
>                    into configuration file (DEPRECATED)
> 
> 
> Not only that command is deprecated, but it appears it does not exist
> any more.

Patch attached

Elimar


-- 
  Numeric stability is probably not all that
  important when you're guessing;-)

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="alsactl_help_fix.diff"

diff -Naurd alsa-utils-1.0.24.2.orig/alsactl/alsactl.c alsa-utils-1.0.24.2/alsactl/alsactl.c
--- alsa-utils-1.0.24.2.orig/alsactl/alsactl.c	2011-01-31 15:19:55.000000000 +0100
+++ alsa-utils-1.0.24.2/alsactl/alsactl.c	2012-02-06 13:21:27.144746908 +0100
@@ -68,8 +68,6 @@
 	printf("  restore <card #> load current driver setup for one or each soundcards\n");
 	printf("                   from configuration file\n");
 	printf("  init	  <card #> initialize driver to a default state\n");
-	printf("  names   <card #> dump information about all the known present (sub-)devices\n");
-	printf("                   into configuration file (DEPRECATED)\n");
 }
 
 int main(int argc, char *argv[])

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--opJtzjQTFsWo+cga--
