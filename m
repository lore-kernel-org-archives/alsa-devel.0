From: Valerio Tesei <valerio.tesei@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
 Headphone with realtek codec
Date: Thu, 05 May 2011 21:50:59 +0200
Message-ID: <4DC2FFA3.9040601@gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4526510381C
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 21:51:03 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2120318wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 12:51:02 -0700 (PDT)
In-Reply-To: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
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

Il 04/05/2011 17:42, Raymond Yau ha scritto:
> Request for testers to test the patch
>
> Multistreaming allows you to listen to one audio source through the back
> panel speakers and a second audio source through front panel headphones or
> speakers.
>
> Hardware requirement
> 1) 10 channels realtek codec (e.g. alc892) which already work with
> model=auto
> 2) Headphone at front panel and Line out at rear panel
>
> "hw:0,0" is used for the rear panel audio jack
> "hw:0,2" is used for the front panel headphone when "Independent HP" is
> switched ON
>
> Add an "Independent HP" switch to turn this feature on/off for desktop for
> those HDA codec
>
> Test:
> 1) speaker-test -c 8 -t wav -Dhw:0,0
> 2) speaker-test -c 2 -t wav -Dhw:0,2
>
> It will need modification to support this feature for those desktop with 8
> channels codec
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
So i made the test, i correctly hear the tests, 7 outputs for the rear
panel, and 2 for the front, but when i play the first test, i hear on
the front panel some noise and realy crackly and whispered the tests
when front left and front right are played, i guess it is not normal,
may this help?

-- 
*Email:* valerio.tesei@gmail.com
*Cellulare:* +39.3394768306
*Gtalk:* valerio.tesei@gmail.com
*LinkedIn:* http://www.linkedin.com/pub/valerio-tesei/22/a87/577
