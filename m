From: Aleksander Adamowski <alsa@olo.org.pl>
Subject: Re: snd-hda-intel: no data when recording from mic,
	"IRQ timing workaround is activated for card #0. Suggest a bigger
	bdl_pos_adj" logged in kern.log
Date: Mon, 5 Oct 2009 23:07:31 +0200
Message-ID: <1c690d740910051407o6d21adadib69dd0b5238f686f@mail.gmail.com>
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
Received: from mail-yw0-f192.google.com (mail-yw0-f192.google.com
	[209.85.211.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 3949610382E
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 23:07:52 +0200 (CEST)
Received: by ywh30 with SMTP id 30so3349650ywh.23
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 14:07:51 -0700 (PDT)
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

To be exact, with snapshot 20090923 this has happened only once and I
have had several shutdowns on that version of alsa-driver snapshot and
kernel.

I've installed alsa-driver-20091005 and will pay attention when/if
this will occur again.

-- 
Best Regards,
  Aleksander Adamowski
  http://olo.org.pl
