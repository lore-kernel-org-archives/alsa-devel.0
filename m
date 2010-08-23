From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Fix front mic on Dell Precision
 M6500
Date: Mon, 23 Aug 2010 21:25:55 +0200
Message-ID: <4C72CB43.2040800@canonical.com>
References: <4C72C5EF.6090600@canonical.com> <1282590450.2600.9.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id F3D8E24399
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Aug 2010 21:26:02 +0200 (CEST)
In-Reply-To: <1282590450.2600.9.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

I admit that the best thing would be to make the driver support all
three mics, but at this point, the alsa driver can only support two, one
called "mic" and one called "front mic". I believe the best choice is to
select the internal mic as "front mic" and the mic jack on the laptop as
"mic", thus leaving the docking station mic jack non-functional.

The behavior without this patch is to select the mic jack on the laptop
as "mic" and the mic on the docking station as "front mic", thus leaving
the internal mic non-functional in all cases, and that regardless of you
have a docking station or not.

2010-08-23 21:07, Jerone Young skrev:
> For laptops you would want to take preference of the docking jack over
> the interal mic if you are in a docking station.
> 
> So if you do plug into a docking station and you have a microphone in
> the docking station, a user would want to use that over the internal
> microphone. You wouldn't want the laptop internal mic preferred over the
> docking station microphone.
> 
> 				Thanks,
> 					Jerone
> 
> On Mon, 2010-08-23 at 21:03 +0200, David Henningsson wrote:
>> The BIOS of Dell Precision M6500 lists both 0x0e and 0x11 as
>> front mics, and the driver only supports one front mic. This
>> commit adds a quirk for preferring node 0x11 (internal mic) to
>> node 0x0e (possibly docking station mic).
>>
>> Alsa-info reference:
>> http://launchpadlibrarian.net/54232083/alsa-info.txt.xyFVpIysHt
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
