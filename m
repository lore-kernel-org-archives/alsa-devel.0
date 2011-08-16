From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio questions
Date: Tue, 16 Aug 2011 17:46:23 +0200
Message-ID: <4E4A90CF.9040004@ladisch.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>	<1313432124-22591-2-git-send-email-lars@metafoo.de>	<4E4A100D.9020302@ladisch.de>
	<CACTFLAOYfJ4eoHfGEaGdjoLijPPzsThrq_kh8So0phoy6fmEGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 2ECF6244A8
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 17:46:28 +0200 (CEST)
In-Reply-To: <CACTFLAOYfJ4eoHfGEaGdjoLijPPzsThrq_kh8So0phoy6fmEGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Tue, Aug 16, 2011 at 8:37 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Pierre-Louis Bossart wrote:
>>> - Is there any good reason why the max number of packets per urb defaults to
>>> 8?
>>
>> Not really.  It is an attempt to compromise between interrupt frequency
>> and the latency resulting from packet queueing.
> 
> Ah, I thought there is a limit of frames per urb that is the same than
> subframes per packet on USB. That's not the case then?

URBs are a Linux-defined data structure; they can be arbitrarily long
(as long as you don't reach the undocumented limit of how far in the
future the HCD can schedule packets).

> Wouldn't it be possible to not count what we submitted but look at the
> playback packets that return from the HCD and move the hwptr there?
> That information is presumably closer to the actual hardware position
> than the time when we queue.

In this case, the "hardware position" is the read pointer in ALSA's ring
buffer, which must be incremented whenever data is moved from there into
the URBs' buffers.


Regards,
Clemens
