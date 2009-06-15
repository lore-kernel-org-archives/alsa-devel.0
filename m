From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted: New SB
 X-Fi	driver)
Date: Mon, 15 Jun 2009 18:17:08 +0200
Message-ID: <4A367404.80900@googlemail.com>
References: <1244140942.4550.2.camel@polo-desktop>	<s5hbpp1zpt9.wl%tiwai@suse.de>	<1244376026.6985.5.camel@polo-desktop>	<s5hk53oowhz.wl%tiwai@suse.de>	<s5hbpoz3pbj.wl%tiwai@suse.de>	<4A2D56C7.2090505@googlemail.com>	<s5hws7m7cfd.wl%tiwai@suse.de>	<4A2D7181.3040108@googlemail.com>	<s5h63f6f8qo.wl%tiwai@suse.de>	<4A2DF1EC.9060104@googlemail.com>	<s5hab4ix8wo.wl%tiwai@suse.de>	<4A2DF6BD.6060004@googlemail.com>	<s5h63f5ylee.wl%tiwai@suse.de>	<s5hk53l3f6p.wl%tiwai@suse.de>	<4A2E97A6.3090301@googlemail.com>
	<s5hy6rtejri.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E24C51037ED
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 18:17:11 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1101522fgg.21
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2009 09:17:10 -0700 (PDT)
In-Reply-To: <s5hy6rtejri.wl%tiwai@suse.de>
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

Takashi Iwai schrieb:
> At Tue, 09 Jun 2009 19:11:02 +0200,
> Gernot Kohlhaas wrote:
>>> Also, show your ~/.asoundrc setup so that I can try to reproduce
>>> the same bug with my test machine.
>> Here it is:
> 
> Thanks, I could reproduce the problem now with your setup.
> This is indeed a deadlock but in a different place due to the invalid
> update of PCM substream.  I fixed it now.
> Try the very latest alsa-driver-snapshot.
> 
> 
> Takashi
> 


ALSA /usr/src/alsa-driver/pci/ctxfi/ctatc.c:1252: ctxfi: chip 20K1 model
Unknown (1102:002c) is found
SB-XFi 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ALSA
/usr/src/alsa-driver/pci/ctxfi/../../alsa-kernel/pci/ctxfi/cttimer.c:424:
ctxfi: Use xfi-native timer

No crashes. Everything's running fine now :)
Thank you very much!

-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
