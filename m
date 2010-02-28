From: giggz <giggzounet@gmail.com>
Subject: Re: [Regression] With the new 2.6.33 when I plug
 headphones, the speaker doen't get off anymore
Date: Sun, 28 Feb 2010 15:29:25 +0100
Message-ID: <4B8A7DC5.1050302@gmail.com>
References: <hm82oh$1am$1@dough.gmane.org> <4B892557.7050904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 68A78243EB
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 15:29:01 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nlk8h-0002GZ-UQ
	for alsa-devel@alsa-project.org; Sun, 28 Feb 2010 15:28:59 +0100
Received: from d018211.adsl.hansenet.de ([80.171.18.211])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 15:28:59 +0100
Received: from giggzounet by d018211.adsl.hansenet.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 15:28:59 +0100
In-Reply-To: <4B892557.7050904@gmail.com>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

giggz a =E9crit :
> giggzounet a =E9crit :
>> Hi,
>>
>> I have installed debian stable lenny + backports on an eeepc 1201n. With
>> the 2.6.30 or 2.6.32 from lenny-backport I don't have problem with sound
>> : when I plug the headphones, speakers get off.
>>
>> I have tested with 2.6.33 and when I plug headphones, speakers don't get
>> off anymore. so I have sound in headphones and speakers.
>>
>> 22:42 giggz@baal ~ % cat /proc/asound/card0/codec#* | grep Codec
>> Codec: Realtek ALC269
>> Codec: Nvidia MCP7A HDMI
>>
>> I attach the output of alsa-info with the 2.6.32.9 and the 2.6.33 (I'm
>> in a Uni Campus and it's quite difficult to have internet on a external
>> laptop...so I attach them at this mail and I don't upload them on pastbi=
n).
>>
>> I have opened a bug on the kernel bugzilla (bug 15399). Should I provide
>> anything more ?
>>
> =

> Following the advice of Paul Menzel I did a "diff" of the sources of the
> 2.6.32.9 kernel and of the 2.6.33. In patch_realtek.c, we see that there
> is an new snd_hda_jack_detect funtion with 2 arguments. I have noticed
> that the second argument is "normaly" the second argument of
> snd_hda_codec_read. In the alc269_speaker_automute function there is
> this new snd_hda_jack_detect function, but the second argument is "nid".
> But in the old alc269_speaker_automute of the 2.6.32.9 the second
> argument of snd_hda_codec_read is 0x15. So I think there is perhaps a
> bug here...But I hesitate to modify the source...so I'm waiting the
> anwser of the dev.
> =

> --- patch_realtek.c	2010-02-27 14:58:06.000000000 +0100
> +++ patch_realtek_modif.c	2010-02-27 14:58:54.000000000 +0100
> @@ -13381,7 +13381,7 @@
>  	unsigned int present;
>  	unsigned char bits;
> =

> -	present =3D snd_hda_jack_detect(codec, nid);
> +	present =3D snd_hda_jack_detect(codec, 0x15);
>  	bits =3D present ? AMP_IN_MUTE(0) : 0;
>  	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
>  				AMP_IN_MUTE(0), bits);
> =


I tested it. And with this modif in the kernel, after recompilation and
reboot, my problem is headphones and speaker is gone.

Best regards,
Guillaume
