From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Issue with Alsa and PulseAudio
Date: Tue, 26 Aug 2008 23:13:03 +0100
Message-ID: <g91v5f$qe6$1@ger.gmane.org>
References: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>	<g9171a$jko$1@ger.gmane.org>	<s5hd4jvlrlr.wl%tiwai@suse.de>
	<48B423AD.4090601@colin.guthr.ie>
	<BAY102-W254533A08D3B13E0989D028A660@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D9EC24507
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Aug 2008 00:13:18 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KY6mp-00029N-Dw
	for alsa-devel@alsa-project.org; Tue, 26 Aug 2008 22:13:15 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 22:13:15 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 22:13:15 +0000
In-Reply-To: <BAY102-W254533A08D3B13E0989D028A660@phx.gbl>
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

Ash wrote:
> Thanks Colin, Takashi.
> 
> The thing is, I've noticed other applications such as aplay or amarok
> call the same function and not exhibit the same behavior. That's why
> I am  not sure what I am doing wrong.

Well amarok presumably uses xine... aplay tho' is probably more 
interesting. I presume you are passing the same values etc. as e.g. aplay?

> 
> Also intersetingly enough, if I do not use the "default"
> ALSA_DEVICE_DEFAULT, and instead use "front" (which I believe is
> direct access to alsa driver, whereas "default" goes through
> pulseaudio), strange things happen. For example, setting a rate or
> channels returns -22 Invalid Argument.

Don't use "front", you should use "default". "front" will only exist on 
some sound hardware AFAIK, and in the case that the user has selected 
their "default" device to route through pulseaudio, you should respect this.

I'm sure there is probably a technical reason why "front" does not let 
you set rate or channels (probably because it represents the front 
speakers system of a multi-channel setup), but I'm sure someone more 
familiar with the API will be able to enlighten you :)

> I am not sure if I need to change or upgrade alsa. I just want to get
> to the bottom of this with existing pulseaudio/alsa since other
> players seem to work.

Indeed. If aplay is calling this function and works via pulseaudio, then 
it stands to reason so should you!

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
