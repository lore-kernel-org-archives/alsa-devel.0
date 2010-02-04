From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: ALC268 - Driving mute led with GPIO
Date: Thu, 04 Feb 2010 19:04:50 +0200
Message-ID: <4B6AFE32.2040009@pardus.org.tr>
References: <4B6AF980.40207@pardus.org.tr> <s5hsk9hymje.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id EBFD1103824
	for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2010 18:04:47 +0100 (CET)
In-Reply-To: <s5hsk9hymje.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 04 Feb 2010 18:44:48 +0200,

> 
> This can be rather controlled in a different way, such as GPIO.
> 
> For example, if it's a HP machine, usually one of GPIO line
> corresponds to the mute LED (sometimes it mutes the speaker via
> BIOS).
> 

Um, that was what I thought and tried to ask too :)

So how should I proceed to make it work upon mutes? There are 4 GPIO lines and the last one seems to control
the mute LED but it doesn't mute the speaker.

Can it be done asynchronously with a callback which will send 1/0 to the GPIO channel on every mute/unmute?

Or should that be done synchronously in the code where the mute/unmute verbs are executed?

There are currently mute LED handlings only in sigmatel for some HP laptops which parses DMI data for the
exact GPIO channel.

If there are any other examples in the ALSA stack, that would be helpful too.

Regards,
