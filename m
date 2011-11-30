From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Tests of the hda-jack branch
Date: Wed, 30 Nov 2011 09:05:35 +0100
Message-ID: <4ED5E3CF.8030009@canonical.com>
References: <4ED535CA.1080108@canonical.com>
	<CAN8cciY42ifiBKQ1jDz76GHi0NeHNSgAD1KptuXedxfrgnd=YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9A2D2245AD
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 09:05:37 +0100 (CET)
In-Reply-To: <CAN8cciY42ifiBKQ1jDz76GHi0NeHNSgAD1KptuXedxfrgnd=YA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/30/2011 03:43 AM, Raymond Yau wrote:
> 2011/11/30 David Henningsson<david.henningsson@canonical.com>:
>> Hi Takashi,
>>
>> I've done some more tests of your branch now, and the new names seems to
>> work for my machine here.
>>
>> I'm attaching two patches - one adds a "device index" for mapping against
>> pcm devices on HDMI, the other one is a backport for the driver-build tree.
>>
>> What are your thoughts on how to proceed, when do you think this is ready to
>> be merged into the topic/hda branch?
>>
>> // David
>>
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=Documentation/sound/alsa/HD-Audio-Controls.txt
>
> Does it handle "Independent HP" ?

Not currently, my patch is concerned with HDMI only.
You're correct in that if "Independent HP" is on, it wouldn't hurt for 
the Headphone jack to also have such a device index.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
