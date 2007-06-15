From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Software mixing according to priority of streams
Date: Fri, 15 Jun 2007 23:55:00 +0530
Message-ID: <8d6898730706151125v7713783ele79ab9fe914d1f2e@mail.gmail.com>
References: <8d6898730706150110m35fdfb59m6961aa25d0fcc3b3@mail.gmail.com>
	<8d6898730706150400h6126ec15sae1694b80b47ad53@mail.gmail.com>
	<75b66ecd0706151112h663009ub99740d026c168a6@mail.gmail.com>
	<8d6898730706151116s631893e1ja083f861c80d07cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id EB93424835
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2007 20:25:01 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so939285nzf
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2007 11:25:01 -0700 (PDT)
In-Reply-To: <8d6898730706151116s631893e1ja083f861c80d07cb@mail.gmail.com>
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes i have multiple applications.

say mplayer for audio stream.
bluetooth app for bluetooth sco stream
RoadNav for GPS navigation voice data

priority we require is

mplayer < RoadNav < bluetooth sco

so when bluetooth sco apps starts no more mplayer stream data should
go to codec till the sco app stops.

On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> A sound server can do this
>
> Maintain a buffer per application ,
> and each buffer will have priority. when data comes on higher priority
> buffer stop taking data from low priority buffer, and configure the
> audio and start pumping data from high priority buffer.
>
>
> On 6/15/07, Lee Revell <rlrevell@joe-job.com> wrote:
> > On 6/15/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > > Can somebody throw some ideas on this ?
> >
> > I don't understand your use case.  Are you saying you want to start a
> > playback app (say mplayer) and have the audio switch between devices?
> > That's impossible.
> >
> > If you just want to be able to play audio from multiple apps through
> > the same device, then yes, dmix or jack can do it.
> >
> > Lee
> >
>
