From: erumusele Odigie <erumusele@gmail.com>
Subject: Re: Setting gain/volume of PCM capture or playback
Date: Tue, 9 Jun 2009 00:55:07 -0700
Message-ID: <edeadc8c0906090055v5255ef0fhe13f54e2a75e288d@mail.gmail.com>
References: <edeadc8c0906051922m2b0d7e97we01bff33157d5197@mail.gmail.com>
	<4A2D1936.1010604@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id AEF432457C
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 09:55:08 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c3so2092013ana.2
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 00:55:07 -0700 (PDT)
In-Reply-To: <4A2D1936.1010604@tse.gov.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Fausto for the example, I now have sample code to play with.

I am actually interested in playing with the capture volume/gain, but I will
go ahead and experiment with that myself.

Sele




On Mon, Jun 8, 2009 at 6:59 AM, Fausto Carvalho Marques SIlva <
fausto@tse.gov.br> wrote:

> I think you could do that way :
>
> *****************************************************************
>   if (salsa_volume(hctl,"PCM Playback Volume",volume)) {
>       salsa_close(hctl);
>       return;
>   }
> *****************************************************************
>
> *****************************************************************
> static int salsa_volume(snd_hctl_t * hctl,char * device,int vol)
> {
>   int err;
>
>
>   snd_ctl_elem_id_t *id;
>   snd_ctl_elem_value_t *control;
>
>   snd_ctl_elem_id_alloca(&id);
>   snd_ctl_elem_id_set_name(id,device);
>   snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);
>
>   snd_hctl_elem_t *elem = snd_hctl_find_elem(hctl, id);
>
>   snd_ctl_elem_value_alloca(&control);
>   snd_ctl_elem_value_set_id(control, id);
>
>   if (vol>= 0 && vol<=31) {
>       snd_ctl_elem_value_set_integer(control,1,vol);
>       snd_ctl_elem_value_set_integer(control,0,vol);
>   } else
>       return -1;
>
>   err = snd_hctl_elem_write(elem, control);
>
>   if (err < 0)
>       return -1;
>   return 0;
> }
> *****************************************************************
>
>
> Helped??
>
> erumusele Odigie wrote:
>
>> Hi,
>>
>> I am new to programming with ALSA, and I would like to find out how to
>> change the gain (capture or playback) for my PCM device in my C code.
>>
>> I am aware I am supposed to use the mixer API, possibly functions like:
>> snd_mixer_selem_set_playback_volume()
>>
>> but I don't know how this function can be connected to my PCM
>> structure/device.
>>
>> Please whoever answers this should kindly attach some sample code, or a
>> link
>> to sample code because I can't find any on line.
>>
>> Thanks a lot.
>>
>> Erumusele
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>>
>>
>
>
> --
> Fausto Carvalho
> TSE/STI/CSELE/SEVIN
> 61 3316-3527
>
>
