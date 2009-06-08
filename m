From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Re: Setting gain/volume of PCM capture or playback
Date: Mon, 08 Jun 2009 10:59:18 -0300
Message-ID: <4A2D1936.1010604@tse.gov.br>
References: <edeadc8c0906051922m2b0d7e97we01bff33157d5197@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.186.60.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 667C424436
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 15:58:09 +0200 (CEST)
In-Reply-To: <edeadc8c0906051922m2b0d7e97we01bff33157d5197@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: erumusele Odigie <erumusele@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I think you could do that way :

*****************************************************************
    if (salsa_volume(hctl,"PCM Playback Volume",volume)) {
        salsa_close(hctl);
        return;
    }
*****************************************************************

*****************************************************************
static int salsa_volume(snd_hctl_t * hctl,char * device,int vol)
{
    int 
err;                                                                                                                                                 

    snd_ctl_elem_id_t *id;
    snd_ctl_elem_value_t *control;

    snd_ctl_elem_id_alloca(&id);
    snd_ctl_elem_id_set_name(id,device);
    snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);

    snd_hctl_elem_t *elem = snd_hctl_find_elem(hctl, id);

    snd_ctl_elem_value_alloca(&control);
    snd_ctl_elem_value_set_id(control, id);

    if (vol>= 0 && vol<=31) {
        snd_ctl_elem_value_set_integer(control,1,vol);
        snd_ctl_elem_value_set_integer(control,0,vol);
    } else
        return -1;

    err = snd_hctl_elem_write(elem, control);

    if (err < 0)
        return -1;
    return 0;
}
*****************************************************************


Helped??

erumusele Odigie wrote:
> Hi,
>
> I am new to programming with ALSA, and I would like to find out how to
> change the gain (capture or playback) for my PCM device in my C code.
>
> I am aware I am supposed to use the mixer API, possibly functions like:
> snd_mixer_selem_set_playback_volume()
>
> but I don't know how this function can be connected to my PCM
> structure/device.
>
> Please whoever answers this should kindly attach some sample code, or a link
> to sample code because I can't find any on line.
>
> Thanks a lot.
>
> Erumusele
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   


-- 
Fausto Carvalho
TSE/STI/CSELE/SEVIN
61 3316-3527
