From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: need some workarround or explanation.
Date: Fri, 04 Nov 2011 17:38:04 +0100
Message-ID: <4EB414EC.8090404@ladisch.de>
References: <C516192DA6D2B74F8192CDC209D958FD5832E6F17F@dr-mail>,
	<4EB3D087.5090202@ladisch.de>
	<C516192DA6D2B74F8192CDC209D958FD5832E6F181@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id ACF76248DC
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 17:37:13 +0100 (CET)
In-Reply-To: <C516192DA6D2B74F8192CDC209D958FD5832E6F181@dr-mail>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anders Gnistrup <agn@datarespons.dk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Anders Gnistrup wrote:
> The snd_pcm_open call.

Strange, because that part of the driver doesn't access the device at
all, and shouldn't be able to wait.

Could you use strace to check which system call has the delay?


Regards,
Clemens
