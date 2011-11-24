From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Opening a PCM device in shared mode
Date: Thu, 24 Nov 2011 18:31:54 +0100
Message-ID: <3fd61e9d-1751-4294-b627-ea45fedd0d54@email.android.com>
References: <4EC8C046.4030706@gmail.com>
	<C516192DA6D2B74F8192CDC209D958FD5834F34861@dr-mail>
	<4ECA31FA.60002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 52A7F103E65
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:32:04 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 6955821372
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 12:32:03 -0500 (EST)
In-Reply-To: <4ECA31FA.60002@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sayem Ahmed <sayem64@gmail.com>, Anders Gnistrup <agn@datarespons.dk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sayem Ahmed wrote:
>Also, when I try to run the example program on different rate (i.e., 
>rate 8000, channel 1) it throws an error saying format doesn't match.

The "default" device for your hardware should have
the plug plugin on top of the dmix plugin.

>Actually the whole point of my exploration is this - I want to display
>a 
>list of available audio cards/devices in my system to my application 
>user who will then select the input and output audio card to 
>record/playback audio data accordingly.

This is the job of the desktop environment.
Is there a reason why your application needs to
duplicate this?


Regards,
Clemens
