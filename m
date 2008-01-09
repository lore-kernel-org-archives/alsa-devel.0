From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: can not access the alsa driver
Date: Wed, 9 Jan 2008 21:35:25 +0000
Message-ID: <8b67d60801091335o67f7381dlb10648a4f15f4cbf@mail.gmail.com>
References: <48a1cba90801050642s47db1bcbj6c6624536eda5949@mail.gmail.com>
	<1199615384.5983.24.camel@md40100b.ft>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B8D92439B
	for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2008 22:35:28 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so676011pyg.36
	for <alsa-devel@alsa-project.org>; Wed, 09 Jan 2008 13:35:26 -0800 (PST)
In-Reply-To: <1199615384.5983.24.camel@md40100b.ft>
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
To: Joachim Foerster <mls.JOFT@gmx.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ning Zhang <ning.zhang06@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/01/2008, Joachim Foerster <mls.JOFT@gmx.de> wrote:
> Hi,
>
> On Sat, 2008-01-05 at 22:42 +0800, Ning Zhang wrote:
> > ( I did not found /dev/snd  or /dev/dsp )
> >
> > But when I run the application, I got these errors:
> > # /tmp/pcm_play_arm_s default
> > ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM default
> > Playback open error: No such file or directory
>
> Well, I think, the /dev/snd/* devices files have to exist. Do you use
> udevd? If not, I guess you have to create these files manually - or by
> using the snddevices script in alsa-driver package.
> If you use udevd, then - perhaps - your are missing some rules files
> (/etc/udev/rules.d). Have a look at your Linux distributions rules files
> of your host PC.
>
> > Here are my questions:
> > 1, When we install the alsa-lib, we can get some libs, besides those, do we
> > also get some config files according to the local linux environment and
> > alsa-lib will use these config files to access the real driver? If that, how
> > can I install the alsa-lib to a embedded platform directly or what config
> > files should I port to embedded platform?
> >
> > 2, Must I edit ~/.asoundrc and /etc/alsa/alsa.conf ? In my situation, what
> > should I do ? Is somebody so kind can give me a simple template?
>
> I cannot really say something about your questions - I hadn't to create
> any special config. files, when I started using my own driver (for a
> PPC405 based board (ML403)). I just cross-compiled and installed
> alsa-lib and alsa-tools (to have aplay and arecord).
>
Any chance you could publish your configuration here?
