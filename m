From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Thu, 19 May 2011 14:23:04 +0200
Message-ID: <4DD50BA8.4080003@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>	<4DD413FC.2090808@showlabor.de>	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>	<s5hhb8r1c20.wl%tiwai@suse.de>
	<4DD4BC97.5090702@showlabor.de>	<s5h39kb17bv.wl%tiwai@suse.de>
	<4DD4D162.20608@showlabor.de>	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 4893E103818
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 14:23:09 +0200 (CEST)
In-Reply-To: <BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,


Am 19.05.2011 13:05, schrieb Daniel Mack:
> On Thu, May 19, 2011 at 10:52 AM, Daniel Mack<zonque@gmail.com>  wrote:
>> I'll have a look later. I was just under the impression you wanted to
>> try yourself :)
> Attached is a patch which should show how this could work. It won't be
> fully functional though, as there seems to be some sort of confusion
> in your patch.

Thanks! I don't have the device here with me right now. I can try the 
patch in an hour or two !


> You're calling build_named_mixer_unit_ctl() with your
> loop variable "in_ch", but you ignore that value in the called
> function. That can't be intentional, can it?

No, this isn't intentional. I wrote this in September, so I don't 
remember completely. But a glimpse at the code reveals that this is 
inherited from build_mixer_unit_ctl() which doesn't use the in_pin 
parameter either.

Back then I wanted both functions to be as closely related as possible, 
with the perspective to put them on a common base or let 
build_mixer_unit_ctl() actually call build_named_mixer_unit_ctl(). Most 
probably I later confused the in_pin parameter's (non-)meaning.

> Anyway, very little tweaking should be needed now to make this work,
> and if you send me back the modified patch, I'll split the work and
> post a patch set here.

I'll send all the needed corrections.

Regards,

Felix
