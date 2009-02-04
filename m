From: Eric <ejaouen@ponctey.fr>
Subject: Re: intel DP35DP adat supported (STAC927x codec) ?
Date: Thu, 05 Feb 2009 00:03:24 +0100
Message-ID: <498A1EBC.9060203@ponctey.fr>
References: <4969FBA0.1030008@ponctey.fr>	<s5hvdskdah9.wl%tiwai@suse.de><496B3BB7.1020203@ponctey.fr>	<496E7FE7.8020706@embeddedalley.com>
	<16A430A423D62246A24C9A892622FE668D5227@CORPEXCH1.na.ads.idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp21.orange.fr (smtp21.orange.fr [80.12.242.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DE4524442
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 00:03:30 +0100 (CET)
Received: from anita.2sapins.ponctey.fr
	(LRouen-151-72-65-95.w193-251.abo.wanadoo.fr [193.251.41.95])
	by mwinf2121.orange.fr (SMTP Server) with ESMTP id 8BD661C0009E
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 00:03:29 +0100 (CET)
Received: from [192.168.100.3] (unknown [192.168.100.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by anita.2sapins.ponctey.fr (Postfix) with ESMTPS id 73D945161B
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 00:03:28 +0100 (CET)
In-Reply-To: <16A430A423D62246A24C9A892622FE668D5227@CORPEXCH1.na.ads.idt.com>
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

Hi Steven,
I have studied the hd audio documents :
Please make sure the pin default is actually 015521xx when in ADAT mode
(instead of config default 014521xx ) .

Please copy me your alsainfo script if it still does not work.

Matthew Ranostay is right : really not much is missing or wrong for ADAT
to work.
Thanks everybody for future help, Eric

Tellman, Steven a =E9crit :
> It doesn't work. The option comes up, but no dice. Doesn't lock to the
> receiver that has ADAT support.

> Hello Eric,
> You should run the latest ALSA from the git tree because I added a codec
> specific SPDIF output control control for that chipset.
> =

> ....
>  417 static const char *stac927x_spdif_labels[5] =3D {
>  418     "Digital Playback", "ADAT", "Analog Mux 1",
>  419     "Analog Mux 2", "Analog Mux 3"
>  420 };
> ....
> =

> I haven't tested ADAT output though but I have no reason to
> think it wouldn't work.
> =

> Thanks,
> =

> Matt Ranostay
> =

> =

> Eric wrote:
>> In their handbook, motherboard intel DP35DP and others with STAC927x
> (in
>> the codec datasheet also ADAT output is featured on older sigmatel
>> STAC9271 and now IDT STAC9274 only) advertise ADAT output possible on
>> their toslink.
>> DP35DP and other intel boards are proven to have the ADAT output
> working
>> under windows.
>> Is it working in Alsa ? Many HTPC users would love that... I would !
>>
>> Anybody from intel or IDT/sigmatel to confirm (by checking the
> sigmatel
>> STAC927x hda codec driver) that it will work ?
>> I want these intel motherboards only for this ADAT output feature and
> I
>> am a linux only user so I would like to know before buying...
>> I want to be sure someone would make the necessary changes to the hda
>> sigmatel codec alsa driver so it would work.
>> Thank you everybody
>>
>>
>>>> Is the ADAT output of the IDT (sigmatel) STAC927x HDA codec
> supported in
>>>> alsa ?
>>>> If not could someone please try to add this incredibly nice feature
> in
>>>> the existing alsa driver ?
>>
>>> Do you have any HD-audio device with ADAT?
>>> IIRC, there is no specific verbs for ADAT on STAC927x...
>>> Takashi
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
