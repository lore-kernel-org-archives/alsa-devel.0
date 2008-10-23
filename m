From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 12:53:02 +0100
Message-ID: <4900659E.90809@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>
	<48F74344.4090509@gmail.com>	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>
	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D2E3103857
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 13:53:15 +0200 (CEST)
In-Reply-To: <5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Bjoern Olausson <lkmlist@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

There is a "Q" missing from the end of  SBXFI_TIMER_FRE in 
/alsa-kernel/pci/sbxfi/sbxfi.c

aplay works 48khz and 96khz, sounds perfect.

Takashi, I'd like to help testing if I can.
Have a serial cable setup to capture console oopses.
And it does crash whenever it sees alsa/pulse audio.

Jason


Bjoern Olausson wrote:
> alsa-driver-unstable-snapshot.tar.bz2	2864 KB	10/22/2008 04:21:00 PM
>
> Fails to compile
>
> 13:42:51 [~/Desktop/alsa-driver-unstable]
> blub@freax $ ./configure --with-cards=sbxfi,hda-intel
> --with-debug=detect && make
> [...]
> In file included from
> /home/blub/Desktop/alsa-driver-unstable/pci/sbxfi/sbxfi.c:2:
> /home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:
> In function 'sbxfi_reprogram_timer':
> /home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:356:
> error: 'SBXFI_TIMER_FRE' undeclared (first use in this function)
> /home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:356:
> error: (Each undeclared identifier is reported only once
> /home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:356:
> error: for each function it appears in.)
> make[4]: *** [/home/blub/Desktop/alsa-driver-unstable/pci/sbxfi/sbxfi.o] Error 1
> make[3]: *** [/home/blub/Desktop/alsa-driver-unstable/pci/sbxfi] Error 2
> make[2]: *** [/home/blub/Desktop/alsa-driver-unstable/pci] Error 2
> make[1]: *** [_module_/home/blub/Desktop/alsa-driver-unstable] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.27'
> make: *** [compile] Error 2
> 13:43:33 [~/Desktop/alsa-driver-unstable]
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   
