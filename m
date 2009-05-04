From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 4 May 2009 08:58:04 -0400
Message-ID: <9e4733910905040558i7f8d9450h8f10ce96f9cf8868@mail.gmail.com>
References: <9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<alpine.LNX.2.00.0904281022210.25064@eeebox2.perex-int.cz>
	<s5hiqkp16w6.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904281131440.25064@eeebox2.perex-int.cz>
	<s5h7i1514bn.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904281206260.25064@eeebox2.perex-int.cz>
	<s5h3abt132e.wl%tiwai@suse.de> <s5hvdoh8gvp.wl%tiwai@suse.de>
	<9e4733910905040529s3376153fj3191295b06e7c7c9@mail.gmail.com>
	<s5hy6tddomr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id CD575243C0
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 14:58:05 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so2661288qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 04 May 2009 05:58:04 -0700 (PDT)
In-Reply-To: <s5hy6tddomr.wl%tiwai@suse.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 4, 2009 at 8:43 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 4 May 2009 08:29:14 -0400,
> Jon Smirl wrote:
>>
>> On Mon, May 4, 2009 at 3:30 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Tue, 28 Apr 2009 12:32:25 +0200,
>> > I wrote:
>> >>
>> >> I already did some work for 2.6.30 fix. =A0It's found in sound git tr=
ee
>> >> fix/pcm-jiffies-check branch. =A0You can pull from
>> >> =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.=
git fix/pcm-jiffies-check
>> >>
>> >> This is still a test branch so it isn't merged yet. =A0It'd be helpful
>> >> if someone can test it, or let me know this change is unacceptable.
>> >
>> > Jon, any chance that you try the changes above?
>> > It should fix mpc5200 issue on 2.6.30.
>>
>> The fix is good. I can take out my jiffies estimation code and no area
>> are generated.
>
> Great. =A0So can we remove BROKEN kconfig again?

Sure. There are only two current users of the driver and we know what
is going on.

I have a large rewrite of the driver for 2.6.31 but it still has bugs
that I am having a hard time locating.

-- =

Jon Smirl
jonsmirl@gmail.com
