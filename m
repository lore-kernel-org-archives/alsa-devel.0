From: Daniel Wagner <wagi@monom.org>
Subject: Re: A report about an enhancement for ALSA firewire stack
Date: Mon, 28 Jul 2014 16:06:37 +0200
Message-ID: <53D658ED.8060903@monom.org>
References: <53CF7D9E.2050908@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <53CF7D9E.2050908@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>, JACK <jack-devel@lists.jackaudio.org>, linux1394-devel@lists.sourceforge.net, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Maximilian Engelhardt <maxi@daemonizer.de>, Darren Anderson <darrena092@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 07/23/2014 11:17 AM, Takashi Sakamoto wrote:
> Dear all,
> 
> My work for ALSA firewire stack was pulled into Linux 3.16, therefore
> Linux 3.16 newly supports 60-70 firewire sound devices. The work may
> affects user-space applications such like FFADO. Additionally, I leave
> some issues for the stack.
> 
> So I wrote a report about my work.
> 
> PDF:
> https://github.com/takaswie/alsa-firewire-report/blob/master/firewire.pdf
> 
> Repository:
> https://github.com/takaswie/alsa-firewire-report
> 
> Table of contents
>  1. Introduction
>  2. Common Specifications
>  3. Device features
>  4. Existing drivers
>  5. Investigation for user-land driver
>  6. Investigation for kernel-land driver
>  7. Enhancement of ALSA firewire stack
>  8. Driver implementation
>  9. Rest of issue
> 
> I hope ALSA maintainers to read section 8 and 9.
> 
> For FFADO developers, section 3, 5, 8 will be good information.
> 
> For JACK/PulseAudio and Linux firewire subsystem developers, section 4,
> 5, 6, 7, 9 will be good information.
> 
> I'm not a good English writer and have a little experiences to write
> technical documents. It's my glad to receive some corrections,
> indications, supplements and so on from you.

Great work! I really appreciate your hard work. Unfortunately I am a
little busy and don't have time to review soon.

cheers,
daniel

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
