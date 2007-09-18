From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] ad1838/cs4231 -- fix MCE timeout upon
 initial load
Date: Tue, 18 Sep 2007 13:03:42 +0200
Message-ID: <46EFB08E.3010308@gmail.com>
References: <46E58D01.9080809@gmail.com>
	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>
	<46EF18FF.7070906@gmail.com> <46EF3097.7060300@gmail.com>
	<46EF52E4.90401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070505070708050904060102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2423B2446B
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 13:04:41 +0200 (CEST)
In-Reply-To: <46EF52E4.90401@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070505070708050904060102
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 09/18/2007 06:24 AM, Rene Herman wrote:

> And here's the others in that changeset, against current hg. As far as

One more inside isa/.

Signed-off-by: Rene Herman <rene.herman@gmail.com>

--------------070505070708050904060102
Content-Type: text/plain;
 name="schedule_timeout-fixes-one-more.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule_timeout-fixes-one-more.diff"

diff -r 0028e39ead78 isa/sscape.c
--- a/isa/sscape.c	Tue Sep 18 00:52:38 2007 +0200
+++ b/isa/sscape.c	Tue Sep 18 13:01:55 2007 +0200
@@ -401,7 +401,7 @@ static int obp_startup_ack(struct sounds
 		unsigned long flags;
 		unsigned char x;
 
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));

--------------070505070708050904060102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070505070708050904060102--
