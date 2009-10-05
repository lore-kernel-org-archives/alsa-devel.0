From: Aleksander Adamowski <alsa@olo.org.pl>
Subject: Re: snd-hda-intel: no data when recording from mic,
	"IRQ timing workaround is activated for card #0. Suggest a bigger
	bdl_pos_adj" logged in kern.log
Date: Mon, 5 Oct 2009 02:28:37 +0200
Message-ID: <1c690d740910041728m2560476bsb22aa410e45777e9@mail.gmail.com>
References: <1c690d740909221546i756e6724h45533c59f0a50179@mail.gmail.com>
	<s5hy6o69p3a.wl%tiwai@suse.de>
	<1c690d740909240023u6cc093d6hcf2d5766d7e1a58c@mail.gmail.com>
	<s5hr5twvlw6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id CB73F103804
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 02:28:59 +0200 (CEST)
Received: by yxe34 with SMTP id 34so885113yxe.16
	for <alsa-devel@alsa-project.org>; Sun, 04 Oct 2009 17:28:58 -0700 (PDT)
In-Reply-To: <s5hr5twvlw6.wl%tiwai@suse.de>
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

On Thu, Sep 24, 2009 at 9:31 AM, Takashi Iwai <tiwai@suse.de> wrote:
> First try just with model=auto and no other options.

OK, after a couple days running with the alsa-driver-20090923 snapshot
(with model=auto and no other options), I can see that the problem is
mostly gone.

The only time I can see "hda_intel: azx_get_response timeout,
switching to single_cmd mode", is during a single system shutdown -
the last kernel log entries look like this:

Oct  3 15:54:29 localhost kernel: [19194.705513] ALSA hda_intel.c:699:
azx_get_response timeout, switching to polling mode: last
cmd=0x00cb2001
Oct  3 15:54:30 localhost kernel: [19195.709511] ALSA hda_intel.c:723:
hda_intel: azx_get_response timeout, switching to single_cmd mode:
last cmd=0x00cb2001
Oct  3 15:54:30 localhost kernel: [19195.709649] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.709714] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.709778] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.709849] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.709918] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.709988] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710057] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710127] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710196] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710266] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710335] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710404] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710474] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710543] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710612] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710681] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710751] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710820] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710890] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.710960] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711029] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711098] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711168] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711237] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711306] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711376] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711445] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711514] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711584] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711654] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711724] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711793] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711862] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.711932] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712001] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712070] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712140] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712209] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712278] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712348] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712417] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712487] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712557] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712626] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712696] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712765] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712834] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712904] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.712973] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713043] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713113] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713183] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713252] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713322] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713391] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713460] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713534] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713604] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713673] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713743] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713812] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713882] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.713951] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.714021] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.714091] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.714160] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.714229] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180
Oct  3 15:54:30 localhost kernel: [19195.714299] ALSA hda_intel.c:647:
spurious response 0x0:0x0, last cmd=0xc36180

Obviously, I were unable to extract any diagnostic information or test
whether recording was possible at the moment, since the system was
shutting down.

During subsequent shutdowns, I didn't observe those log messages.

I'm curious what could cause them, though.

-- 
Best Regards,
  Aleksander Adamowski
  http://olo.org.pl
