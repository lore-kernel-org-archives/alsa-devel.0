From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 13:46:35 +0200
Message-ID: <5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<48F739F4.5070303@nostalgicnetworxx.org> <48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>
	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>
	<s5h4p34mz0j.wl%tiwai@suse.de>
	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>
	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>
	<48FF7E17.9080601@gmail.com> <s5h4p3350o4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id D5D9B10385A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 13:46:53 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so278146rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2008 04:46:35 -0700 (PDT)
In-Reply-To: <s5h4p3350o4.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-driver-unstable-snapshot.tar.bz2	2864 KB	10/22/2008 04:21:00 PM

Fails to compile

13:42:51 [~/Desktop/alsa-driver-unstable]
blub@freax $ ./configure --with-cards=sbxfi,hda-intel
--with-debug=detect && make
[...]
In file included from
/home/blub/Desktop/alsa-driver-unstable/pci/sbxfi/sbxfi.c:2:
/home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:
In function 'sbxfi_reprogram_timer':
/home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:356:
error: 'SBXFI_TIMER_FRE' undeclared (first use in this function)
/home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:356:
error: (Each undeclared identifier is reported only once
/home/blub/Desktop/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxfi.c:356:
error: for each function it appears in.)
make[4]: *** [/home/blub/Desktop/alsa-driver-unstable/pci/sbxfi/sbxfi.o] Error 1
make[3]: *** [/home/blub/Desktop/alsa-driver-unstable/pci/sbxfi] Error 2
make[2]: *** [/home/blub/Desktop/alsa-driver-unstable/pci] Error 2
make[1]: *** [_module_/home/blub/Desktop/alsa-driver-unstable] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.27'
make: *** [compile] Error 2
13:43:33 [~/Desktop/alsa-driver-unstable]
