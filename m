From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Possible bug in alsa-lib. snd_pcm_hw_params_get_periods_max()
 returning 512 instead of 2.
Date: Fri, 11 Jun 2004 15:26:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C9C104.4010909@superbug.demon.co.uk>
References: <Pine.HPX.4.33n.0406101844520.3148-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C8964249
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2004 16:26:20 +0200 (MEST)
In-Reply-To: <Pine.HPX.4.33n.0406101844520.3148-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> James Courtier-Dutton wrote:
> 
>>If the application opens the device with "plug:front".
>>That will print the message: -
>>Periods range from 0 to 512
>>
>>I thought that this should have printed: -
>>Periods range from 2 to 2
> 
> 
> Try without "plug:".
> 
> 
> HTH
> Clemens
> 
> 

Without the "plug:" I get
Periods range from 2 to 2

So without the "plug:", the function calls returns correctly.
I cannot think of any circumstances where doing sample rate conversion 
(using the "plug:" plugin) would change the amount of periods.
Is this a bug in the "plug:" plugin ?

James




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
