From: Daniel Mack <daniel@zonque.org>
Subject: Re: Echo Audio Echo 2 USB Interface
Date: Mon, 13 Oct 2014 16:45:52 +0200
Message-ID: <543BE5A0.1090009@zonque.org>
References: <CABuEqK7VqOxFg8dBTwXoiKEqP-ZZPSZxwH5bapAP0uugio9qbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E6C82260463
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 16:45:54 +0200 (CEST)
In-Reply-To: <CABuEqK7VqOxFg8dBTwXoiKEqP-ZZPSZxwH5bapAP0uugio9qbg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tristan Chambers <tristan.chambers@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/11/2014 07:32 PM, Tristan Chambers wrote:
> I picked up an Echo Audio Echo 2 USB Interface. The product specs list
> iPad support through camera connection kit, so I assume it is class
> compliant. http://echoaudio.com/blogs/news/6454472-echo-digital-audio-introduces-the-echo-2-usb-audio-interface
> 
> However, on most systems when I plug the device in, it shows up in my
> sound settings panel under the Input tab, but not under the Output
> tab.
> 
> Recording works. I can successfully record with arecord -vv -fdat -D
> "plughw:CARD=Audio,DEV=0" echo.wav. I also can increase the sample
> rate by changing the flags. I verified that the sample rate actually
> increases by recording a 50khz test tone into the input and examining
> the wave form in an editor. It's there! So this is very promising.
> (anyone know of a test to verify bit depth? I want to make sure it's
> actually recording at 24bits.)
> 
> Playback however, is nothing but trouble. Like I said, the output
> device doesn't show up in the Output tab in my sound settings
> (gnome/pulse). However, when I list devices and available PCMs with
> aplay -l and aplay -L the device shows up on the lists. See specimens
> #1, #2, and #3. When I try to play though I get about a 1/4 second of
> audio and then nothing, and subsequent attempts to play sound output
> nothing. The device then must be unplugged and plugged back in. I'm
> playing with the command aplay -vv foo.wav
> --device="plughw:CARD=Audio,DEV=0". See output screen on specimen #4.

Any messages in dmesg when you try this? And does PulseAudio generate
any logs that look suspicious? The output of 'lsusb -v' might also be
helpful.


Daniel
