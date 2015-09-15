From: Caleb Crome <caleb@crome.org>
Subject: Re: System with multiple arizona (wm5102) codecs
Date: Tue, 15 Sep 2015 06:56:39 -0700
Message-ID: <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
References: <20150914115439.GA29646@amd> <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd> <20150915080648.GG11200@ck-lbox>
 <20150915083552.GA14780@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f180.google.com (mail-yk0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D1A62612D6
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 15:57:00 +0200 (CEST)
Received: by ykdu9 with SMTP id u9so186657945ykd.2
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2015 06:56:59 -0700 (PDT)
In-Reply-To: <20150915083552.GA14780@amd>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Pavel,
   I'd love to see the patches :-)  I've been trying to figure out the
*right* way to add multiple codecs to a single card (and single CPU
DAI) for some days now.  Any help would be greatly appreciated.

Thanks,
 -Caleb


On Tue, Sep 15, 2015 at 1:35 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > > I must confess I haven't ever tested a system with two Arizona
>> > > CODECs connected. Yes it seems you would get clashes on the
>> > > regulator names, I guess that would need to be fixed up. If you
>> > > were doing so wm831x-ldo.c would probably make a reasonable
>> > > example.
>> > >
>> > > I guess you would need to be careful with the machine driver as
>> > > well, you will need to use a snd_soc_codec_conf structure for at
>> > > least one (although I would do both) of the CODECs to give  a
>> > > prefix for all the widget/control names, otherwise those will
>> > > clash and everything will probably behave very strangely. See
>> > > sound/soc/samsung/bells.c for an example doing this for wm9081.
>> > >
>> > > Those are the only two things that spring to mind at the moment
>> > > but keep me informed on how you are getting on and I will let you
>> > > know if I can come up with any other traps.
>> >
>> > It seems that davinci-evm takes data from device tree, but then uses
>> > statically-allocated evm_soc_card, which would lead to problems in
>> > dual-codec config....?
>>
>> That somewhat depends on how you plan on doing things. I had
>> assumed you would be having a single machine driver with both
>> CODECs connected to it, in which case the statically allocated
>> snd_soc_card wouldn't be a problem. However, if you wanted to
>> have two seperate machine drivers with a single CODEC connected
>> to each then you would have an issue.
>>
>> I guess either approach is reasonable and probably just depends
>> on what your end goal is.
>
> The way dts is set up in my case, I ended up with two
> snd_soc_cards. It seems to work for me now (on old kernel and with
> some rather extreme hacks).
>
> I'll most likely clean it up and get into mainline-ready form, but it
> will take some time. If you want to see the ugly patches, let me know.
>
> Thanks and best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
