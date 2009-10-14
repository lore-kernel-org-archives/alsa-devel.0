From: Aleksander Adamowski <alsa@olo.org.pl>
Subject: Re: snd-hda-intel: no data when recording from mic,
	"IRQ timing workaround is activated for card #0. Suggest a bigger
	bdl_pos_adj" logged in kern.log
Date: Wed, 14 Oct 2009 09:04:37 +0200
Message-ID: <1c690d740910140004l1383a08h6ae5c6fe86b0e731@mail.gmail.com>
References: <1c690d740909221546i756e6724h45533c59f0a50179@mail.gmail.com>
	<s5hy6o69p3a.wl%tiwai@suse.de>
	<1c690d740909240023u6cc093d6hcf2d5766d7e1a58c@mail.gmail.com>
	<s5hr5twvlw6.wl%tiwai@suse.de>
	<1c690d740910041728m2560476bsb22aa410e45777e9@mail.gmail.com>
	<s5hab069zoi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F48F10389E
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 09:04:58 +0200 (CEST)
Received: by ywh33 with SMTP id 33so4742321ywh.23
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2009 00:04:57 -0700 (PDT)
In-Reply-To: <s5hab069zoi.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 5, 2009 at 7:29 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 5 Oct 2009 02:28:37 +0200,
> Aleksander Adamowski wrote:
>>
>> On Thu, Sep 24, 2009 at 9:31 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > First try just with model=auto and no other options.
>>
>> OK, after a couple days running with the alsa-driver-20090923 snapshot
>> (with model=auto and no other options), I can see that the problem is
>> mostly gone.
>
> Does this happen with the later snapshot?

Hi!

After running for almost ten days with alsa-driver-20091005, I didn't
observe that problem.

However, a new one (well, one with slightly different symptoms) has surfaced.

The difference is only in the log files.
During a Skype conversation, the other side has stopped hearing us;
after trying to record some sound with arecord, I got an empty stream
(a 44 byte WAV file with only a header) - just like previously.

However, this time there were no messages in the kernel logs
whatsoever - no "azx_get_response timeout", no "Suggest a bigger
bdl_pos_adj".
Arecord also didn't flood the console with overrun errors - it was
completely silent apart from the fact that it did not record anything.

The only hda-related entries I saw in the kernel log were a couple
hours earlier at 20:44 - while the failure has occured between 23:00
and 00:00.

At 20:44 the following has been logged:

Oct 13 20:44:25 hostname kernel: [117828.065069] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.073562] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.083367] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.578958] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.584872] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.592909] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.651513] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.657009] ALSA
hda_intel.c:1187: Too big adjustment 32
Oct 13 20:44:25 hostname kernel: [117828.665794] ALSA
hda_intel.c:1187: Too big adjustment 32

The machine is currently still in the failed state - I cannot record
anything until I reboot.


-- 
Best Regards,
  Aleksander Adamowski
  http://olo.org.pl
