From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Sat, 26 May 2012 14:19:26 +1000
Message-ID: <CACckToWtFep7G4Qn=JAwJMdxwQadiQ8_KSi84D7A2vLKQihV6A@mail.gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
	<4FBA1F01.4010606@gmail.com>
	<CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
	<4FBAC776.9060801@gmail.com>
	<CAE-xCyPEhMQjPYdbSShDo8P6nEeYSrKWJdKTMi+B_ws7Wq8sUA@mail.gmail.com>
	<4FBCEBDB.6000209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 47411243BE
	for <alsa-devel@alsa-project.org>;
	Sat, 26 May 2012 06:19:27 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1079814wgb.20
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2012 21:19:26 -0700 (PDT)
In-Reply-To: <4FBCEBDB.6000209@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

[SNIP]

(sorry daniel you get two copies because I forgot to cc list and others

> > If there is anything else I can provide to you, let me know.
> > Hope all this help somehow!
>
> I need to be able to see the issues you describe. Once I do, I'll work
> fixing them!
>
>
> Daniel
>

ok I just built a new kernel.

I started with 3.4 then applied the rt7 patches then merged the topic/misc
tree from sound (to get the ftu fixes from felix and daniel

so I have 3.4-rt7+sound/topic/misc

checkout v3.4 tag then apply the -rt patches using quiltapply then merge
sound/topic/misc

This all seems to be working ok. if I start jack with anything less that
128 samples It starts but I get no audio and lots of xruns (this is the
same as on previous kernel 3.4-rc4-rt5)

i've run jack_iodelay through a loopback (TRS from output 3 to input 3 on
the back of the FTU) for several hours without any problems

Felix,

the effects controls are not obvious to me I thought there were independent
fx sends for each output so expected 16x4 new controls plus the returns but
maybe that's not howitis.

also has anyone looked at how metering is reported on the wire?

Grant.
