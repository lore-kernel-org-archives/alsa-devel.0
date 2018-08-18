From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Fwd: [PATCH 1/2] ALSA: hda - Turn CX8200 into D3 as well upon reboot
Date: Sun, 19 Aug 2018 01:56:22 +0900
Message-ID: <CAD14+f1Mog5dy93rxdGnjadv0CO2JFwZTsfjRKDekvzmRfjDMQ@mail.gmail.com>
References: <20180727181621.7188-1-qkrwngud825@gmail.com> <s5hlg9vthzx.wl-tiwai@suse.de>
 <CAD14+f30SuF=MJsXWcLg3RFrJOO32wdvDKPnb2mNfnqtGWqhDw@mail.gmail.com>
 <s5hzhy6mdxn.wl-tiwai@suse.de> <CAD14+f1VoGpOUHT6Jn_D_Svsg6MZ6e1X1gDTNoYX9_CbaVQg6w@mail.gmail.com>
 <s5hwotamdo7.wl-tiwai@suse.de> <CAD14+f3qrhVNT0hq77fE7ADhXbzSLm1R5r_mv6rLyuhJHPXs=w@mail.gmail.com>
 <s5hy3d4itgj.wl-tiwai@suse.de> <CAD14+f1Yf-RpaLENsUC73AF9T=a_aOXzP9GaKt2ZVw58WXuBBQ@mail.gmail.com>
 <20180818143800.GA670@kroah.com> <CAD14+f1K=s5bk0SQJ3s4rhg=jGhdpp_MR9XyZ-T7=jmthzot4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAD14+f1K=s5bk0SQJ3s4rhg=jGhdpp_MR9XyZ-T7=jmthzot4Q@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org
List-Id: alsa-devel@alsa-project.org

Hi,

It's commit d77a4b4a5b0b2ebcbc9840995d91311ef28302ab
and f59cf9a0551dd954ad8b752461cf19d9789f4b1d,
both which are already merged in Linus's tree.

I can't think of a reason why you would have missed this
other than the fact that I've used "Cc: <stable@vger.kernel.org>"
instead of "Cc: stable@vger.kernel.org".

I doubt it, but would this be the reason?

Thanks,
On Sat, Aug 18, 2018 at 11:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 18, 2018 at 11:29:11PM +0900, Ju Hyung Park wrote:
> > Hi, Greg.
> >
> > I'd like to know if there's a reason on why these ALSA patches(2 in
> > total) aren't brought to linux-stable yet.
>
> What specific patches are you referring to here?  I do not see anything
> in this email :(
>
> What is the git commit id in Linus's tree?  What stable tree(s) do you
> want them applied to?
>
> > I see a lot of patches merged to linux-stable and stable-queue that
> > are much newer than those patches.
> >
> > I'd appreciate it if you can merge those ASAP.
>
> Have you read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly?
>
> If not, please do so.
>
> thanks,
>
> greg k-h
