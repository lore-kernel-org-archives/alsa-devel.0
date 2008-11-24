From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Advice requested for developing C01U support via
	snd-usb-audio
Date: Mon, 24 Nov 2008 17:24:18 +0000
Message-ID: <200811241724.18768.maillist@superlative.org>
References: <200811221920.23616.maillist@superlative.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from virtuser.com (unknown [77.92.93.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 22F6F103816
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 18:24:22 +0100 (CET)
Received: from [82.152.152.239] (helo=asmodeus.superlative.org)
	by apollo.safeukdns.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <maillist@superlative.org>)
	id 1L4fAa-0001jn-0U
	for alsa-devel@alsa-project.org; Mon, 24 Nov 2008 17:24:20 +0000
In-Reply-To: <200811221920.23616.maillist@superlative.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday 22 November 2008 19:20:23 Keith A. Milner wrote:
> Hi,
> New to this mailing list so please go easy on me. I've been reading through
> the Alsa docs, wiki, and still not sure of the best approach, so looking
> for advice from the experts.
>
> I'm looking to develop support for the Samson C01U USB studio microphone.

<SNIP>

OK, looking at the source I'm probably going to take the following approach:

>
> a) Patch the existing snd-usb-audio driver with some vendor-specific code
> for this devices (and others which will be similar, like the C03U)

Looking at this it appears the appropriate parts of the device "discovery" and 
configuration is achieved in usbmixer.c with mixer_ctl_feature_info being 
hwere the device attributes are set.

I also note there are some overrides in usbquirks.h but these seem to be 
overriding channel types and capabilities, as well as applying Vendor and 
Product names. I also have a Behringer UCG102 and may contribute a quirks 
section for that which gives it a better name and, possibly, tweaks some 
channel settings).

For the C01U I'm going to focus my efforts in understanding the usbmixer code. 
I suspect I may have to create a new control with a vendor-specific override 
in snd_usb_create_mixer, similar to the snd_audigy2nx_controls setup.

If I'm barking up the wrong tree, or if there's a better way to do this that 
anyone can suggest, I would appreciate the feedback.

In the mean time I need to work out how to build the dev environment...

Cheers,

-- 
Keith A. Milner
