From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: question on hardware mixing
Date: Fri, 5 Dec 2008 22:56:52 +0530
Message-ID: <98769532B4BB14429434178695419EAE2686133A@bgsmsx501.gar.corp.intel.com>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<fd3eb9bf0812050912p2e065315q1c78bf831bd9d0e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F9C024349
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 18:27:02 +0100 (CET)
In-Reply-To: <fd3eb9bf0812050912p2e065315q1c78bf831bd9d0e1@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-2?Q?Vedran_Mileti=E6?= <rivanvx@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks.

If I need to send a voice stream and an audio stream to the hardware as two=
 separate streams... I just need to open 2 ALSA device from user space and =
send it right?

If I want to send some private data for each stream (say I want to differen=
tiate that it's a voice/music...for which I did not find any provision) how=
 do I do that?

-----Original Message-----
From: Vedran Mileti=E6 [mailto:rivanvx@gmail.com] =

Sent: Friday, December 05, 2008 10:42 PM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] question on hardware mixing

It does that by default. Just run multiple applications.

2008/12/5 Harsha, Priya <priya.harsha@intel.com>:
> Hi,
>
> If my sound card supports hardware mixing, how do I need to code my sound=
 card driver such that I can send multiple streams through ALSA to the soun=
d card driver at the same time?
>
> Thanks,
> Harsha
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Vedran Mileti=E6
