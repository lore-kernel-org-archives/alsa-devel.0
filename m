From: Kailang <kailang@realtek.com>
Subject: Re: hp_pin was NULL value
Date: Wed, 30 Jan 2019 06:26:11 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DB7508@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18420E8B@RTITMBSV02.realtek.com.tw>
 <s5htviigoa5.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18420EBD@RTITMBSV02.realtek.com.tw>
 <s5hlg3ux9x9.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210B1@RTITMBSV02.realtek.com.tw>
 <s5hh8eah1fj.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210E5@RTITMBSV02.realtek.com.tw>
 <s5h5zuqgxv2.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A184210FC@RTITMBSV02.realtek.com.tw>
 <s5h1s5eguwz.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A1842112F@RTITMBSV02.realtek.com.tw>
 <s5hwon6ffg9.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18DB7442@RTITMBSVM07.realtek.com.tw>
 <s5hlg33g95b.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A18DB7463@RTITMBSVM07.realtek.com.tw>
 <s5hpnsffviy.wl-tiwai@suse.de> <s5hva27eaqp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 04A5D2674B9
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 07:26:18 +0100 (CET)
In-Reply-To: <s5hva27eaqp.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Many Thanks. ^^

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Tuesday, January 29, 2019 11:37 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: hp_pin was NULL value

On Tue, 29 Jan 2019 14:22:45 +0100,
Takashi Iwai wrote:
> 
> On Tue, 29 Jan 2019 09:39:56 +0100,
> Kailang wrote:
> > 
> > Hi Takashi,
> > 
> > So I think put it under alc269 parser. Maybe it is the quickly method.
> > 
> > 	err = alc269_parse_auto_config(codec);
> > 	if (err < 0)
> > 		goto error;
> > +   .....
> > +   .....
> 
> Not really...  The init sequence needs to be applied in two different
> places: once in the init callback, and another in the resume callback 
> but only for the hibernation restore.
> 
> The patches below are applied on top of yours, and this should make 
> things working.
> 
> The first one lets the HD-audio core recording the currently processed 
> PM event, and the second one evaluates it and applies the missing init 
> sequence also for the hibernation resume.
> 
> This isn't quite sexy, but it has the minimal change in the codec 
> driver side.  If this requirement is more common, we can think of 
> splitting / reorganizing the codec callbacks to be more directly 
> called from the device pm ops.

I did quick tests and the test result looks positive, at least, about the PM power_state change tracking.  So I'm going to push your fix to for-linus for 5.0, while other two to for-next, for 5.1, as the S4 resume issue isn't any urgent bug and it's no regression, either.


thanks,

Takashi

------Please consider the environment before printing this e-mail.
