From: "=?ISO-8859-1?Q?Andreas_P=E5hlsson?=" <andreas@pahlsson.info>
Subject: Re: Avoid overload of PCM volume on Cx5045 codec
Date: Thu, 19 Jun 2008 13:34:25 +0200
Message-ID: <fff10a40806190434u6998dbfaq23d2f0148704be85@mail.gmail.com>
References: <fff10a40806181258t20e5c5f5rfd9fc234a91770d8@mail.gmail.com>
	<s5hk5gl92hi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 71403245A7
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 13:34:27 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so5371518rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2008 04:34:26 -0700 (PDT)
In-Reply-To: <s5hk5gl92hi.wl%tiwai@suse.de>
Content-Disposition: inline
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

Hardware:

    description: Notebook
    product: AMILO Pro V3205
    vendor: FUJITSU SIEMENS
    version: Rev 1
    serial: YK2H004201
    width: 32 bits
    capabilities: smbios-2.4 dmi-2.4 smp-1.4 smp
    configuration: boot=oem-specific chassis=notebook cpus=2
uuid=00CAAE3D-9113-0E10-AFC7-E4C0949DBF47


alsa-info.sh:

http://pastebin.ca/1050962

I have of course played with all the settings with alsamixer before
compiling a kernelmodule. As per the comment to the patch the sound
can become very distorted without it. 6 dB works fine for me.

For me it is a little strange that it is the PCM volume and not the
Master volume that can be boosted. PCM sounds like it would be a
internal digital amplification control, Master sounds more like an
analog output amplifier control. But thats just me and I don't know
the chip at all.


regards,

Andreas

2008/6/19 Takashi Iwai <tiwai@suse.de>:
> At Wed, 18 Jun 2008 21:58:40 +0200,
> =?ISO-8859-1?Q?Andreas_P=E5hlsson?= wrote:
>>
>> Hello.
>>
>> I've had a problem with low volume on my laptop and while scratching
>> this itch I found the patch titled "hda-codec - Avoid overload of PCM
>> volume on Cx5045 codec" I reverted this patch and of course got a lot
>> more volume. The description states: "The PCM volume of Cx5045 codec
>> has overload that isn't useful but rather harmful.  Add a hack to
>> override the amp info to set the max level 0 dB.". Does anybody know
>> where to find more information on a better default value for the max
>> level setting?
>
> Then maybe this workaround is specific to HP laptops.
> Could you give the alsa-info.sh output, and a more detailed
> information of your laptop (vendor, model)?  Before working on the
> source code, one should check the mixer setting at first.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
