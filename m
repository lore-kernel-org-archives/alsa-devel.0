From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Hardware events
Date: Tue, 30 Nov 2010 09:08:50 +0100
Message-ID: <4CF4B112.3070705@ladisch.de>
References: <4CF39483.4050704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 55B7C243F1
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 09:06:46 +0100 (CET)
In-Reply-To: <4CF39483.4050704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rolf Theunissen <rolf.theunissen@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rolf Theunissen wrote:
> For some hardware devices (for instance the ThinkPad EC) the volume can
> be changed by (only) hardware buttons.
> ...
> This raises the following question: is it possible to detect the events
> originating from the hardware in the functions that handle the callbacks
> (set via snd_mixer_elem_set_callback/snd_hctl_elem_set_callback)? This
> would allow to implement an OSD that only responds to the hardware
> buttons and that would ignore events originating from "software".

The control notifications are for all changes of the control.

If it is not possible to change the volume in software, then the driver
must not set the control to be writable.


Regards,
Clemens
