From: Gustavo da Silva Serra <gustavo.serra@tet.com.br>
Subject: Re: Problem with aloop
Date: Tue, 13 May 2008 10:45:19 -0300
Message-ID: <48299B6F.8010302@tet.com.br>
References: <d5eabee70805130627v1dd7b675ua4fadc9bd1905357@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050502020904060706040600"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einstein.tteng.com.br (mail4.tteng.com.br [201.47.194.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 0770C24B02
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:45:26 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by einstein.tteng.com.br (Postfix) with ESMTP id 97CF6120031
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 10:45:23 -0300 (BRST)
Received: from [192.168.0.84] (gserra.tteng.com.br [192.168.0.84])
	by einstein.tteng.com.br (Postfix) with ESMTP id 70E3512000E
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 10:45:20 -0300 (BRST)
In-Reply-To: <d5eabee70805130627v1dd7b675ua4fadc9bd1905357@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------050502020904060706040600
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

I tryied to use the HG versions, but they didn't work well for me. Maybe=20
you should give the 1.0.16 a try, just to make sure.
I need an asound.conf since my network application uses a very low=20
latency, that is not default. I am attaching my asound.conf.
Another possible source of problems are the artsd and esd daemons, are=20
they running?

Hope that helps.

Benjamin van den Hout escreveu:
> Gustavo da Silva Serra wrote:
>
> I had some problems until I could figure it out how to configure alsa
>  =20
>> properly in /etc/asound.conf. Maybe this could be your problem? What i=
s
>> your alsa version? I heard that aloop didn't work well until 1.0.15, o=
r
>> such (alsa guys: is this true?).
>>
>>    =20
>
> My alsa is 1.0.14 but I'm using the 'HG' version of the alsa-drivers an=
d
> alsa-kernel packages so that basically gets me the latest-and-greatest
> drivers from the source repository if I understand correctly. I saw som=
e
> patches coming by in February and they are already in there so I presum=
e I'm
> working with the most current source.
>
> I'm intrigued by the asound.conf, is there any specific configuration y=
ou
> needed to make the aloop device work properly? I'm using the
> distro-configured alsa (ubuntu 7.10) and there is no such file somehwer=
e in
> /etc. Even on my debian server (running Etch), I can't find it.
>
> Kind regards,
> Benjamin
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> __________ NOD32 3095 (20080513) Information __________
>
> This message was checked by NOD32 antivirus system.
> http://www.eset.com
>
>
>
>  =20


--=20
Gustavo da Silva Serra        gustavo.serra@tet.com.br
=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97
Tools & Technologies - T&T Engenheiros Associados Ltda.
Projetos de SW & HW - Desenvolvendo solu=E7=F5es.
Rua Riachuelo, 1098 Conj. 1204
Centro - Porto Alegre - CEP 90010-272
Fone DDR: (51)3220-3290
Fone/Fax: (51)3220-3220 / 3220-3206
http://www.tet.com.br/                                             tet@te=
t.com.br


--------------050502020904060706040600
Content-Type: text/plain;
 name="asound.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asound.conf"

pcm.dmixed {
    type dmix
    ipc_key 372891
    ipc_key_add_uid true
    slave {
        pcm "hw:0,0,0"
        period_time 20000
        buffer_time 80000
    }
    bindings {
        0 0
        1 1
    }
}

pcm.playsoftvol {
    type softvol
    slave.pcm "dmixed"
    control {
        name "Master"
        card 0
        device 0
        subdevice 0
    }
}

pcm.dsnooped {
    type dsnoop
    ipc_key 573194
    ipc_key_add_uid true
    slave {
        pcm "hw:0,1,0"
        period_time 20000
        buffer_time 80000
    }
    bindings {
        0 0
        1 1
    }
}

pcm.fullduplex {
    type asym
    playback.pcm "playsoftvol"
    capture.pcm "dsnooped"
}

pcm.!default {
    type plug
    slave.pcm "fullduplex"
}

pcm.dsp0 {
    type plug
    slave.pcm "fullduplex"
}

ctl.mixer0 {
    type hw
    card 0
    device 0
    subdevice 0
}

--------------050502020904060706040600
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050502020904060706040600--
