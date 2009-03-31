From: Eric <ejaouen@ponctey.fr>
Subject: Re: intel DP35DP adat supported (STAC927x codec) ?
Date: Tue, 31 Mar 2009 03:53:28 +0200
Message-ID: <49D17798.6040205@ponctey.fr>
References: <4969FBA0.1030008@ponctey.fr>	<s5hvdskdah9.wl%tiwai@suse.de><496B3BB7.1020203@ponctey.fr>	<496E7FE7.8020706@embeddedalley.com>	<16A430A423D62246A24C9A892622FE668D5227@CORPEXCH1.na.ads.idt.com>
	<498A1EBC.9060203@ponctey.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp20.orange.fr (unknown [80.12.242.27])
	by alsa0.perex.cz (Postfix) with ESMTP id D77FB103807
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 03:54:12 +0200 (CEST)
Received: from anita.2sapins.ponctey.fr
	(LRouen-151-72-65-95.w193-251.abo.wanadoo.fr [193.251.41.95])
	by mwinf2012.orange.fr (SMTP Server) with ESMTP id 72D5620000AF
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 03:54:12 +0200 (CEST)
Received: from [192.168.100.3] (unknown [192.168.100.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by anita.2sapins.ponctey.fr (Postfix) with ESMTPS id 92DB65178D
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Mar 2009 03:54:11 +0200 (CEST)
In-Reply-To: <498A1EBC.9060203@ponctey.fr>
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

Hi all, I bought motherboards intel DP35DP and DG33TL and just tried
ADAT output in Alsa (ADAT output on them is proven to work under windows).
I wrote the command (thanks to the work of Matthew for the 'IEC958
Playback Source' control.28 setting) :
amixer sset 'IEC958 Playback Source' ADAT

Here is my resulting alsainfo:
www.alsa-project.org/db/?f=3Dcb01bf4f7bc62fe69f36bc1a4bbc0dbcace20605

It still does not work
I think the reason is that contrary to the windows driver the
Node 0x21 is still unchanged :
Pin Default 0x01452150: [Jack] SPDIF Out
whereas it should be better with :
		0x01552150

How can I change my computer from the Pin default config to this
alternative Pin config ?

Anybody has any other idea to help ?
Thanks a lot, Eric

> Hi Steven,
> I have studied the hd audio documents :
> Please make sure the pin default is actually 015521xx when in ADAT mode
> (instead of config default 014521xx ) .
> =

> Please copy me your alsainfo script if it still does not work.
> Matthew Ranostay is right : really not much is missing or wrong for ADAT
> to work.
> Thanks everybody for future help, Eric
> Tellman, Steven a =E9crit :
>> It doesn't work. The option comes up, but no dice. Doesn't lock to the
>> receiver that has ADAT support.

>> Hello Eric,
>> You should run the latest ALSA from the git tree because I added a codec
>> specific SPDIF output control control for that chipset.
>> ....
>>  417 static const char *stac927x_spdif_labels[5] =3D {
>>  418     "Digital Playback", "ADAT", "Analog Mux 1",
>>  419     "Analog Mux 2", "Analog Mux 3"
>>  420 };
>> ....
>> I haven't tested ADAT output though but I have no reason to
>> think it wouldn't work.
>> Thanks,
>> Matt Ranostay
>>
>>
>> Eric wrote:
>>> In their handbook, motherboard intel DP35DP and others with STAC927x
>> (in
>>> the codec datasheet also ADAT output is featured on older sigmatel
>>> STAC9271 and now IDT STAC9274 only) advertise ADAT output possible on
>>> their toslink.
>>> DP35DP and other intel boards are proven to have the ADAT output
>> working
>>> under windows.
>>> Is it working in Alsa ?>>>
>>> Anybody from intel or IDT/sigmatel to confirm (by checking the
>> sigmatel
>>> STAC927x hda codec driver) that it will work ?
>>> I want these intel motherboards only for this ADAT output feature and
>> I
>>> am a linux only user so I would like to know before buying...
>>> I want to be sure someone would make the necessary changes to the hda
>>> sigmatel codec alsa driver so it would work.
