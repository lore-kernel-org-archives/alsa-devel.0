From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RESENT] [PATCH - Fix Fast Track Ultra series:
 44.1/88.1 kHz 1/Fix playback/capture issues and related	chrashes at 44100
 Hz and 88200 Hz for M-Audio Fast Track Ultra series.
Date: Fri, 03 Sep 2010 16:26:51 +0200
Message-ID: <4C8105AB.10802@ladisch.de>
References: <4C32E3B2.5080707@web.de> <4C7E1376.9030208@web.de>
	<s5hk4n4zgrn.wl%tiwai@suse.de> <4C7F6A9B.5010707@ladisch.de>
	<20100902091649.GK17833@buzzloop.caiaq.de>
	<4C7F86EC.3080604@ladisch.de>
	<20100903133414.GS17833@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E44CD244B3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Sep 2010 16:26:19 +0200 (CEST)
In-Reply-To: <20100903133414.GS17833@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> On Thu, Sep 02, 2010 at 01:13:48PM +0200, Clemens Ladisch wrote:
> > I've got several reports that devices no longer work since UAC2 support got
> > added.  But I've just noticed this is not related to the interface class
> > but to the interface protocol: the new code added checks for UAC_VERSION_1
> > or _2, but real devices apparently write just random junk into this field.
> > (For vendor-specific interfaces, they are actually justified to do so.)
> 
> Grr. So what about cases where this "random junk" is 0x20 by coincidence?

Actually, it isn't too random: I've seen 0xff (obviously "vendor-
specific") and 0x01/0x02 (interface subclass moved to protocol).


Regards,
Clemens
