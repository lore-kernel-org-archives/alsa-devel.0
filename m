From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: firewire mixer interface -- was Re: [PATCH 11/11]
 ALSA: digi00x: apply double-oh-three algorism to multiplex PCM samples
Date: Sat, 21 Mar 2015 16:59:53 +1100
Message-ID: <550D08D9.7070509@gmail.com>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>	<1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>	<5506E7EE.6060300@gareus.org>	<55070409.8090107@sakamocchi.jp>	<55070F3B.7000509@gareus.org>	<55075D65.20406@sakamocchi.jp>	<55082E06.6010008@gareus.org>	<55083103.5030704@gmail.com>	<5508CFA5.7060903@sakamocchi.jp>	<550AD65F.10803@gareus.org>	<550B51BC.80506@sakamocchi.jp>	<550C0CFC.4060404@gareus.org>	<550C1FC6.4050700@sakamocchi.jp>	<s5hmw376bck.wl-tiwai@suse.de>	<550C25DD.3080507@sakamocchi.jp>	<s5hfv8z69jz.wl-tiwai@suse.de>	<550C3294.7020003@sakamocchi.jp>
 <s5hsicz1znq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 612C42604C7
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2015 07:00:02 +0100 (CET)
Received: by pdbcz9 with SMTP id cz9so128795754pdb.3
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 23:00:01 -0700 (PDT)
In-Reply-To: <s5hsicz1znq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org



On 21/03/15 02:01, Takashi Iwai wrote:
> OK, point taken.  Then it's no matter whether plugin or not.  Rather a
> question is whether it works out-of-the-box without any extra
> configuration, right?
I think it would be a nice feature if it just worked out of the box like
any other alsa mixer control, and I'm sure many other people who are
currently using FFADO would agree that having everything to control the
sound card in ALSA would be more convenient than what they have now.

Takashi S: can we perhaps focus on getting the streaming working better
with 003amdtp for digi00x and revisit the issue of mixer controls later?
Have you looked at the updated 003amdtp documentation?  I believe Robin
has made suggestions on how to integrate the latest code into the driver.

<snip>

#ifdef EXAMPLE
  // NB. this should not be static (multiple devices)
  // and also re-initialzed on open/close or stream-restart.
  // use digi_state_reset(&state);
  static DigiMagic digistate = {0x00, 0x00, 0};
#endif

</snip>

Damien
