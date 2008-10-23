From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 17:40:44 +0200
Message-ID: <5501535d0810230840r29c72e0ofe94fadea9103e03@mail.gmail.com>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>
	<4900659E.90809@jasonline.co.uk> <s5hbpxb8lfe.wl%tiwai@suse.de>
	<490071DC.6070607@jasonline.co.uk> <s5habcv5mu0.wl%tiwai@suse.de>
	<490088DC.7090205@jasonline.co.uk> <s5hzlkv44v7.wl%tiwai@suse.de>
	<s5hwsfz44i9.wl%tiwai@suse.de> <49009A26.3000201@jasonline.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C244103932
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 17:41:03 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so356795rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 23 Oct 2008 08:40:44 -0700 (PDT)
In-Reply-To: <49009A26.3000201@jasonline.co.uk>
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
To: Jason Harvey <softdevice@jasonline.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 23, 2008 at 17:37, Jason Harvey <softdevice@jasonline.co.uk> wrote:
> Takashi Iwai wrote:
>>
>> Another patch to try is the one like below (on the top of the latest
>> code).  Any change with this?
>>
> Having trouble with 23 Oct unstable snapshot.
> Sorry, I might be doing something wrong!
>
> Your patch applies cleanly but build fails on emu10k1.
> ./configure --with-cards=sbxfi still get error...
>
> Regards, Jason

Dito, same problem here

./configure --with-cards=sbxfi,hda-intel --with-debug=detect && make

make[3]: Entering directory
`/home/blub/Desktop/alsa-driver-unstable/pci/emu10k1'
copying file alsa-kernel/pci/emu10k1/emu10k1_main.c
patching file emu10k1_main.c
Hunk #3 FAILED at 673.
Hunk #4 succeeded at 1410 (offset 2 lines).
Hunk #5 succeeded at 1453 (offset 2 lines).
Hunk #6 succeeded at 1764 with fuzz 1 (offset 3 lines).
1 out of 6 hunks FAILED -- saving rejects to file emu10k1_main.c.rej
make[3]: *** [emu10k1_main.c] Error 1
make[3]: Leaving directory `/home/blub/Desktop/alsa-driver-unstable/pci/emu10k1'
make[2]: *** [prepare] Error 1
make[2]: Leaving directory `/home/blub/Desktop/alsa-driver-unstable/pci'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/home/blub/Desktop/alsa-driver-unstable'
make: *** [include/sndversions.h] Error 2
