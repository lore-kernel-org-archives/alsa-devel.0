From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Kernel module build workflow (Re: Logitech USB
 headset not working in 3.6-rc3)
Date: Mon, 27 Aug 2012 19:22:02 +0200
Message-ID: <CAFz=ag47OU1GbS-a8GUug4bJ04JA6kn_uBUZ0LiBjzUCJ0fN_w@mail.gmail.com>
References: <20120824190808.GC20043@zod.bos.redhat.com>
 <5038007E.5060505@gmail.com> <20120825111749.GA17048@wolff.to>
 <20120825115423.GA14327@wolff.to> <5038BEEB.6090303@gmail.com>
 <20120825120740.GA19539@wolff.to>
 <20120825121326.GE20043@zod.bos.redhat.com>
 <20120825121621.GA24462@wolff.to> <s5h1uit95yr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B59B265E69
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 19:22:03 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so8274579obb.38
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 10:22:02 -0700 (PDT)
In-Reply-To: <s5h1uit95yr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Bruno Wolff III <bruno@wolff.to>, alsa-devel@alsa-project.org, Josh Boyer <jwboyer@redhat.com>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Am 26.08.2012 14:46 schrieb "Takashi Iwai" <tiwai@suse.de>:

>
> Actually you don't have to rebuild the whole kernel at all just for
> debugging this usb-audio bug.  The workflow below is what I do often
> for debugging a driver problem on a distro kernel.[...]



> [...]

If you want to take back to the original module, just remove updates
> module directory and run depmod again.  Pretty convenient, eh?
>
>
 Could you please put this somewhere on alsa-project.org?

Thanks,

Felix
