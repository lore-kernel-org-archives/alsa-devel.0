From: Halim Sahin <halim.sahin@freenet.de>
Subject: Re: a11y: howto reduce latency with alsa's dmix plugin?
Date: Tue, 01 Sep 2009 12:32:27 +0200
Message-ID: <87fxb7j6pw.fsf@freenet.de>
References: <20090823095517.GA27741@halim> <s5hws4k2f1k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id E319F2443C
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 12:32:51 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MiQfR-0005fa-Qn
	for alsa-devel@alsa-project.org; Tue, 01 Sep 2009 12:32:49 +0200
Received: from pd9e0f360.dip.t-dialin.net ([217.224.243.96])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2009 12:32:49 +0200
Received: from halim.sahin by pd9e0f360.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2009 12:32:49 +0200
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

On Mo, Aug 31 2009, Takashi Iwai wrote:

> At Sun, 23 Aug 2009 09:55:18 +0000 (UTC),
> Halim Sahin wrote:
>> 
>> Hello,
>> Is there a way to reduce latency on audiocard if the dmix plugin is in
>> use?
>> I am asking because there is a strange problem with asistive
>> technologies which are outputing through alsa.
>> E. G. speech-dispatcher takes almost a half sec to stop the
>> speech-synthesizer.
>> If the user navigates quickly through menus, there are simultane outputs
>> at a time.
>> (tested with an usb logitech headset, snd-intel8x0 based card,
>> snd-hda-intel).
>> The same problem can be reproduced by running mplayer with alsa output
>> driver and pressing
>> quickly left/right arrow.
>> You should hear several samples at a time.
>> 
>> Using an sblive card which doesn't use dmix doesn't have such problems.
>> 
>> Using the dmix plugin should audio much faster to avoid this problem.
>
> It's a bit hard to guess.  This could be the difference of PCM drain
> implementation between hw and dmix, but a half second is still too
> long.
>
> Could you prepare a small test case to reproduce the buggy behavior?

Yes that's easy:
The following should be tested with active dmix.
1. login to a textconsole
2. mplayer -ao alsa your_favourite_file
3. Press space during playback.

Result: it takes about an half sec to stop the playback.

The second test would be:
1. login to a console
2. mplayer -ao alsa:device=hw=0,0 your_file
3. press space during playback
Result:
The playback stops without delay

Hope you can help.
Thanks for your response
Kind regards
Halim

>
> thanks,
>
> Takashi

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de
