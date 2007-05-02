From: "Ashlesha Shintre" <ashlesha.shintre@gmail.com>
Subject: Re: error in recovery from buffer under-run.
Date: Wed, 2 May 2007 11:54:03 -0400
Message-ID: <975f530d0705020854s7af255l116414e77858f25c@mail.gmail.com>
References: <975f530d0705020826p7bdaa979hef9003e75cac9fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9EE24443
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 17:54:04 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so174851wxd
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2007 08:54:03 -0700 (PDT)
In-Reply-To: <975f530d0705020826p7bdaa979hef9003e75cac9fd9@mail.gmail.com>
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
To: Aditya Shankar <mc.aditya@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I should have also included the program output pasted below, in my previous
email:

frames returned is 1359
> 1359 frames written
> frames returned is -32
> ALSA lib pcm.c:7073:(snd_pcm_recover) underrun occured
> recover returned 0
> 0 frames written
> frames returned is 1359
> 1359 frames written
> frames returned is -32
> ALSA lib pcm.c:7073:(snd_pcm_recover) underrun occured
> recover returned 0
> 0 frames written


Apologies for the same,
Regards,
Ashlesha.


On 02/05/07, Ashlesha Shintre <ashlesha.shintre@gmail.com> wrote:
>
> Hi,
>
> Thanks for the link you emailed earlier.  I tried writing my own code,
> based on the how to in the alsa wiki.  I have attached that code with this
> email.
>
> The problem it faces is a buffer underrun every alternate time, i try
> writing to the device.
>
> In my code, to take care of underruns, I do the following:
>
> period_size=64;
> buffer is a short int array which is 16000 in length.
> every alternate call to snd_pcm_writei is successful but only write in the
> vicinity of 1350 frames, instead of size which is initialised to length of
> buffer.
>
> Now, in the code below, the snd_pcm_recover function prints a message
> indicating a buffer under-run has occured, however, it returns a 0,
> indicating success in recovery from the error!
>
> I am not sure how to deal with this -- is there a problem with my ALSA
> libraries?
> Sorry about the length of this email and thanks again,
>
> Ashlesha.
>
> while(size>(2*period_size))
> > {
> > frames = snd_pcm_writei (pcm_handle, buffer, size);
> > printf("frames returned is %d\n",frames);
> > if (frames>0)
> >     temp=frames;
> > if (frames ==  -32){
> >           frames = snd_pcm_recover(pcm_handle, frames, 0);
> >           printf("recover returned %d\n",frames);
> >           }
> > if (frames < 0){
> >           printf("snd_pcm_writei failed: %s\n", snd_strerror(frames));
> >           return -1;
> >           }
> > printf("%d frames written\n",frames);
> > if(temp>0)
> >     size=size-temp;
> > }
> >
>
>
