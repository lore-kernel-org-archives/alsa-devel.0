From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Mon, 18 May 2009 10:52:44 +0800
Message-ID: <4b8c423b0905171952w5a28c6b3pe8d16fc6e9ccef50@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h4ovj7hva.wl%tiwai@suse.de>
	<d54969c50905171348v12a58613sa8425f450e843eea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B9901037F3
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 04:52:45 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1293961rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 19:52:44 -0700 (PDT)
In-Reply-To: <d54969c50905171348v12a58613sa8425f450e843eea@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes I did try model=3Dacer-aspire-4930g. That gives me even lesser
functionality than model=3Dauto (Surround volume can no longer be used to
adjust line-out volume) I think the 4930G uses a ALC888 and the
6935/6920/8920/8930 use a ALC889 (0x10ec0889) codec. Any way of obtaining
the verbs from the Windows driver?

Some more info (obtained by generally trying out verbs)

0x15 SET_EAPD_BTLENABLE 2 and 0x14 SET_EAPD_BTLENABLE 2 are both needed to
get the amps fired

0x14 SET_CONNECT_SEL 0x00 connects the laptop speakers and disconnects
line-out
0x14 SET_CONNECT_SEL 0x01 connects the line-out but laptop speakers continue
to function

0x15 SET_CONNECT_SEL 0x00 connects the laptop speakers and disconnects the
subwoofer
0x14 SET_CONNECT_SEL 0x01 connects the subwoofer but laptop speakers
continue to function
0x15 SET_PIN_WIDGET_CONTROL 0x00 turns off the line-out
0x15 SET_PIN_WIDGET_CONTROL 0x40 turns on the line-out but laptop-speakers
stay on
0x15 SET_PIN_WIDGET_CONTROL 0xc0 Same as above but line-out volume is much
higher

0x0c SET_AMP_GAIN_MUTE 0x7080 (Mutes all channels)
0x0c SET_AMP_GAIN_MUTE 0x7000 (Un-mutes all channels)

The Realtek Linux driver had one ALC889 model entry for the M90V ALC889
codec with model param as asus-dig. I tried that out. With that headphone
jack sensing worked in the sense that as soon as a headphone was plugged in,
the subwoofer turned off, though the front speakers were still on. I did get
line-out volume though, it was very feeble. The internal mic still did not
work and nor did an external one.

Regards,
Karthik

On Mon, May 18, 2009 at 4:48 AM, Emilio L=F3pez <buhitoescolar@gmail.com>wr=
ote:

> I seem to have the same card looking at lspci -v, and I experience the sa=
me
> problems. My laptop is an Acer Aspire 6930, so maybe the Acer bioses are
> broken? I got the sound to work (with the controls mapped uncorrectly), b=
ut
> I still can't make the mic work. I'll try with that model, I also tried w=
ith
> acer and acer-aspire with no luck.
>
> Emilio
>
> 2009/5/17 Takashi Iwai <tiwai@suse.de>
>
>> At Sat, 16 May 2009 11:51:36 +0800,
>> Karthik Ramgopal wrote:
>> >
>> > Hi,
>> >        Even after enabling DEBUG using --with-debug option with
>> configure when
>> > compiling the alsa-driver snapshot leaves no more error messages in the
>> dmesg
>> > logs. The only message relating to HDA is:
>> >
>> > [   41.104817] hda-intel: IRQ timing workaround is activated for card
>> #0.
>> > Suggest a bigger bdl_pos_adj.
>> >
>> > I just got the line-out output to work by toggling the surround volume.
>> I
>> > still think it's a mapping problem. The headphone switch is turning the
>> > subwoofer on and off, and the surround volume is controlling the
>> line-out
>> > volume.
>>
>> OK, this implies that the BIOS setup is broken.
>> Did you try model=3Dacer-aspire-4930g, BTW?
>>
>>
>> Takashi
>>
>> > None of the line-in devices function and all of the amp-ins 0x0b to
>> > 0x0f are muted. Cannot find any verb to unmute them. hda-verb with
>> > SET_EAPD_BTLENABLE 2 at 0x15 is still needed at startup to fire up the
>> amps.
>> >
>> > Please help.
>> >
>> > Regards,
>> > Karthik
>> >
>> >
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
>
