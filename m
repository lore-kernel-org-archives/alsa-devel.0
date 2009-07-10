From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: save alsa buffer
Date: Fri, 10 Jul 2009 16:31:48 +0700
Message-ID: <c697747b0907100231p363e654lbcb9bce14f14a667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 31FBD2459D
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 11:31:51 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id l33so187163rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2009 02:31:49 -0700 (PDT)
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

Hi,

I am trying to save content of alsa buffer to file for playing it in
Matlab.I choose Matlab for prototyping. I run full duplex ALSA based on code
from
http://www.bel.fi/~alankila/blog/2005/08/21/Full Duplex
ALSA.html<http://www.bel.fi/%7Ealankila/blog/2005/08/21/Full%20Duplex%20ALSA.html>

I run alsa on Beagleboard. I want to save buffer content to a file, but it
failed with error: Segmentation fault when reach fclose(fp).
I want to know what kind of data that ALSA processes so I can implement my
LPC vocoder.

Thank you.

Best regards,

Arif
