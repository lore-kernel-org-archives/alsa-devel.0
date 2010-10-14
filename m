From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 12:27:38 +0200
Message-ID: <201010141227.38510.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B05924392
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 12:27:40 +0200 (CEST)
In-Reply-To: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lee188@singnet.com.sg
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 10:47:06 schrieb lee188@singnet.com.sg:
> As I have found out, it is not necessary to have the same EP number for IN
> and OUT for rate feedback to work with a Linux or OSX host.  This may be a
> requirement for Vista/Win7 hosts though.  We are still doing testing.

Hi Alex,

thanks a lot! You made my day (c:
Using EP5 for feedback makes it working. So I now get the data out even in 
async mode. Currently I have a problem left that channel assignment jumps here 
and then. Probably a buffering issue...
Also neither a SRC4192  (sample rate converter) nor a PCM1794 (dac) seem to be 
able to understand what I am sending right now... Not sure why. Looking at the 
measurements it really looks like a proper I2S signal.

Seems you implement something quite similiar as I do. How did you design the 
measurement for actual feedback data to provide? Following the suggestion in 
the spec?

Regards,
Julian
