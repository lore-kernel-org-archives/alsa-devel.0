From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Sun, 17 Oct 2010 19:16:31 +0800
Message-ID: <1287314191.1845.14.camel@laptop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010161830.31603.julian@jusst.de>
	<201010162052.03180.julian@jusst.de>
	<201010171253.08023.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp18.singnet.com.sg (smtp18.singnet.com.sg [165.21.6.38])
	by alsa0.perex.cz (Postfix) with ESMTP id D0D27244D8
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 13:16:35 +0200 (CEST)
In-Reply-To: <201010171253.08023.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-10-17 at 12:53 +0200, Julian Scheel wrote:

> With the patch applied the feedback setting works perfectly fine! Now I just 
> need to tweak my feedback loop to behave well.
> But generally asynchronous transmission works as expected now! Thanks a lot 
> for the help!

Hi Julian,

Congrats !!!

I have also been testing Clemens' patch for rate feedback format.  It
works perfectly with the sdr-widget as well, when I set the feedback
format to 16.16 in 4 bytes (which OSX can understand).  So now I can
have one firmware version that works under Linux and OSX.

I'm now working on rate feedback with UAC2.  Clemens thinks the format
under UAC2 should be 16.16, samples per uFrame.  However, I will have to
test with OSX to see whether it is accepting samples per millisec
(Frame) or samples per uFrame (125 microsec).  Whatever OSX uses I will
probably use, as Clemens' patch has automatic format so can take
whatever format OSX uses.

Thanks Clemens for the great patch :-)  OSX should adopt the same
approach :-)

Alex
