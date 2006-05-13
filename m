From: Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH] Fix a memory leak in pdaudiocf
Date: Sat, 13 May 2006 23:44:25 +0200
Message-ID: <200605132344.25862.jesper.juhl__17975.9902916432$1147557542$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99454193
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2006 23:43:29 +0200 (MEST)
Received: by nf-out-0910.google.com with SMTP id l35so185177nfa
        for <alsa-devel@alsa-project.org>; Sat, 13 May 2006 14:43:28 -0700 (PDT)
Content-Disposition: inline
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Jesper Juhl <jesper.juhl@gmail.com>
List-Id: alsa-devel@alsa-project.org

There's a potential memory leak in 
sound/pcmcia/pdaudiocf/pdaudiocf.c::pdacf_config()

If we leave via one of the *failed: labels we may leak 'parse', so add a 
kfree(parse) to the end of the function and also make sure to set 'parse' 
to NULL after the kfree() call a little further up so we don't do a 
double-free of the pointer if we hit one of the *failed: labels after the 
first kfree().

Since I don't have the hardware I can't test the patch beyond making sure 
it compiles cleanly, but I feel pretty confident that it is correct.

Please consider for inclusion.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/pcmcia/pdaudiocf/pdaudiocf.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-git2-orig/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-05-13 21:28:55.000000000 +0200
+++ linux-2.6.17-rc4-git2/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-05-13 23:27:46.000000000 +0200
@@ -226,7 +226,7 @@ static int pdacf_config(struct pcmcia_de
 
 	snd_printdd(KERN_DEBUG "pdacf_config called\n");
 	parse = kmalloc(sizeof(*parse), GFP_KERNEL);
-	if (! parse) {
+	if (!parse) {
 		snd_printk(KERN_ERR "pdacf_config: cannot allocate\n");
 		return -ENOMEM;
 	}
@@ -242,6 +242,7 @@ static int pdacf_config(struct pcmcia_de
 	link->conf.ConfigBase = parse->config.base;
 	link->conf.ConfigIndex = 0x5;
 	kfree(parse);
+	parse = NULL;
 
 	CS_CHECK(RequestIO, pcmcia_request_io(link, &link->io));
 	CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
@@ -257,6 +258,7 @@ cs_failed:
 	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);
+	kfree(parse);
 	return -ENODEV;
 }
 





PS. Please keep me on Cc when replying since I'm not subscribed to alsa-devel.



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
