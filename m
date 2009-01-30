From: "Tellman, Steven" <Steven.Tellman@idt.com>
Subject: Re: intel DP35DP adat supported (STAC927x codec) ?
Date: Fri, 30 Jan 2009 14:41:08 -0800
Message-ID: <16A430A423D62246A24C9A892622FE668D5227@CORPEXCH1.na.ads.idt.com>
References: <4969FBA0.1030008@ponctey.fr>
	<s5hvdskdah9.wl%tiwai@suse.de><496B3BB7.1020203@ponctey.fr>
	<496E7FE7.8020706@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout2.mainstreet.net (mxout2.mainstreet.net [204.69.220.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 605B12441E
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 23:41:27 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <496E7FE7.8020706@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It doesn't work. The option comes up, but no dice. Doesn't lock to the
receiver that has ADAT support.

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Matthew
Ranostay
Sent: Wednesday, January 14, 2009 6:15 PM
To: Eric
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] intel DP35DP adat supported (STAC927x codec) ?

Hello Eric,

You should run the latest ALSA from the git tree because I added a codec
specific SPDIF output control control for that chipset.

....
 417 static const char *stac927x_spdif_labels[5] = {
 418     "Digital Playback", "ADAT", "Analog Mux 1",
 419     "Analog Mux 2", "Analog Mux 3"
 420 };
....

I haven't tested ADAT output though but I have no reason to
think it wouldn't work.

Thanks,

Matt Ranostay


Eric wrote:
> In their handbook, motherboard intel DP35DP and others with STAC927x
(in
> the codec datasheet also ADAT output is featured on older sigmatel
> STAC9271 and now IDT STAC9274 only) advertise ADAT output possible on
> their toslink.
> DP35DP and other intel boards are proven to have the ADAT output
working
> under windows.
> Is it working in Alsa ? Many HTPC users would love that... I would !
> 
> Anybody from intel or IDT/sigmatel to confirm (by checking the
sigmatel
> STAC927x hda codec driver) that it will work ?
> I want these intel motherboards only for this ADAT output feature and
I
> am a linux only user so I would like to know before buying...
> I want to be sure someone would make the necessary changes to the hda
> sigmatel codec alsa driver so it would work.
> Thank you everybody
> 
> 
>>> Is the ADAT output of the IDT (sigmatel) STAC927x HDA codec
supported in
>>> alsa ?
>>> If not could someone please try to add this incredibly nice feature
in
>>> the existing alsa driver ?
> 
> 
>> Do you have any HD-audio device with ADAT?
>> IIRC, there is no specific verbs for ADAT on STAC927x...
>> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
