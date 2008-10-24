From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 24 Oct 2008 08:56:47 +0100
Message-ID: <49017FBF.4030005@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>	<490088DC.7090205@jasonline.co.uk>
	<s5hzlkv44v7.wl%tiwai@suse.de>	<s5hwsfz44i9.wl%tiwai@suse.de>
	<49009A26.3000201@jasonline.co.uk>	<s5hod1b436i.wl%tiwai@suse.de>
	<s5hljwf42x4.wl%tiwai@suse.de>	<4900A4FA.7020300@jasonline.co.uk>
	<s5h63njw2c0.wl%tiwai@suse.de>	<4900B523.3020801@jasonline.co.uk>
	<s5h8wsf3spl.wl%tiwai@suse.de>	<4900DBBD.2020806@jasonline.co.uk>
	<s5hljwee68t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217]) by alsa0.perex.cz (Postfix) with ESMTP id E1DDB24336
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 09:56:55 +0200 (CEST)
In-Reply-To: <s5hljwee68t.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Thanks.  I guess the problem wa
>> Oct 23 20:45:28 sentry kernel: SBXFI: Allocate SRC 0
>> Oct 23 20:45:28 sentry kernel: SBXFI: allocated TLB at 0 for 16 pages
>> Oct 23 20:45:28 sentry kernel: SBXFI: Setting TLB buffer page 0x1304a000
>> Oct 23 20:45:28 sentry kernel: SBXFI: release TLB at 0 for 16 pages
>> Oct 23 20:45:28 sentry kernel: SBXFI: Disabling TLB buffer
>> Oct 23 20:45:28 sentry kernel: SBXFI: PLAYBACK PREPARE: rate=96000, period_size=1024, buffer_size=16384
>>     
>
> So the stream is started at the state where the TLB is cleared.
> The fix patch is below (and I already committed it).
>
>
> Takashi
>   
Yes that has fixed it.
Tested with mplayer (still needs oss proc fix) and aplay. Both sounded fine.

Jason
