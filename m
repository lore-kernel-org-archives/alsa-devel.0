From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: config bug with sbawe and --with-isapnp=no
Date: Fri, 23 Jan 2004 11:26:38 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401231123400.1875@pnote.perex-int.cz>
References: <200401221249.07577.loritz@fh-furtwangen.de>
 <200401231113.35085.loritz@fh-furtwangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401231113.35085.loritz@fh-furtwangen.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mario Loritz <loritz@fh-furtwangen.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Jan 2004, Mario Loritz wrote:

> Hello list,
> 
> I reproduced the error message while the driver is loading:

Could you try the patch bellow?

					Jaroslav

Index: pnp.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/support/pnp/pnp.h,v
retrieving revision 1.4
diff -u -r1.4 pnp.h
--- pnp.h	5 Sep 2003 17:44:12 -0000	1.4
+++ pnp.h	23 Jan 2004 10:25:28 -0000
@@ -186,7 +186,7 @@
 
 #define pnp_resource_change(resource, start, size) isapnp_resource_change(resource, start, size)
 
-#if defined(CONFIG_PNP)
+#if defined(CONFIG_PNP) && (!defined(ALSA_BUILD) || defined(CONFIG_PNP_KERNEL))
 
 struct pnp_dev * pnp_request_card_device(struct pnp_card_link *clink, const char * id, struct pnp_dev * from);
 void pnp_release_card_device(struct pnp_dev * dev);

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
