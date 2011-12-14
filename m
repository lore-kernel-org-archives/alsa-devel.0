From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Capture from 3+ cards connected to a USB hub -
 distorted samples
Date: Wed, 14 Dec 2011 13:19:00 +0100
Message-ID: <4EE89434.9040609@ivitera.com>
References: <4EE29877.2050804@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 75F37103822
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 13:19:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 41DFFA1A40B07
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 13:18:59 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k4igvPgsF62k for <alsa-devel@alsa-project.org>;
	Wed, 14 Dec 2011 13:18:59 +0100 (CET)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 2D3D1A1A32346
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 13:18:59 +0100 (CET)
In-Reply-To: <4EE29877.2050804@ivitera.com>
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


Dne 10.12.2011 00:23, Pavel Hofman napsal(a):
> Hi,
> 
> I have been informed about the following problem which I was able to 
> reproduce afterwards:
> 
> * Latest git.alsa-project.org drivers
> 
> * USB 2.0 hub, 3 or more USB soundcards (inexpensive USB sticks, USB 
> audio v.1 types, async capture, adaptive playback) hooked to the hub, 
> identified A, B, C, D.
> 
> * NONE of these soundcards is playing back
> 
> Now:
> 
> * Card A begins microphone capturing (mono 48/16), result OK
> 
> * Card B begins capturing (mono 48/16), both results still OK
> 
> * As soon as the third card C begins capturing, the signal captured from 
>   cards A and B gets distorted. Audacity shows some samples are 
> incorrect, distorting the expected sine waveform of the testing signal. 
> I can provide screenshots as well as recorded samples, if needed.
> 
> * The signal recorded from card C is OK.
> 
> BUT
> 
> * If any card hooked to the HUB is playing back (even a fourth one D), 
> the distortion does not occur. It happens only when there is no playback 
> stream going through the hub. Traffic on another USB port has no effect, 
> in fact the test signal for the three cards was provided by a 
> multichannel USB card hooked to another USB port.
> 
> It seems to me as if blocks of samples for each card in the USB frame 
> sometimes overlap by a few bits, corrupting the neighbouring card 
> samples, or are recovered incorrectly.
> 
> I understand I have provided no real data, I am ready to do so plus any 
> tests you would consider useful.
> 
> Thanks a lot for suggestions of the next debugging steps I should do.
> 

Hi, please may I ask for help? I think we could fix this likely bug.

Thanks a lot,

Pavel.
