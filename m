From: Tony Hoyle <tmh@nodomain.org>
Subject: Re: Getting board to work on 2.6.30
Date: Wed, 24 Jun 2009 03:37:39 +0100
Message-ID: <4A419173.7050809@nodomain.org>
References: <4A40BAA7.2070603@nodomain.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 547AA24660
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 04:37:44 +0200 (CEST)
Received: by fxm26 with SMTP id 26so499116fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2009 19:37:42 -0700 (PDT)
In-Reply-To: <4A40BAA7.2070603@nodomain.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tony Hoyle wrote:
> Hi,
> 
> I'm trying to get sound working on a board I'm working with.  The sound 
> works correctly on 2.6.24.7 but not 2.6.30.
> 
>
OK I found the problem.  At some point the default configuration for the 
STAC92xx was changed and this broke the setup.  A simple patch reverts 
back to the 2.6.24 setting:

--- patch_sigmatel.c.old	2009-06-24 03:33:50.000000000 +0100
+++ patch_sigmatel.c	2009-06-24 03:34:19.000000000 +0100
@@ -1616,7 +1616,7 @@

  static unsigned int ref925x_pin_configs[8] = {
  	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
-	0x90a70320, 0x02214210, 0x01019020, 0x9033032e,
+	0x90a70320, 0x02214210, 0x400003f1, 0x9033032e,
  };

  static unsigned int stac925xM1_pin_configs[8] = {


I have little (well, none actually) understanding of what these values 
to, but presumably it was changed for a reason... is there a case for a 
new model here?  Unfortunately I'm not sure how to detect this model.. 
other ones seem to be done using manufacturer specific codes, but there 
are none on this board...

Tony
