From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ALSA: mips: avoid potential uninitialized variable use
Date: Mon, 16 Jan 2017 14:26:31 +0100
Message-ID: <CAK8P3a21FY+4S1zONxnE28eVDmmHTcyR5ymiFJ2Y7X-CxZBAMA@mail.gmail.com>
References: <20170116110517.3833976-1-arnd@arndb.de> <s5hd1fnxk6v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd1fnxk6v.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-mips@linux-mips.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 16, 2017 at 1:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 16 Jan 2017 12:04:56 +0100,
> Arnd Bergmann wrote:
>> It's easy enough to avoid by adding a 'default' clause to the switch
>> statements here. I assume that in practice no other case can happen,
>> but adding a default puts us on the safe side and shuts up the warnings.
>
> Well, these cases are logical errors that must not happen, so
> returning an error would be a "safer", IMO.

Agreed. I sent out a v2 now.

    Arnd
