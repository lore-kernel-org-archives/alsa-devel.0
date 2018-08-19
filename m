From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Fwd: [PATCH 1/2] ALSA: hda - Turn CX8200 into D3 as well upon
 reboot
Date: Sun, 19 Aug 2018 08:09:52 +0200
Message-ID: <20180819060952.GC2895@kroah.com>
References: <CAD14+f30SuF=MJsXWcLg3RFrJOO32wdvDKPnb2mNfnqtGWqhDw@mail.gmail.com>
 <s5hzhy6mdxn.wl-tiwai@suse.de>
 <CAD14+f1VoGpOUHT6Jn_D_Svsg6MZ6e1X1gDTNoYX9_CbaVQg6w@mail.gmail.com>
 <s5hwotamdo7.wl-tiwai@suse.de>
 <CAD14+f3qrhVNT0hq77fE7ADhXbzSLm1R5r_mv6rLyuhJHPXs=w@mail.gmail.com>
 <s5hy3d4itgj.wl-tiwai@suse.de>
 <CAD14+f1Yf-RpaLENsUC73AF9T=a_aOXzP9GaKt2ZVw58WXuBBQ@mail.gmail.com>
 <20180818143800.GA670@kroah.com>
 <CAD14+f1K=s5bk0SQJ3s4rhg=jGhdpp_MR9XyZ-T7=jmthzot4Q@mail.gmail.com>
 <CAD14+f1Mog5dy93rxdGnjadv0CO2JFwZTsfjRKDekvzmRfjDMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD14+f1Mog5dy93rxdGnjadv0CO2JFwZTsfjRKDekvzmRfjDMQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: stable@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 19, 2018 at 01:56:22AM +0900, Ju Hyung Park wrote:
> Hi,
> 
> It's commit d77a4b4a5b0b2ebcbc9840995d91311ef28302ab
> and f59cf9a0551dd954ad8b752461cf19d9789f4b1d,
> both which are already merged in Linus's tree.
> 
> I can't think of a reason why you would have missed this
> other than the fact that I've used "Cc: <stable@vger.kernel.org>"
> instead of "Cc: stable@vger.kernel.org".

No, I have not missed these.  I normally wait until a patch shows up in
a release from Linus before adding them to the stable tree, and as these
patches just hit Linus's tree a few days ago, that has not happened yet.
It also is in the middle of over 200 other stable patches that have been
asked to be merged, so you are in good company, and it will take me a
while to get through them all.

I will go add these to the top of the pile, as you have asked about
them, which is fine to do.

thanks,

greg k-h
