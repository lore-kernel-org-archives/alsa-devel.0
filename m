From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS vs ALSA war :-)
Date: Tue, 10 Aug 2004 14:29:22 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1092162561.782.39.camel@mindpipe>
References: <200408100636.i7A6aMAo030159@www4.pobox.sk>
	 <411875DF.7030203@free.fr> <20040810151525.GC1671@fliwatut.scifi>
	 <4118ED57.50302@free.fr> <1092155904.861.3.camel@mindpipe>
	 <411900D4.7090806@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 49887213
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2004 20:29:05 +0200 (MEST)
In-Reply-To: <411900D4.7090806@free.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: geeceezee@free.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-08-10 at 13:07, GCZ wrote:
> Lee Revell wrote:
> 
> > No, this is why ALSA provides OSS emulation, so every legacy app doesn't
> > have to be recoded.  For gaming you should use the closed-source Nvidia
> > drivers and ALSA's OSS emulation.  I don't think anyone can make a
> 
> Which doesn't work on my setup. I posted a message on alsa-user I think, 
> and I don't remember exactly what error message I got, but I think it 
> had something to do with mmap. Nobody replied to my message. At one 
> point, going through so many documents, ML posts, Q&A's, trial and error 
> steps just to make it work isn't worth it, if no improvement comes out 
> of it. If Takashi is indeed interested in my feedback, at least it will 
> be productive.
> 

OK, I will check the archives.  The ALSA guys are very busy, you might
have to make a little noise or even be a bit inflammatory to get your
bug addressed.  For example, track down the general area of the bug
using some printk's, then post a completely botched fix to the mailing
list.  Preferably something that compiles and looks like it's working. 
This will often get you a hint as to what the real problem is, then
maybe someone less skilled can fix it. ;-)  I have fixed a few bugs in
the driver for my soundcard, Jaroslav and Takashi will help you, and
tell you if you are completely off base.  I encourage you to ask your
favorite distro vendor to hire some ALSA developers, because all but two
or three are working for free.

> I'm glad to read that. Let's not get into zealotry.
> 

Sorry, should have left that off...

Lee




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
