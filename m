From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: [ALSA] ALSA Power Management,
	Drivers behaving unexpectedly after suspend/resume cycle
Date: Mon, 28 May 2007 14:46:59 +0530
Message-ID: <8d6898730705280216v54aeb08y9d1dbb8be7acc7a2@mail.gmail.com>
References: <8d6898730705242257k6da2088fi80f0d4034ed78986@mail.gmail.com>
	<s5h3b1lp75g.wl%tiwai@suse.de>
	<8d6898730705250504p442190e6u5bf71fbcd947df38@mail.gmail.com>
	<1180096780.13652.57.camel@localhost.localdomain>
	<s5hmyztnijd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_220963_26732399.1180343819796"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AD0124704
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 11:17:01 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so337597nzf
	for <alsa-devel@alsa-project.org>; Mon, 28 May 2007 02:17:00 -0700 (PDT)
In-Reply-To: <s5hmyztnijd.wl%tiwai@suse.de>
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

------=_Part_220963_26732399.1180343819796
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I did some more investigation into this issue.

There are two cases, in the first case it is working after resume()
and in the second case it is not working after resume

1st Case:

1) boot the system
2)Load sound modules
2)mixer setting (alsactl restore 0)
3)Do power managemnt (sleep) suspend()
4)Come out of suspend, resume()
5)
sound is coming out in this case

2nd Case:
1)boot the system
2)load sound modules
3)mixer settings (alsactl restore 0)
4)Do playback aplay -M /usr/share/sounds/alsa/Side_Right.wav
5) Let aplay to completion and kill all alsa apps if any running.
6)Do power managemnt (sleep) suspend()
7)Come out of suspend, resume()
8)Do playback aplay -M /usr/share/sounds/alsa/Side_Right.wav

in this case no sound is coming out and i am getting underrun error.


I am attaching some logs, these are the ac97 codec register values at
various stages.

Mainly look at the register 3c.












On 5/25/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 25 May 2007 13:39:40 +0100,
> Liam Girdwood wrote:
> >
> > On Fri, 2007-05-25 at 17:34 +0530, Nobin Mathew wrote:
> > > Every ALSA driver is calling these for suspend
> > >
> > > snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> > > snd_pcm_suspend_all(pcm[i]);
> > >
> > > And for resume
> > > snd_power_change_state(card, SNDRV_CTL_POWER_D0)
> > >
> > >
> > > In ALSA ASoC no driver is calling any of this, even not in soc-core.c
> > >
> > > My driver is an ASoC driver and I am also not calling these functions
> > >
> > > Will this cause any Issue?
> > >
> >
> > These should probably be called to inform the upper layers of the PM
> > state. Can you log a bug for this in ALSA bugzilla.
> >
> > Fwiw, this _shouldn't_ effect your resume. You should still see calls to
> > trigger for your DMA / AC97 to re-start transmission of PCM data.
>
> I think this does matter.  Without calling snd_pcm_suspend*(), the
> stream is assumed to be still active, thus eventually neither prepare
> nor trigger is called at resume.  If the hardware is perfectly
> resumed as it was before suspend, it may still work somehow.
>
> However, usually it's impossible to resume the hardware perfectly.
> Thus, we need one stop the stream via snd_pcm_suspend*(), and let apps
> (or OSS layer) parepare (if needed) and restart the stream again.
>
>
> Takashi
>

------=_Part_220963_26732399.1180343819796
Content-Type: text/plain; name=after_resume_aplay.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f28q6aer
Content-Disposition: attachment; filename="after_resume_aplay.txt"

MDowMCA9IDYxNzQKMDowMiA9IDgwODAKMDowNCA9IDQwNDAKMDowNiA9IDgwODAKMDowOCA9IGM4
ODAKMDowYSA9IDY4MDgKMDowYyA9IDY4MDgKMDowZSA9IDA4MDgKMDoxMCA9IDAwZmEKMDoxMiA9
IDAwODAKMDoxNCA9IGQ2MDcKMDoxNiA9IGFhYTAKMDoxOCA9IGFhYTAKMDoxYSA9IGFhYTAKMDox
YyA9IDAwYTAKMDoxZSA9IDAwMGYKMDoyMCA9IDBmMGYKMDoyMiA9IDAwNDAKMDoyNCA9IDAwMDAK
MDoyNiA9IDAwMGYKMDoyOCA9IDA0MDUKMDoyYSA9IDA0MTEKMDoyYyA9IGJiODAKMDoyZSA9IGJi
ODAKMDozMCA9IDAwMDAKMDozMiA9IGJiODAKMDozNCA9IDAwMDAKMDozNiA9IDQ1MjMKMDozOCA9
IDAwMDAKMDozYSA9IDIwMDAKMDozYyA9IDFiZmYKMDozZSA9IGZkZGYKMDo0MCA9IDAwMDAKMDo0
MiA9IDAwMDAKMDo0NCA9IDAwODAKMDo0NiA9IDg2MDcKMDo0OCA9IDAwMDAKMDo0YSA9IDAwMDAK
MDo0YyA9IGZmZmUKMDo0ZSA9IGZmZmYKMDo1MCA9IDAwMDAKMDo1MiA9IDAwMDAKMDo1NCA9IDA5
YTAKMDo1NiA9IGZmZmUKMDo1OCA9IDQwMDAKMDo1YSA9IDAwMDAKMDo1YyA9IDAwMDAKMDo1ZSA9
IDAwMDAKMDo2MCA9IGIwMzIKMDo2MiA9IDNlMDAKMDo2NCA9IDAwMDAKMDo2NiA9IDAwMDAKMDo2
OCA9IDAwNjAKMDo2YSA9IDAwMDAKMDo2YyA9IDAwMDAKMDo2ZSA9IDAwMDAKMDo3MCA9IDAwMDAK
MDo3MiA9IDAwMDAKMDo3NCA9IDAwMDAKMDo3NiA9IDAwMDYKMDo3OCA9IDAwMDEKMDo3YSA9IDAw
MDAKMDo3YyA9IDU3NGQKMDo3ZSA9IDRjMTMKCg==
------=_Part_220963_26732399.1180343819796
Content-Type: text/plain; name=after_resume_before2nd_aplay.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f28q6gfw
Content-Disposition: attachment; filename="after_resume_before2nd_aplay.txt"

MDowMCA9IDYxNzQKMDowMiA9IDgwODAKMDowNCA9IDQwNDAKMDowNiA9IDgwODAKMDowOCA9IGM4
ODAKMDowYSA9IDY4MDgKMDowYyA9IDY4MDgKMDowZSA9IDA4MDgKMDoxMCA9IDAwZmEKMDoxMiA9
IDAwODAKMDoxNCA9IGQ2MDcKMDoxNiA9IGFhYTAKMDoxOCA9IGFhYTAKMDoxYSA9IGFhYTAKMDox
YyA9IDAwYTAKMDoxZSA9IDAwMGYKMDoyMCA9IDBmMGYKMDoyMiA9IDAwNDAKMDoyNCA9IDAwMDAK
MDoyNiA9IDAwMGYKMDoyOCA9IDA0MDUKMDoyYSA9IDA0MTEKMDoyYyA9IGJiODAKMDoyZSA9IGJi
ODAKMDozMCA9IDAwMDAKMDozMiA9IGJiODAKMDozNCA9IDAwMDAKMDozNiA9IDQ1MjMKMDozOCA9
IDAwMDAKMDozYSA9IDIwMDAKMDozYyA9IDNiZmYKMDozZSA9IGZkZGYKMDo0MCA9IDAwMDAKMDo0
MiA9IDAwMDAKMDo0NCA9IDAwODAKMDo0NiA9IDg2MDcKMDo0OCA9IDAwMDAKMDo0YSA9IDAwMDAK
MDo0YyA9IGZmZmUKMDo0ZSA9IGZmZmYKMDo1MCA9IDAwMDAKMDo1MiA9IDAwMDAKMDo1NCA9IDA5
YTAKMDo1NiA9IGZmZmUKMDo1OCA9IDQwMDAKMDo1YSA9IDAwMDAKMDo1YyA9IDAwMDAKMDo1ZSA9
IDAwMDAKMDo2MCA9IGIwMzIKMDo2MiA9IDNlMDAKMDo2NCA9IDAwMDAKMDo2NiA9IDAwMDAKMDo2
OCA9IDAwNjAKMDo2YSA9IDAwMDAKMDo2YyA9IDAwMDAKMDo2ZSA9IDAwMDAKMDo3MCA9IDAwMDAK
MDo3MiA9IDAwMDAKMDo3NCA9IDAwMDAKMDo3NiA9IDAwMDYKMDo3OCA9IDAwMDEKMDo3YSA9IDAw
MDAKMDo3YyA9IDU3NGQKMDo3ZSA9IDRjMTMKCg==
------=_Part_220963_26732399.1180343819796
Content-Type: text/plain; name=before_aplay_suspend.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f28q6i86
Content-Disposition: attachment; filename="before_aplay_suspend.txt"

MDowMCA9IDYxNzQKMDowMiA9IDgwODAKMDowNCA9IDQwNDAKMDowNiA9IDgwODAKMDowOCA9IGM4
ODAKMDowYSA9IDY4MDgKMDowYyA9IDY4MDgKMDowZSA9IDA4MDgKMDoxMCA9IDAwZmEKMDoxMiA9
IDAwODAKMDoxNCA9IGQ2MDcKMDoxNiA9IGFhYTAKMDoxOCA9IGFhYTAKMDoxYSA9IGFhYTAKMDox
YyA9IDAwYTAKMDoxZSA9IDAwMGYKMDoyMCA9IDBmMGYKMDoyMiA9IDAwNDAKMDoyNCA9IDAwMDAK
MDoyNiA9IDAwMGYKMDoyOCA9IDA0MDUKMDoyYSA9IDA0MTAKMDoyYyA9IGJiODAKMDoyZSA9IGJi
ODAKMDozMCA9IDAwMDAKMDozMiA9IGJiODAKMDozNCA9IDAwMDAKMDozNiA9IDQ1MjMKMDozOCA9
IDAwMDAKMDozYSA9IDIwMDAKMDozYyA9IDNhZmIKMDozZSA9IGZkZGYKMDo0MCA9IDAwMDAKMDo0
MiA9IDAwMDAKMDo0NCA9IDAwODAKMDo0NiA9IDAwMDAKMDo0OCA9IDAwMDAKMDo0YSA9IDAwMDAK
MDo0YyA9IGZmZmUKMDo0ZSA9IGZmZmYKMDo1MCA9IDAwMDAKMDo1MiA9IDAwMDAKMDo1NCA9IDA5
YTAKMDo1NiA9IGZmZmUKMDo1OCA9IDQwMDAKMDo1YSA9IDAwMDAKMDo1YyA9IDAwMDAKMDo1ZSA9
IDAwMDAKMDo2MCA9IGIwMzIKMDo2MiA9IDNlMDAKMDo2NCA9IDAwMDAKMDo2NiA9IDAwMDAKMDo2
OCA9IDAwNjAKMDo2YSA9IDAwMDAKMDo2YyA9IDAwMDAKMDo2ZSA9IDAwMDAKMDo3MCA9IDAwMDAK
MDo3MiA9IDAwMDAKMDo3NCA9IDAwMDAKMDo3NiA9IDAwMDYKMDo3OCA9IDAwMDEKMDo3YSA9IDAw
MDAKMDo3YyA9IDU3NGQKMDo3ZSA9IDRjMTMKCg==
------=_Part_220963_26732399.1180343819796
Content-Type: text/plain; name=before_suspend_after1st_aplay.txt;
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f28q6joa
Content-Disposition: attachment; filename="before_suspend_after1st_aplay.txt"

MDowMCA9IDYxNzQKMDowMiA9IDgwODAKMDowNCA9IDQwNDAKMDowNiA9IDgwODAKMDowOCA9IGM4
ODAKMDowYSA9IDY4MDgKMDowYyA9IDY4MDgKMDowZSA9IDA4MDgKMDoxMCA9IDAwZmEKMDoxMiA9
IDAwODAKMDoxNCA9IGQ2MDcKMDoxNiA9IGFhYTAKMDoxOCA9IGFhYTAKMDoxYSA9IGFhYTAKMDox
YyA9IDAwYTAKMDoxZSA9IDAwMGYKMDoyMCA9IDBmMGYKMDoyMiA9IDAwNDAKMDoyNCA9IDAwMDAK
MDoyNiA9IDAwMGYKMDoyOCA9IDA0MDUKMDoyYSA9IDA0MTEKMDoyYyA9IGJiODAKMDoyZSA9IGJi
ODAKMDozMCA9IDAwMDAKMDozMiA9IGJiODAKMDozNCA9IDAwMDAKMDozNiA9IDQ1MjMKMDozOCA9
IDAwMDAKMDozYSA9IDIwMDAKMDozYyA9IDFhZmIKMDozZSA9IGZkZGYKMDo0MCA9IDAwMDAKMDo0
MiA9IDAwMDAKMDo0NCA9IDAwODAKMDo0NiA9IDg2MDcKMDo0OCA9IDAwMDAKMDo0YSA9IDAwMDAK
MDo0YyA9IGZmZmUKMDo0ZSA9IGZmZmYKMDo1MCA9IDAwMDAKMDo1MiA9IDAwMDAKMDo1NCA9IDA5
YTAKMDo1NiA9IGZmZmUKMDo1OCA9IDQwMDAKMDo1YSA9IDAwMDAKMDo1YyA9IDAwMDAKMDo1ZSA9
IDAwMDAKMDo2MCA9IGIwMzIKMDo2MiA9IDNlMDAKMDo2NCA9IDAwMDAKMDo2NiA9IDAwMDAKMDo2
OCA9IDAwNjAKMDo2YSA9IDAwMDAKMDo2YyA9IDAwMDAKMDo2ZSA9IDAwMDAKMDo3MCA9IDAwMDAK
MDo3MiA9IDAwMDAKMDo3NCA9IDAwMDAKMDo3NiA9IDAwMDYKMDo3OCA9IDAwMDEKMDo3YSA9IDAw
MDAKMDo3YyA9IDU3NGQKMDo3ZSA9IDRjMTMKCg==
------=_Part_220963_26732399.1180343819796
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_220963_26732399.1180343819796--
