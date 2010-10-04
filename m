From: Eric <ejaouen@ponctey.fr>
Subject: [STAC927x HDA codec] 0x1F function not supported by
	driver ?
Date: Mon, 04 Oct 2010 14:23:35 +0200
Message-ID: <4CA9C747.2010700@ponctey.fr>
References: <4969FBA0.1030008@ponctey.fr>	<s5hvdskdah9.wl%tiwai@suse.de><496B3BB7.1020203@ponctey.fr>	<496E7FE7.8020706@embeddedalley.com>	<16A430A423D62246A24C9A892622FE668D5227@CORPEXCH1.na.ads.idt.com>
	<498A1EBC.9060203@ponctey.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr
	[80.12.242.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 6804C1038C6
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 14:23:41 +0200 (CEST)
Received: from [192.168.100.4] (unknown [192.168.100.4])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client did not present a certificate)
	by anita.2sapins.ponctey.fr (Postfix) with ESMTPS id BC5F0519A7
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 14:23:36 +0200 (CEST)
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

Hi everybody I have some news : bad news but I was prepared to : as of
now the alsa codec driver for STAC9271 is not complete : its ADAT output
(vendor specific function) support is not complete.
I tested with the ADAT output option Matthew Ranostay had added in a
patch ( amixer sset 'IEC958 Playback Source' ADAT )
and also having changed the 0x21 pin default from 014521xx to 015521xx
(4 being spdif out and 5 being digital out) : when doing so "alsactl
restore" responded : unknown hardware HDAintel STAC ; hardware is
initialized using a guess method   (which is possibly normal )
In jack I only had 2 alsa outputs (allways using card0 device 1 : "STAC
digital").
Maybe the problem is that ADATout Node 0x1F is not detailled enough in
the driver ?

here is COMPLETE codec datasheet (page185 for 0x1F node ; page 155 for
0x21 digOUT node):
http://pdf1.alldatasheet.com/datasheet-pdf/view/199321/IDT/STAC9271.html

here a alsa-info.sh of me (before changing to 015521xx pin config):

www.alsa-project.org/db/?f=3D297fa42ac3c439e3ca9336d1fa525a2cadabdae6


Hoping to get help to at least try to make it work : I bought intel
DP35DP motherboard ONLY for the advertised "ADAToutput feature".
Thanks a lot in advance, Eric

> Hi Steven,
> I have studied the hd audio documents :
> Please make sure the pin default is actually 015521xx when in ADAT mode
> (instead of config default 014521xx ) .
> =

> Please copy me your alsainfo script if it still does not work.
> =

> Matthew Ranostay is right : really not much is missing or wrong for ADAT
> to work.
> Thanks everybody for future help, Eric
> =

> Tellman, Steven a =E9crit :
>> It doesn't work. The option comes up, but no dice. Doesn't lock to the
>> receiver that has ADAT support.
> =

>> Hello Eric,
>> You should run the latest ALSA from the git tree because I added a codec
>> specific SPDIF output control control for that chipset.
>>
>> ....
>>  417 static const char *stac927x_spdif_labels[5] =3D {
>>  418     "Digital Playback", "ADAT", "Analog Mux 1",
>>  419     "Analog Mux 2", "Analog Mux 3"
>>  420 };
>> ....
>>
>> I haven't tested ADAT output though but I have no reason to
>> think it wouldn't work.
>>
>> Thanks,
>>
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
>>> Is it working in Alsa ? Many HTPC users would love that... I would !
>>>
>>> Anybody from intel or IDT/sigmatel to confirm (by checking the
>> sigmatel
>>> STAC927x hda codec driver) that it will work ?
>>> I want these intel motherboards only for this ADAT output feature and
>> I
>>> am a linux only user so I would like to know before buying...
>>> I want to be sure someone would make the necessary changes to the hda
>>> sigmatel codec alsa driver so it would work.
>>> Thank you everybody
>>>
>>>
>>>>> Is the ADAT output of the IDT (sigmatel) STAC927x HDA codec
>> supported in
>>>>> alsa ?
>>>>> If not could someone please try to add this incredibly nice feature
>> in
>>>>> the existing alsa driver ?
>>>
>>>> Do you have any HD-audio device with ADAT?
>>>> IIRC, there is no specific verbs for ADAT on STAC927x...
>>>> Takashi
