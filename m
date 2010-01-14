From: =?ISO-8859-1?Q?Christian_St=F6veken?= <christian.stoeveken@gmail.com>
Subject: Re: VGN-P11Z_G (hda-intel ALC262) internal microphone
	not working
Date: Fri, 15 Jan 2010 00:30:41 +0100
Message-ID: <7c16f72a1001141530o1cef56cdnea04e44a6f5fd4a3@mail.gmail.com>
References: <7c16f72a1001071534sd8992e9je69bab0271b491b5@mail.gmail.com>
	<604760771001091658t1a86c7f0mb07a6c8b8a36c21f@mail.gmail.com>
	<7c16f72a1001091700m20e0dfc0g704f6b936b39b6d1@mail.gmail.com>
	<604760771001091701m50ebd1f4g92e5633ec4885789@mail.gmail.com>
	<7c16f72a1001091711r73ab04ddr153aef192648ee81@mail.gmail.com>
	<7c16f72a1001130928m4178b21by70f2575470c3e65e@mail.gmail.com>
	<604760771001131641l2689a032xdf76509bd716b9d8@mail.gmail.com>
	<s5hzl4h5gbj.wl%tiwai@suse.de>
	<604760771001140403l3688ba5cgabce1e2db7d2ab6@mail.gmail.com>
	<s5hska8kc43.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 7689F10380A
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 00:30:42 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e12so2659fga.2
	for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2010 15:30:42 -0800 (PST)
In-Reply-To: <s5hska8kc43.wl%tiwai@suse.de>
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
Cc: Daniel Chen <seven.steps@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Sorry, I din't know I should test without model=auto.

http://www.alsa-project.org/db/?f=87e1ba4b02f13689fb0d32a03b45fd79ebf57ef0
that's with "options snd-hda-intel power_save=10 power_save_controller=N"
on 2.6.33-020633rc4-generic ... no microphone
also no mic with "options snd-hda-intel power_save=10
power_save_controller=N model=auto" on that kernel
http://www.alsa-project.org/db/?f=388a56455f5bd65da53f24b5f09f240082417d16

on 2.6.31-18
with "options snd-hda-intel power_save=10 power_save_controller=N
model=auto"
http://www.alsa-project.org/db/?f=d346b2e78e86a1d05314c053a3b3068d9cf9b1d3
*the microphone is working*
also without model=auto
*it isn't*
http://www.alsa-project.org/db/?f=094606e931c0e6e684a36e8c83145c45efa82719



Driver version:     1.0.21

Library version:    1.0.22

Utilities version:  1.0.22

used the the script from here:
http://ubuntuforums.org/showthread.php?p=6589810
to update.


Regards,
Christian

 On Thu, Jan 14, 2010 at 3:14 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 14 Jan 2010 07:03:20 -0500,
> Daniel Chen wrote:
> >
> > On Thu, Jan 14, 2010 at 1:52 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > > Isn't this with the older driver version before disabling the default
> > > quirk to sony-assamd model?  In the recent version, it would fall
> > > back to auto model.
> >
> > Indeed, both of his alsa-info.sh outputs show that he used model=auto
> > with -driver 1.0.20:
> > >> working "model=auto":
> > >>
> http://www.alsa-project.org/db/?f=67f6a692f0ccd70d6893665d36c8b90a51f4a577
> > >>
> > >> also with "power_save=10 power_save_controller=N model=auto":
> > >>
> http://www.alsa-project.org/db/?f=618f4d4ae530957b4b6d2b66751871d4073df685
> >
> > > Having an entry to ALC262_AUTO is fine.  It even reduces a kernel
> > > message that may wonder user.  So here what we have to check lastly
> > > is whether VAIO Z21MN (104d:9025) that is currently with toshiba-s06
> > > works with model=auto or not.  Once after it's confirmed, we can take
> > > all to auto.
> >
> > Because I don't have access to 0x104d9025 and I don't wish to
> > introduce a further regression for that model, I've just respun the
> > patch against current master HEAD adding his SSID with the model=auto
> > quirk.
>
> Well, I guess the latest driver should work even without quirk because
> model=auto would be chosen as default.  In the older verison,
> model=sony-assamd was chosen for Sony laptops, but it's disabled now.
>
> If my guess is right, I'd apply a clean-up patch for 2.6.34, but no
> need for a new addition of model=auto quirk entry for 2.6.33.
> If not, please let me know.
>
>
> thanks,
>
> Takashi
>
