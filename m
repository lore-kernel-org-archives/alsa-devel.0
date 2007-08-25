From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [1/4] 2.6.23-rc3: known regressions v3
Date: Sat, 25 Aug 2007 14:34:40 +0200
Message-ID: <46D021E0.9070003@m3y3r.de>
References: <46CF177B.4090608@googlemail.com> <3db1ec7f0708241142g30c53633s68987379d1953455@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933746AbXHYMfU@vger.kernel.org>
In-Reply-To: <3db1ec7f0708241142g30c53633s68987379d1953455@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan N. Zlatev" <contact@i-nz.net>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Ivan N. Zlatev schrieb:
> On 8/24/07, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>   
>> ALSA
>>
>> Subject         : Master volume control broken
>> References      : http://lkml.org/lkml/2007/8/18/46
>> Last known good : ?
>> Submitter       : Thomas Meyer <thomas@m3y3r.de>
>> Caused-By       : Ivan N. Zlatev <contact@i-nz.net>
>>                   commit 5d5d3bc3eddf2ad97b2cb090b92580e7fed6cee1
>> Handled-By      : ?
>> Status          : unknown
>>     
> In the meanwhile if you want to use your "fancy multimedia control
> keys" as a workaround you could try to bind your multimedia keys to
> execute:
> volume up: amixer -q set PCM 10%+
> volume down: amixer -q set PCM 10%-
>
>   
I have these key bindings in the .Xmodmap file

keycode 174 = XF86AudioLowerVolume
keycode 176 = XF86AudioRaiseVolume
keycode 160 = XF86AudioMute
keycode 204 = XF86Eject

Some kde component while take care of the "XF86AudioLowerVolume" and
"XF86AudioRaiseVolume" events and change the value of the "master"
volume control.

mfg
thomas
