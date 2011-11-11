From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with bluetooth headset and "aplay -l"
Date: Fri, 11 Nov 2011 16:01:31 +0100
Message-ID: <4EBD38CB.6010301@ladisch.de>
References: <C516192DA6D2B74F8192CDC209D958FD5833F9EE5B@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id A969510382A
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 16:01:35 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 32A3F21138
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 10:01:33 -0500 (EST)
In-Reply-To: <C516192DA6D2B74F8192CDC209D958FD5833F9EE5B@dr-mail>
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
> I have a wired problem.

Bluetooth is wireless.  :o)

> I can pair, and connect a bluetooth headset using bluez-simple-agent and bluez-test-audio, no problem.
> I kan also record and play using aplay/arecord -D bluetooth.
> 
> But i can list the device in "aplay -l" og "aplay -L".
> My gees is that I am missing a ctl interface or a kernel module.

"aplay -l" lists kernel drivers, while "aplay -L" list devices for which
there is a name hint entry in the alsa-lib configuration files.

The bluetooth audio driver itself is not a kernel driver (it's a user
space plugin), and, apparently, its configuration file does not define
name hints.


Regards,
Clemens
