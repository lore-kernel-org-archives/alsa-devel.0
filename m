From: "E.D.V." <erdv38@gmail.com>
Subject: Re: Alsa 1.0.13 (and others) does not work on ALC880
Date: Sat, 19 May 2007 19:22:12 +0200
Message-ID: <464F3244.6010602@gmail.com>
References: <Pine.LNX.4.58.0705190144230.8331@integrity.ugnet.org>
	<s5h7ir4etl6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp23.orange.fr (smtp23.orange.fr [193.252.22.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E67624461
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 19:22:14 +0200 (CEST)
In-Reply-To: <s5h7ir4etl6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andrew Callan <acallan.alsa@ugnet.org>
List-Id: alsa-devel@alsa-project.org

Well, on this laptop (D900t Eurocom) BIOS modification is very limited,
and it is not possible to modify or switch codecs, so as I think it is
enabled it is not possible to disable it ...

Takashi Iwai a =E9crit :
> At Sat, 19 May 2007 02:08:14 -0500 (CDT),
> Andrew Callan wrote:
>   =

>> I have been without sound using Fedora Core ever since the 2.6.16 or
>> 2.6.17 kernel update (2.6.16 crashed during initialization, so I could n=
ot
>> tell whether sound worked or not).  It had worked well through the 2.6.15
>> Fedora kernels.  I finally sat down tonight to work the problem as hard =
as
>> I could and happened upon Eric and Tobin's timely exchange.
>>
>> First, simply adding probe_mask=3D1 to the snd-hda-intel options worked =
for
>> me as well; I did not end up having to specify a specific model.
>>
>> Second, I too was seeing a LONG hang when trying to do:
>> cat /proc/asound/card0/codec#0
>> but now with the probe_mask=3D1, I do not see this.
>>
>> If it helps, the alsa-info.sh output for my system is at
>> http://pastebin.ca/496293
>> If it makes any difference, I'm not sure which model I had specified on
>> the modprobe line at the time I captured this output.
>>
>> One thing I do notice is that after adding probe_mask=3D1, aplay -l does=
 not
>> show the Si3054 Modem which shows up in the alsa-info output.
>>
>> Thanks for the help you gave in the thread with Eric.
>>
>> Andrew
>>     =

>
> Interesting.  I've seen similar reports that probe_mask helps.
> Do you disable the modem codec on BIOS or is it enabled?
>
> If this happens even though it's enabled on BIOS, we'd need a
> blacklist of non-working devices, or a more robust probing routine...
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   =
