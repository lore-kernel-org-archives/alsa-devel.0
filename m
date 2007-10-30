From: John Dey <jsdey@optonline.net>
Subject: Re: External Sound Card
Date: Tue, 30 Oct 2007 13:46:42 -0400
Message-ID: <7f9e5c7d049a400c4f397c1e821bf542@optonline.net>
References: <cbe89d5f922a06b0d445d95e900f3b22@optonline.net>
	<1193764791.29333.1218639071@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2.srv.hcvlny.cv.net (mta2.srv.hcvlny.cv.net [167.206.4.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AF7224544
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 18:46:45 +0100 (CET)
Received: from robo1.jsdey.com (ool-44c1fb41.dyn.optonline.net [68.193.251.65])
	by mta2.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
	with ESMTP id <0JQQ0013PK1VVX70@mta2.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Tue, 30 Oct 2007 13:46:44 -0400 (EDT)
In-reply-to: <1193764791.29333.1218639071@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Alsa Dev <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your response.  The 5.1 or 7.1 capability is not as 
important to me as having 6 or 8 independent jack channels  to connect 
4 or 8 channels from an application (ambiosonics from aeolus).  Without 
adding the a52 plugin would I see more than 2 outputs in qjackctl?  
With the plugin would I see 6 outputs?


On Oct 30, 2007, at 1:19 PM, Clemens Ladisch wrote:s

> John Dey wrote:
>> I am looking for a external sound card that has spdif (7.1)
>> functioning.
>
> 7.1 encoding is done in software, not in hardware.
> I don't know of any 7.1 encoder for Linux.
>
> ALSA has the a52 plugin that can do 5.1 encoding for any sound
> card that has SPDIF, but you'd have to compile it with the ffmpeg
> library to get it to work.
>
>
> HTH
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
