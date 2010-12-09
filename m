From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Gigabyte 880GM-USB3 MIDI and Dolby 5.1/7.1 issues
Date: Thu, 09 Dec 2010 14:03:25 +0100
Message-ID: <4D00D39D.2090001@ladisch.de>
References: <AANLkTimb5AnPm13d0kpMmjq4nOTH0dXA_VyO2CXbr_bQ@mail.gmail.com>	<4D00C2EA.1060204@ladisch.de>
	<AANLkTikTKQkQqAMddajMHCk1trj=4ncvnbOMLbB-Ctjo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 084F4103CAC
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 14:01:34 +0100 (CET)
In-Reply-To: <AANLkTikTKQkQqAMddajMHCk1trj=4ncvnbOMLbB-Ctjo@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Gardner <jgardner@jonathangardner.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jonathan Gardner wrote:
> On Thu, Dec 9, 2010 at 3:52 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Jonathan Gardner wrote:
>>> First, with my older motherboard, I could control the various output
>>> and input levels of the channels. With this motherboard, I only have
>>> one channel "Internal Audio Analog Stereo".
>>
>> This looks like PulseAudio's idea of a user-friendly abstraction.
>> Try "alsamixer -D hw:0".
> 
> Beautiful. That's what I'm looking for.
> 
> So should I work with PulseAudio to get their GUI working with my
> particular situation?

I'm not sure if your situation is one that PA actually wants to handle.


Regards,
Clemens
