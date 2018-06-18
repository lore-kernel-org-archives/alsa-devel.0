From: "Sommer, Roman" <roman.sommer@fau.de>
Subject: Re: [PATCH 1/3] sound/line6: checkpatch: fix block comment style
Date: Mon, 18 Jun 2018 13:56:42 +0200
Message-ID: <6dd9eb6c3dc6d57eb140696bed4e4a6c@fau.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
 <1529317779-15908-2-git-send-email-roman.sommer@fau.de>
 <20180618112134.GA4289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180618112134.GA4289@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@i4.cs.fau.de, Daniel Graefe <daniel.graefe@fau.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, =?UTF-8?Q?Hans_P=2E_M=C3=B6ller_Eb?= =?UTF-8?Q?ner?= <hmoller@uc.cl>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Fabi=C3=A1n_Inostroza?= <soulsonceonfire@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2018-06-18 13:21, Greg Kroah-Hartman wrote:
> On Mon, Jun 18, 2018 at 12:29:37PM +0200, Roman Sommer wrote:
>> CC: Jaroslav Kysela <perex@perex.cz>
>> CC: Takashi Iwai <tiwai@suse.com>
>> CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
>> CC: Kees Cook <keescook@chromium.org>
>> CC: Kate Stewart <kstewart@linuxfoundation.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
>> CC: Bhumika Goyal <bhumirks@gmail.com>
>> CC: Philippe Ombredanne <pombredanne@nexb.com>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: alsa-devel@alsa-project.org
>> CC: linux-kernel@vger.kernel.org
>> 
>> This patch fixed the style of multiline comments in sound/usb/line6.
> 
> Why is all of those cc: lines in the changelog body?
> 
> Very odd...
> 
> greg k-h

Hi Greg,

Sorry for the mess-up here, they were meant for the header only.

I used a newline to group people in the patches which I now know I 
should
not do.


Roman
