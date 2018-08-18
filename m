From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Fwd: [PATCH 1/2] ALSA: hda - Turn CX8200 into D3 as well upon reboot
Date: Sun, 19 Aug 2018 01:56:32 +0900
Message-ID: <CAD14+f3hsqPK9ULNUcGXz3D+X_vFovKgikKZLgakqanPHY+Dcw@mail.gmail.com>
References: <20180727181621.7188-1-qkrwngud825@gmail.com> <s5hlg9vthzx.wl-tiwai@suse.de>
 <CAD14+f30SuF=MJsXWcLg3RFrJOO32wdvDKPnb2mNfnqtGWqhDw@mail.gmail.com>
 <s5hzhy6mdxn.wl-tiwai@suse.de> <CAD14+f1VoGpOUHT6Jn_D_Svsg6MZ6e1X1gDTNoYX9_CbaVQg6w@mail.gmail.com>
 <s5hwotamdo7.wl-tiwai@suse.de> <CAD14+f3qrhVNT0hq77fE7ADhXbzSLm1R5r_mv6rLyuhJHPXs=w@mail.gmail.com>
 <s5hy3d4itgj.wl-tiwai@suse.de> <CAD14+f1Yf-RpaLENsUC73AF9T=a_aOXzP9GaKt2ZVw58WXuBBQ@mail.gmail.com>
 <20180818143800.GA670@kroah.com> <CAD14+f0QASSwkTuMEKrEAg217HM--HdcrPF7UDHF6RuPoAo89g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAD14+f0QASSwkTuMEKrEAg217HM--HdcrPF7UDHF6RuPoAo89g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org
List-Id: alsa-devel@alsa-project.org

Oh, and I forgot to add:
this would better be applied to every stable trees, if applicable
(probably by checking if the commit
f6b28e4ded45bb91bc4cd115d55e35badedfce5f is already merged).

Thanks again.
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
