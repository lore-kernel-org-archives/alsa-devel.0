From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Small Regression in midi for M-Audio Fast Track
 Ultra.
Date: Mon, 18 Apr 2011 11:16:08 +0200
Message-ID: <4DAC0158.6090400@ladisch.de>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 73C0C1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 11:14:28 +0200 (CEST)
In-Reply-To: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grant Diffey wrote:
> In 2.6.33/34 when support originally was put in alsa mainline the MIDI ports
> were functional today they're not [...]
> The midi port is interface 3 and has a comment in quirk-table.h like this
> 
>                         /* interface 3 (MIDI) is standard compliant */

Apparently, having no entry for an interface prevents the driver from
looking at this interface at all.

Try replacing the comment with:
			{
				.iface = 3,
				.type = QUIRK_MIDI_STANDARD_INTERFACE
			},


Regards,
Clemens
