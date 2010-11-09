From: Mohammad Bahathir Hashim <bahathir@gmail.com>
Subject: Re: HDMI on HDA device=3
Date: Tue, 9 Nov 2010 16:24:09 +0000 (UTC)
Message-ID: <ibbsj9$o50$1@dough.gmane.org>
References: <4CD95DD9.2070102@canonical.com>
Reply-To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 16D04244A4
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 17:24:22 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PFqzd-00043J-Q8
	for alsa-devel@alsa-project.org; Tue, 09 Nov 2010 17:24:21 +0100
Received: from 118.101.18.113 ([118.101.18.113])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 17:24:21 +0100
Received: from bahathir by 118.101.18.113 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 17:24:21 +0100
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

On 2010-11-09, David Henningsson <david.henningsson@canonical.com> wrote:
> I have seen a few HDMIs which share the HDA controller with the onboard 
> sound card, but the codecs are different, e g the onboard one is at 
> address #0 and the HDMI is at address #3 - or even #3, #7, #8 and #9 in 
> some cases.
>
> Now, if the user specifies the device string hdmi:x (where x is card 
> name/number), I'd like it to kind of autodetect this and use DEV=3 
> instead of DEV=0, and without breaking the cards where the hdmi is a 
> separate card with a codec at address #0. However, it still seems like 
> the device is at DEV=3 somehow.
>
> Now, looking at /usr/share/alsa/cards/HDA-Intel.conf, I notice that 
> there are entries HDA-Intel.pcm.hdmi.0 which sets DEV=3, so it seems 
> like someone already thought of this. However, just using "hdmi:x" does 
> not trigger "DEV=3". I'm still not grepping all of the alsa lisp 
> architecture stuff, so could someone explain to me how the 
> HDA-Intel.pcm.hdmi.0 entry relates to the "hdmi:x" alsa device string?
>

I am not sure about Intel HDMI, but, in my case with MacbookPro 6,2
(15" Mid 2010); the HDMI audio stream via NVIDIA HDMI can only be
started if I use hw:1,7 (or Mplayer's -ao alsa:device=hw=1.7). No
sound if I starts with 1,3. But, after started stream to 1,7; then, I
can use 1,3. 

So, in this, I always started with 1,7. Since I can change the HDMI
device ID on-demand with MPlayer, I have no issue with default ALSA
configuration. :)


Thank you.
