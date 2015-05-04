From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Tue, 05 May 2015 01:28:34 +0200
Message-ID: <554800A2.2050008@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
 <553EB55D.4060701@gmx.com> <s5hlhhc3hiy.wl-tiwai@suse.de>
 <55400DF4.2080309@gmx.com> <s5hpp6nf41g.wl-tiwai@suse.de>
 <5540FBFF.6020904@gmx.com> <s5h8uda93pf.wl-tiwai@suse.de>
 <55416BEE.5090003@gmx.com> <s5hvbge6u4x.wl-tiwai@suse.de>
 <5546B501.7050207@gmx.com> <s5hbni0ikyl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 65FEA260688
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 01:28:26 +0200 (CEST)
Received: from [192.168.69.6] ([82.60.106.78]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M5csW-1Z9RfV3YpE-00xYGm for
 <alsa-devel@alsa-project.org>; Tue, 05 May 2015 01:28:26 +0200
In-Reply-To: <s5hbni0ikyl.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/05/2015 14:30, Takashi Iwai wrote:
> At Mon, 04 May 2015 01:53:37 +0200,
> Gabriele Martino wrote:
>> Finally got it.
>> I'm not sure about overriding the BIOS configuration: there is a new
>> version which fixes all the unconnected pins.
>> There is only a small issue: the internal speakers are now marked as
>> "Line out", which seems to mess up the "Ports" section in Pulseaudio.
> Hm, this can be changed via a proper pin config?
Sure, that's why I attached hda-jack-retask.fw.
> In anyway, I'm traveling in this week and next week, so cannot debug
> the things.  Will check it later once when I back from vacation.  Just
> ping me.
Enjoy your vacation, I'll try to tidy up the code and make a decent
patch in the meanwhile.

Regards,
Gabriele
