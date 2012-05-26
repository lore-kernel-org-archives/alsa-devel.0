From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: snd-usb endpoint rework
Date: Sat, 26 May 2012 08:40:46 +0200
Message-ID: <CAFz=ag6p5rouC4zFN7ezr79smS62Fzs8Jt4NBX3nxSUd_PKtdA@mail.gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
	<4FBA1F01.4010606@gmail.com>
	<CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
	<4FBAC776.9060801@gmail.com>
	<CAE-xCyPEhMQjPYdbSShDo8P6nEeYSrKWJdKTMi+B_ws7Wq8sUA@mail.gmail.com>
	<4FBCEBDB.6000209@gmail.com>
	<CACckToWtFep7G4Qn=JAwJMdxwQadiQ8_KSi84D7A2vLKQihV6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D424724449
	for <alsa-devel@alsa-project.org>;
	Sat, 26 May 2012 08:40:47 +0200 (CEST)
Received: by yenr13 with SMTP id r13so858261yen.38
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2012 23:40:46 -0700 (PDT)
In-Reply-To: <CACckToWtFep7G4Qn=JAwJMdxwQadiQ8_KSi84D7A2vLKQihV6A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

2012/5/26 Grant Diffey <gdiffey@gmail.com>:
> Felix,
>
> the effects controls are not obvious to me I thought there were independent
> fx sends for each output so expected 16x4 new controls plus the returns but
> maybe that's not howitis.

I have been confused about it, too. But that's just how the FTU works.
There are only 16 sends.

>
> also has anyone looked at how metering is reported on the wire?

At least I have not.

Regards,
Felix
