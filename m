From: maarten van es <maarten.h.van.es@gmail.com>
Subject: salsa with noninterleaved needs irqpoll?
Date: Sat, 25 Apr 2009 17:41:23 +0100
Message-ID: <bca65b460904250941t3132fcdfw976b4fa2c0b0a7bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id EB595244AC
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 18:41:23 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so313175fgg.21
	for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2009 09:41:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>>
>>> And what about the sample format? =A0I looked at the drivers; the two
>>> sound cards do not have a common sample format.
>>>
>>>
>>> Best regards,
>>> Clemens
>>>
>>
>
> Thanks, the problem was indeed that I was setting hwparams that are
> not supported by the card. I do think salsa lib could return a more
> relevant error than "operation not permitted" and I'll see if I can
> come up with something for that.
> Right now though I am trying to figure out what snd_pcm_writen needs
> for its second parameter, void** bufs. I get the error "bad address"
> when passing in an array of pointers to a malloc-ed space big enough
> to hold a channels' worth of data. Sorry if I am missing obvious
> documentation about this, but what should I pass for this parameter?
>
> Regards
> Maarten
>

Hi again,

Ok, now I finally got everything working and am asking the following
mostly out of curiosity. The problem I had with snd_pcm_writen by the
way has to do somehow with using a chroot environment; everything
works when directly booting into the uclibc / salsa system. For it to
work I need to add "irqpoll" to the kernel boot options. Without this,
the card does not start playing (though no error messages from salsa)
and after a few seconds the kernel tells me to add irqpoll to the boot
options. On a glibc / alsa based system everything works fine without
this option as it does with a c-media card with salsa. What does it do
and why is it needed with the hdsp 9632 on a system with salsa?

Thanks
Maarten
