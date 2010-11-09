From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HDMI on HDA device=3
Date: Tue, 9 Nov 2010 17:40:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011091739060.29422@eeebox2.perex-int.cz>
References: <4CD95DD9.2070102@canonical.com> <ibbsj9$o50$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 08EEA244A8
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 17:40:29 +0100 (CET)
In-Reply-To: <ibbsj9$o50$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Nov 2010, Mohammad Bahathir Hashim wrote:

> On 2010-11-09, David Henningsson <david.henningsson@canonical.com> wrote:
>> I have seen a few HDMIs which share the HDA controller with the onboard
>> sound card, but the codecs are different, e g the onboard one is at
>> address #0 and the HDMI is at address #3 - or even #3, #7, #8 and #9 in
>> some cases.
>>
>> Now, if the user specifies the device string hdmi:x (where x is card
>> name/number), I'd like it to kind of autodetect this and use DEV=3
>> instead of DEV=0, and without breaking the cards where the hdmi is a
>> separate card with a codec at address #0. However, it still seems like
>> the device is at DEV=3 somehow.
>>
>> Now, looking at /usr/share/alsa/cards/HDA-Intel.conf, I notice that
>> there are entries HDA-Intel.pcm.hdmi.0 which sets DEV=3, so it seems
>> like someone already thought of this. However, just using "hdmi:x" does
>> not trigger "DEV=3". I'm still not grepping all of the alsa lisp
>> architecture stuff, so could someone explain to me how the
>> HDA-Intel.pcm.hdmi.0 entry relates to the "hdmi:x" alsa device string?
>>
>
> I am not sure about Intel HDMI, but, in my case with MacbookPro 6,2
> (15" Mid 2010); the HDMI audio stream via NVIDIA HDMI can only be
> started if I use hw:1,7 (or Mplayer's -ao alsa:device=hw=1.7). No

This should be equal to '-ao alsa:device=hdmi=1.1' (hdmi:1,1 in ALSA 
naming).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
