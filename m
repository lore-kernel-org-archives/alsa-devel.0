From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: .asoundrc
Date: Mon, 18 Jun 2007 22:32:16 +0530
Message-ID: <8d6898730706181002g5f19cddcj3b86ceb71242e96a@mail.gmail.com>
References: <8d6898730706180334j27251fccm80c30894c931898f@mail.gmail.com>
	<75b66ecd0706180939u2c4e5078k1261e67eee89168b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A003243C8
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 19:02:17 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so1353970nzf
	for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2007 10:02:17 -0700 (PDT)
In-Reply-To: <75b66ecd0706180939u2c4e5078k1261e67eee89168b@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Lee,
 Thanks, i modified it and it is working fine

On 6/18/07, Lee Revell <rlrevell@joe-job.com> wrote:
> On 6/18/07, Nobin Mathew <nobin.mathew@gmail.com> wrote:
> > Hi,
> >
> > I am trying to write one .asoundrc file
> >
> > What i am currently doing is rate conversion
> >
> > My .asounrc file contains
> >
> > pcm.sirf3a {
> >         type rate
> >         slave {
> >                 pcm "hw:0,0"
> >                 rate 8000
> >         }
> > }
> >
> >
> > I am using following command
> >
> > aplay -M -D sirf3a /usr/share/sounds/alsa/Side_Right.wav
> >
> > But it is giving me some errors
> >
> > aplay: set_params:909: Channels count non available
>
> Because your hardware probably only supports stereo but you're trying
> to play a mono file.
>
> Add a plug layer to do channel conversion.
>
> Lee
>
