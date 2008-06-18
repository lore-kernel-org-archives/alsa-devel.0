From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: ALSA 1.0.17rc2 release
Date: Wed, 18 Jun 2008 23:53:05 +0200
Message-ID: <20080618235305.bddd8fa2.pochini@shiny.it>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id E71161037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 23:55:25 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 16 Jun 2008 11:24:22 +0200 (CEST)
Jaroslav Kysela <perex@perex.cz> wrote:

> Hello all,
> 
> 	ALSA 1.0.17rc2 packages (except tools, oss, python - no changes) 
> were released and are available for download on ALSA server.

Just like rc1, it doesn't compile the powermac driver (Linux Jay 2.6.25 #1
SMP Sat Apr 26 00:55:22 CEST 2008 ppc 7455, altivec supported PowerMac3,6
GNU/Linux). The patch below fixes the problem, but I'm not sure it's the
right fix.


--- acinclude.m4__orig	2008-06-18 22:33:27.000000000 +0200
+++ acinclude.m4	2008-06-18 23:07:21.000000000 +0200
@@ -1914,8 +1914,9 @@ alsa_check_kconfig_option () {
     fi
   fi
     if  ! ( test "$CONFIG_M68K" = "y" -o "$CONFIG_M68K" = "m" ) &&
-      ( test "$CONFIG_PPC64" = "y" -o "$CONFIG_PPC64" = "m" ) ||
-      ( test "$CONFIG_PPC32" = "y" -o "$CONFIG_PPC32" = "m" ); then
+      (( test "$CONFIG_PPC64" = "y" -o "$CONFIG_PPC64" = "m" ) ||
+      ( test "$CONFIG_PPC32" = "y" -o "$CONFIG_PPC32" = "m" ) ||
+      ( test "$CONFIG_PPC" = "y" -o "$CONFIG_PPC" = "m" )); then
       CONFIG_SND_PPC="y"
     fi
   if alsa_check_kconfig_card "powermac"; then


--
Giuliano.
