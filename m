From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Strange Problem with snd-hda-intel
Date: Tue, 08 May 2012 16:56:55 +0200
Message-ID: <4FA93437.7000806@ladisch.de>
References: <4FA8FAD9.4060204@formac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6A35224365
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:52:56 +0200 (CEST)
In-Reply-To: <4FA8FAD9.4060204@formac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frank Maik Kittelmann <fkittelmann@formac.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Frank Maik Kittelmann wrote:
> Once a playback is stopped the very last sample is repeated forever.
> The annoying thing is, that this sample always stays for a while
> if we play another sound file. If the sample has been at a high value,
> this leads to a loud noise in the speaker.

Software cannot output two streams at the same time, so this must be
a hardware problem.  If I'd had to guess, I'd point at the NM10.  Have
you tested with another mainboard?


Regards,
Clemens
