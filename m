From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: wrong channel mappings for HDMI audio
Date: Thu, 11 Nov 2010 07:58:34 +0100
Message-ID: <4CDB941A.7020606@ladisch.de>
References: <87fwv8puuo.fsf@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9C8FE2440E
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 07:56:42 +0100 (CET)
In-Reply-To: <87fwv8puuo.fsf@uwo.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Christensen <jdc@uwo.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dan Christensen wrote:
> When I try to use 5.1 audio over HDMI, the front left and front right
> channels are correct, but the others are wrong:
> ...
> asound.conf:
> 
> pcm.!default {
> type hw
> card 0
> device 3
> }

With this definition, you are disabling ALSA's channel mapping.

Try this:

  pcm.!default pcm.hdmi

or just tell you applications to use the device "hdmi".


Regards,
Clemens
