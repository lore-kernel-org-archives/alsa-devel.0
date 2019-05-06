From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Subject: Re: Right internal speaker and internal microphone
 doesn't seem to work
Date: Mon, 6 May 2019 10:40:46 +0200
Message-ID: <20190506084046.GA397@xn--80adja5bqm.su>
References: <CACxsoGr1we7usowgT6zReJWSu9=AfhMYQgRjHJD-ja1zCSz3rQ@mail.gmail.com>
 <20190425164657.GA22452@xn--80adja5bqm.su>
 <s5h7ebemvlo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id 72CBDF8962A
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 10:40:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7ebemvlo.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Drago Praznik <dragopraznik@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Sun, Apr 28, 2019 at 09:34:27AM +0200, Takashi Iwai wrote:
> > Perhaps we should try via the kernel bugtracker, but I'd appreciate if
> > someone could hint users like us to a place where problems like these
> > could be addressed.
> 
> Well, the ML itself is right, but there is not many things the
> developers can help remotely.  This is a very vendor-specific stuff,
> no generic problem, hence it's only the hardware vendor who knows how
> to fix the problem (most likely some missing extra initialization).
> Alternatively, you can do trial-and-error by yourself, e.g. applying
> the existing quirks via model option or fiddling with the pin
> configurations via hdajackretask.

do you know if there is a way to extract those assignments from the
Widows driver/look them up with some tool from a booted Windows system? 
I understand that the pin descriptions/IDs or whatever are read from the 
hardware, so in theory they should match and provide the missing info?

I still have the harddisk with Win7 that was originally in this notebook, so
I could mount it and give it a try if I knew what to do.

Then you noted, that there is not much you could do remotely - would access
to the system help?

Kind regards,
Jin
