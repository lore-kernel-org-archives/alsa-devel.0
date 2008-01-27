From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC v2 driver structure
Date: Sun, 27 Jan 2008 14:15:45 -0500
Message-ID: <9e4733910801271115w576fcd61pec8a5586138744c5@mail.gmail.com>
References: <9e4733910801270845i58b41269s708cb1ee58e7eba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id F0DD3244FC
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 20:15:46 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2477926wag.8
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 11:15:45 -0800 (PST)
In-Reply-To: <9e4733910801270845i58b41269s708cb1ee58e7eba8@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 1/27/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm trying to write an asoc v2 driver for my powerpc based SOC
> (mpc5200) hardware. We have two audio devices on the board, a WM8580
> and a TAS5504.  How do you do this with asoc v2? The card is created
> in snd_soc_machine_create(); there seems to be an assumption of a
> single card per machine.
>
> Or are you supposed to mix the different devices into a single pcm
> driver? What would happen in pxa2xx-pcm.c if more than one of these
> were defined?

I guess I'm supposed to have multiple platform drivers - one per
I2C/AC97/SSC channel?

-- 
Jon Smirl
jonsmirl@gmail.com
