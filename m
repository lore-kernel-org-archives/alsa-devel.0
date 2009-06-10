From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted: New SB
	X-Fi driver)
Date: Tue, 9 Jun 2009 22:31:51 -0400
Message-ID: <75b66ecd0906091931k7d3daf8fp708b7da444dc60cb@mail.gmail.com>
References: <1244140942.4550.2.camel@polo-desktop>
	<4A2D56C7.2090505@googlemail.com> <s5hws7m7cfd.wl%tiwai@suse.de>
	<4A2D7181.3040108@googlemail.com> <s5h63f6f8qo.wl%tiwai@suse.de>
	<4A2DF1EC.9060104@googlemail.com> <s5hab4ix8wo.wl%tiwai@suse.de>
	<4A2DF6BD.6060004@googlemail.com> <s5h63f5ylee.wl%tiwai@suse.de>
	<s5hk53l3f6p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 8CC13243DD
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Jun 2009 04:31:52 +0200 (CEST)
Received: by ewy23 with SMTP id 23so473811ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 19:31:51 -0700 (PDT)
In-Reply-To: <s5hk53l3f6p.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 9, 2009 at 5:54 AM, Takashi Iwai<tiwai@suse.de> wrote:
>> Anyway, please try the very latest alsa-driver-snapshot. =A0If it still
>> doesn't work, let me know whether use_system_timer=3D1 works around the
>> crash. =A0If yes, just try to comment out all spin_*() calls in
>> cttimer.c.
>
> Also, show your ~/.asoundrc setup so that I can try to reproduce
> the same bug with my test machine.

Just curious, has anyone tested the driver with a DEBUG_PREEMPT and/or
lockdep kernel?  The Creative people definitely didn't ;-)

Lee
