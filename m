From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Event or signal for microphone connect/disconnect
Date: Wed, 27 Jul 2011 14:11:40 +0200
Message-ID: <4E30007C.2050709@ladisch.de>
References: <CAGTuRxMnK9xA2t=0vsqczteRu+bp5NxG9DTxUVxx9gK-htF6FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E34AF2438B
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 14:08:01 +0200 (CEST)
In-Reply-To: <CAGTuRxMnK9xA2t=0vsqczteRu+bp5NxG9DTxUVxx9gK-htF6FA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Putinei Ionut <putineiionut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Putinei Ionut wrote:
> Is there any way to receive events/signal that the microphone on the mic
> port is connected/disconnected.

If supported by the hardware and the driver, such jack connection
events are reported through an input device (/dev/input/*).  The
input device interface is somewhat documented at the end of
linux/Documentation/input/input.txt.


Regards,
Clemens
