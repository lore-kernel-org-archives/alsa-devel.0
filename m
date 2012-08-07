From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 13:53:42 -0400
Message-ID: <CA+7tXihuH5vpjBUs1VB1e5ktrfpqjOegBMvSLZPWWQ=F5CoLeA@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail.gmail.com>
 <CA+7tXigKNQM2ci1Qxc8BjUFyQhNURGvAx=wD0CEim8izMGtU1w@mail.gmail.com>
 <5021034D.9080307@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 32291265ED7
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 19:31:04 +0200 (CEST)
Received: by vbbfn1 with SMTP id fn1so75790vbb.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 11:00:34 -0700 (PDT)
In-Reply-To: <5021034D.9080307@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Estevam Fabio-R49496 <r49496@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 7, 2012 at 8:00 AM, Tabi Timur-B04825 <B04825@freescale.com> wrote:
>> There is the race issue in that playback and record must both match
>> mono and stereo and ALSA doesn't handle substreams with constraints
>> that depend on other substreams in a race free manner.
>
> Isn't that only a problem if both streams are opened literally
> simultaneously?  I would assume that most apps will open one stream at a time.

The problem comes up if another stream is opened before the hw_params
are fixed on the other stream.  So if the first stream is configured
past the hw_params level before the next is opened there is no
problem.  But if not there is a race.  There could be two different
independent processes using the hardware which might be running at the
same time.

I remember posting something about this race in more detail.  One can
mostly make it work by dynamically adding constraints in the open()
method based on the configuration of the linked substream and then
checking the hw_params again for correctness in the hw_params()
method.

There end up being two problems.  One is on the userspace side.  An
app could get a set constraints, choose hwparams that are valid
according to those constraints, and then get told hwparams are not
valid anyway.  While an app could handle this, it has never been
documented as something an app should handle in a certain way.  So
apps will most likely not handle it well.

The other problem is that if two substreams call hw_params at the same
time there is a race internal to ALSA.  I don't remember what the
problem is exactly, just that there was one.
