From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: Logical device name for 4-channel microphones?
Date: Wed, 25 Apr 2012 16:11:28 +0300
Message-ID: <1335359488.2257.24.camel@laptop>
References: <1335011052.2268.18.camel@laptop> <4F96B3ED.3070007@ladisch.de>
	<s5h4ns943x8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 04744104925
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 15:11:31 +0200 (CEST)
In-Reply-To: <s5h4ns943x8.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-04-24 at 16:09 +0200, Takashi Iwai wrote:
> At Tue, 24 Apr 2012 16:08:45 +0200,
> Clemens Ladisch wrote:
> > 
> > Tanu Kaskinen wrote:
> > > My problem is that I'd like to make Pulseaudio handle 4-channel webcam
> > > microphones[2], but I'm not aware of any input device names for
> > > 4-channel devices. Are there such device names?
> > 
> > These device name are useful only for device types that are generic
> > enough.  Four-channel microphones aren't.
> 
> Hm, we have already surround51 or such specific one, so it's not too
> bad to have a definition for multi-channel mics.  OTOH, surround51 &
> co were the possible cause of confusions, as there are way too many
> surround types.  A generic type with the channels argument might be
> more generic?
> 
> In anyway, I think it's fine to define some new generic name.

Alright then, what should be the name? Here's one proposal:
"4channelinput".

-- 
Tanu
