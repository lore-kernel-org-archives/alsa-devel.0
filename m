From: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Subject: Re: [alsa-devel] Bugs on aspire one A150
Date: Tue, 17 Mar 2009 11:47:55 +0100
Message-ID: <20090317104755.GA1446@rhlx01.hs-esslingen.de>
References: <20090316170015.GA9776@rhlx01.hs-esslingen.de> <s5hljr5pex0.wl%tiwai@suse.de> <20090316173000.GA25647@rhlx01.hs-esslingen.de> <s5hiqm9pe1g.wl%tiwai@suse.de> <20090316180638.GB25647@rhlx01.hs-esslingen.de> <s5htz5tyzyg.wl%tiwai@suse.de> <20090316212227.GA29471@rhlx01.hs-esslingen.de> <s5hfxhczinh.wl%tiwai@suse.de> <20090317100500.GA16029@rhlx01.hs-esslingen.de> <20090317103845.GA26007@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090317103845.GA26007-p/qQFhXj4MHA4IYVXhSI5GHfThorsUsI@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Mohr <andi-5+Cda9B46AM@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 17, 2009 at 11:38:45AM +0100, Andreas Mohr wrote:
> NOPE. Aspire One most definitely has a Fortemedia SAM (small array
> microphone) due to this output:
> http://sites.google.com/site/kengell/acer-aspire-one---dmesg
> 
> "
> ...
> ForteMedia SAM-Soft Library Loaded!
> 
> ALC INIT
> ...
> "
> 
> I had already wanted to add the mention of Fortemedia as microphone
> manufacturer (forgot this last time), then I researched more and found it.
> 
> Fortemedia device names include FM2018-380, not sure yet which one is in
> Aspire One.
> 
> http://www.fortemedia.com/products/index.htm
> ( especially http://www.fortemedia.com/products/fm1182.htm )

http://www.wpgholdings.com/event/S/SACg_04_ForteMedia_SAM.pdf
mentions "FM201x" and www.sacg.com.tw (this one could be useful!).
Searching Google "FM201[0-9] Fortemedia" comes up with FM2010 and
FM2018 and thus
http://www.hengdasheng.com.cn/uploadfile/391/cfile/2008102414057847.pdf
which is a relatively informative datasheet.

Andreas
