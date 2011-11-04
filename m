From: Anders Gnistrup <agn@datarespons.dk>
Subject: Re: need some workarround or explanation.
Date: Fri, 4 Nov 2011 12:48:12 +0100
Message-ID: <C516192DA6D2B74F8192CDC209D958FD5832E6F181@dr-mail>
References: <C516192DA6D2B74F8192CDC209D958FD5832E6F17F@dr-mail>,
	<4EB3D087.5090202@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.datarespons.com (mailgw01.datarespons.com
	[81.0.189.39]) by alsa0.perex.cz (Postfix) with ESMTP id 648F6247E2
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 12:49:12 +0100 (CET)
In-Reply-To: <4EB3D087.5090202@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

The snd_pcm_open call.
If I call the program after 10sec after i have plugged in the headset, there is no problem.

Anders

________________________________________
From: Clemens Ladisch [clemens@ladisch.de]
Sent: Friday, November 04, 2011 12:46 PM
To: Anders Gnistrup
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] need some workarround or explanation.

Anders Gnistrup wrote:
> I have a USB headset, where when plugged in, a volume setting is set on
> playback and capture channels using the ctl interface for the device.
> After the volume is set I open the capture interface. but I have i have
> a 2-3 sec. delay that i just don't understand.

What is delayed?


Regards,
Clemens
