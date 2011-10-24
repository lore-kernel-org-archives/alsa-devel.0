From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Use of _hint() functions and older machines
Date: Mon, 24 Oct 2011 12:26:58 +0200
Message-ID: <4EA53D72.3060009@ladisch.de>
References: <4EA0E6E5.1050600@jesup.org> <4EA3EE43.3010904@ladisch.de>
	<4EA4F573.9060704@jesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 31343244DE
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 12:25:47 +0200 (CEST)
In-Reply-To: <4EA4F573.9060704@jesup.org>
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

Randell Jesup wrote:
> On 10/23/2011 6:36 AM, Clemens Ladisch wrote:
> > The best way to get a list of devices would have been to enumerate sound
> > cards with snd_card_next(), then use device names "default:CARD=x".
> > However, this gets only the primary device of each card, there might be
> > sound cards without a PCM device, devices not based on an ALSA kernel
> > driver aren't listed, and the "default:CARD=x" mechanism doesn't work if
> > the user has redefined the "default" device.
> 
> Ugh.  So, there's no reasonable way to get a user-understandable list
> before .14?  How useful was snd_ctl_card_info_get_name()?

That gives you the card name, which is not the same as the name of the
PCM device (although it shouldn't matter when the card has only one
PCM device).

> And I guess I'd need to enumerate the 'devices' and 'subdevices' on
> each card as well...

Yes, but subdevices are typically used for multiple streams that are
mixed together, so you can ignore them.


Regards,
Clemens
