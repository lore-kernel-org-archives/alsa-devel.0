From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [LAD] announcing envy24control, mudita (*) edition.
Date: Wed, 4 Aug 2010 13:38:38 +0800
Message-ID: <AANLkTi=srCoxcNf9gfbA_Mo8yFbdJe4AMPSHack4XqfY@mail.gmail.com>
References: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
	<201007282012.39291.termtech@rogers.com>
	<201007282110.33065.termtech@rogers.com>
	<201007311506.56614.termtech@rogers.com>
	<AANLkTik61RwcMtZQ6VsD7JHtvdC9F=N2kgjiS9JoMiV9@mail.gmail.com>
	<20100801225410.GF4060@zita2>
	<AANLkTi=e_uy_44wmn=zK5Nd=W28wu0M3NocLR7nO+=B0@mail.gmail.com>
	<AANLkTikyxQGAVUj8aY7pMRKfxf1c6cUgn8b4aw2kmWY-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 568EC244EA
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 07:38:40 +0200 (CEST)
Received: by vws20 with SMTP id 20so4227651vws.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 22:38:38 -0700 (PDT)
In-Reply-To: <AANLkTikyxQGAVUj8aY7pMRKfxf1c6cUgn8b4aw2kmWY-@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/8/4 Niels Mayer <nielsmayer@gmail.com>

> FYI, I added the following since
> http://nielsmayer.com/envy24control/mudita24-1.0.1.tar.gz
> ... shall I release a 1.0.2 with the following additions (?):
>
>   * fixed --card and --device to allow valid ALSA names and numbers
>        ( https://bugzilla.redhat.com/show_bug.cgi?id=602900 ).
>

./envy24control -Ddefault

card_number = atoi(strchr(name, ':') + sizeof(char));

This bug seem still occur when name does not contain ":" since ctl device is
"hw:n" where n is card number

http://git.alsa-project.org/?p=alsa-tools.git;a=blobdiff;f=envy24control/envy24control.c;h=c7ee4daf54ddb69d0a90636ed157bb81ba019671;hp=3cbf154c959d1882dff8753bc31dd51bd56a52f9;hb=8d4747de3c96c25688a3a5cdcfd56ed3035f5a55;hpb=2115618facbbc88a7323f3f0d6a7780e311408d2
