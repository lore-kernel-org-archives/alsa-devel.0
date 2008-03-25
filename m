From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Re: Accessing alsa user space buffer from external io
	type plugin
Date: Mon, 24 Mar 2008 18:43:31 -0700
Message-ID: <2d51cbf80803241843o53c74889i5cf198c47c3782e6@mail.gmail.com>
References: <2d51cbf80803241613n3782b150x4c7ee6ea16e2db81@mail.gmail.com>
	<61445c750803241617j251daf91ie69e23e49b6b401b@mail.gmail.com>
	<2d51cbf80803241841j2582c582k8a333ff2a3157323@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 325DE24860
	for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2008 02:43:33 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so3853319wxc.23
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 18:43:32 -0700 (PDT)
In-Reply-To: <2d51cbf80803241841j2582c582k8a333ff2a3157323@mail.gmail.com>
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
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 24, 2008 at 6:41 PM, sandeep lahane <sandeep.lahane@gmail.com>
wrote:

>
>
> On Mon, Mar 24, 2008 at 4:17 PM, Pharaoh . <pharaoh137@gmail.com> wrote:
>
> >
> >
> > On Mon, Mar 24, 2008 at 4:13 PM, sandeep lahane <
> > sandeep.lahane@gmail.com> wrote:
> >
> > > Hello,
> > >
> > > I am debugging an userspace external io type plugin, written for an
> > > ARM
> > > based board where the plugin
> > > interacts with DSP directly using shared memory.
> > >
> > > Every time I have to send period_size data to the DSP, I have my own
> > > write/read methods to do so.
> > >
> > > I am having a problem accessing the alsa ring buffer, my transfer
> > > function
> > > looks like following.
> > >
> > >
> > > static   char * temp;
> > > static snd_pcm_sframes_t alsa_transfer(snd_pcm_ioplug_t *io,
> > >                   const snd_pcm_channel_area_t *areas,
> > >                   snd_pcm_uframes_t offset,
> > >                   snd_pcm_uframes_t size)
> > > {
> > >
> > >           ......
> > >
> > >         temp = malloc(period_size);
> > >         memcpy(temp,  unsigned char *)areas->addr + (areas->first +
> > > areas->step * offset) / 8, period_size);
> > >          write_to_dsp(temp, period_size);
> > >          .......
> > > }
> > >
> > > All the book keeping is done properly, the first chunk of data is sent
> > > properly to DSP and pointer() returns correct value,
> > > next time when transfer is called, the memcpy gives segfault. ALSA
> > > buffer is
> > > an interleaved buffer and I am not using mmap
> > > mode. Any idea what might be wrong?
> > >
> > > When I do something like this:
> > >        memcpy(temp,  "test data test data", period_size);
> > > the data is sent properly to DSP, but alsa buffer data is not getting
> > > accessed properly.
> > >
> > >
> > >
> > >
> > >
> > >
> > > Regards,
> > > Sandeep.
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > >
> >
> >
> >
> > temp is actually malloc'd in hw_params and freed properly, so please
> > ignore the details like whether it is freed etc or not.
> >
>
>
>
> If I change the optimization level to O3, all the values passed from alsa
> upper layer to my plugin are wrong. The reason I tried changing optimization
> levels is that I have faced problems with ARM gcc 4.1.1. before when
> compiled at O levels more than zero.  Are there any known problems with ARM
> gcc 4.1.1 and alsa-lib 1.0.13?
>
> --
>
> Regards,
> Sandeep.


Following values are wrong in transfer callback,
                  const snd_pcm_channel_area_t *areas,
                  snd_pcm_uframes_t offset,
                  snd_pcm_uframes_t size


-- 

Regards,
Sandeep.
