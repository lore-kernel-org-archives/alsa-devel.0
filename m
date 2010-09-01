From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Audio Driver -- too much data,
 coming in two quickly
Date: Wed, 1 Sep 2010 17:19:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009011717351.10278@eeebox2.perex-int.cz>
References: <loom.20100901T153508-926@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 86ECC2417E
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 17:19:23 +0200 (CEST)
In-Reply-To: <loom.20100901T153508-926@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brett Bolen <bbolen@extron.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 1 Sep 2010, Brett Bolen wrote:

> How can I figure out what is happening, or fix this problem?  Any 
> suggestions? any similar problems fixed lately?  Is there a way I can 
> get the current ring buffer pointers ( either from driver or 
> application?)

The xrun_debug should help you to see the problem with the PCM ring buffer 
pointer in the driver side:

http://www.alsa-project.org/main/index.php/XRUN_Debug

Try value 27 and look for big hw_ptr changes.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
