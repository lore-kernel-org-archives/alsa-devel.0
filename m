From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Use of _hint() functions and older machines
Date: Sun, 23 Oct 2011 12:36:51 +0200
Message-ID: <4EA3EE43.3010904@ladisch.de>
References: <4EA0E6E5.1050600@jesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 897BA2460B
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Oct 2011 12:37:30 +0200 (CEST)
In-Reply-To: <4EA0E6E5.1050600@jesup.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randell Jesup <randell1@jesup.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2011 05:28 AM, Randell Jesup wrote:
> On older machines, _hint() aren't available, so even if I make them
> optional to dlsym-loading, I would need some other method to get the
> information I assume using older, now-deprecated-or-gone interfaces.

On older machines, that information wasn't available at all.

The recommendation was to use "default" or to let the user enter
a device name.

The best way to get a list of devices would have been to enumerate sound
cards with snd_card_next(), then use device names "default:CARD=x".
However, this gets only the primary device of each card, there might be
sound cards without a PCM device, devices not based on an ALSA kernel
driver aren't listed, and the "default:CARD=x" mechanism doesn't work if
the user has redefined the "default" device.


Regards,
Clemens
