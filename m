From: Matej Laitl <strohel@gmail.com>
Subject: [ALSA] HDA: no sound in headphone-out caused by commit
	f889fa91ad47e (2.6.25-rc1 regression)
Date: Mon, 11 Feb 2008 21:58:41 +0100
Message-ID: <200802112158.41989.strohel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 34E7624652
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 21:58:47 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so550629uge.50
	for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2008 12:58:46 -0800 (PST)
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,
after upgrading from 2.6.24 to 2.6.25-rc1, I lost headphone-out sound output 
of my Intel HDA card - it is quiet no matter what the mixer settings are.

After playing wit git bisect a bit, I narrowed it down to commit 
f889fa91ad47e "[ALSA] hda-codec - Improve the auto-configuration". [1]
It works okay with tree as of previous commit 69b1f1e8337fc9. 

First lines from /proc/asound/Intel/codec#0:
Codec: Realtek ALC262
Address: 0
Vendor Id: 0x10ec0262
Subsystem Id: 0x17340000
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0

The box is Fujitsu-Siemens Esprimo Mobile M9400 laptop.

[1] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f889fa91ad47e6fcb530abf1184ca9f1473d3c72

Regards,
	Matej Laitl
