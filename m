From: d binderman <dcb314@hotmail.com>
Subject: Linux kernel 2.6.32.3 bug report
Date: Thu, 14 Jan 2010 09:04:46 +0000
Message-ID: <BLU108-W18CA5E21987A7358A506A9C6A0@phx.gbl>
References: <BLU108-W27682899250D440C060CCE9C6D0@phx.gbl>,
	<24570AF61BB706468FA3869A991A4321057CB6A8EA@EXCMB1.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s21.blu0.hotmail.com (blu0-omc3-s21.blu0.hotmail.com
	[65.55.116.96]) by alsa0.perex.cz (Postfix) with ESMTP id 9EC52103859
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 10:04:47 +0100 (CET)
In-Reply-To: <24570AF61BB706468FA3869A991A4321057CB6A8EA@EXCMB1.wolfsonmicro.main>
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



Hello there,

I just ran the sourceforge tool cppcheck over the source
code of the Linux kernel 2.6.32.3

It said

[./sound/soc/s3c24xx/s3c24xx-pcm.c:128]: (error) Possible null pointer dereference: substream - otherwise it is redundant to check if substream is null at line 130

I checked the source code and I agree with the compiler.
Suggest code rework.


Regards

David Binderman

 		 	   		  
_________________________________________________________________
Do you have a story that started on Hotmail? Tell us now
http://clk.atdmt.com/UKM/go/195013117/direct/01/
