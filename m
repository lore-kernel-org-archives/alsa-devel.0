From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Tue, 09 Apr 2013 16:21:36 +0200
Message-ID: <516423F0.9020409@ivitera.com>
References: <515EEF10.1020007@gmail.com> <5160C35A.8020403@gmail.com>
 <5161A6D3.3060602@gmail.com> <201304072135.45811.gineera@aspect135.co.uk>
 <51634B17.3050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
 [84.242.75.189])
 by alsa0.perex.cz (Postfix) with ESMTP id A31AD265E22
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 16:21:36 +0200 (CEST)
In-Reply-To: <51634B17.3050907@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 9.4.2013 00:56, Jonas Petersen wrote:
> Am 07.04.2013 22:35, schrieb Alan Horstmann:
>> On Sunday 07 April 2013 18:03, Gabriel M. Beddingfield wrote:
>>> On 04/06/2013 05:52 PM, Jonas Petersen wrote:
>>>> It seems it's related to the ICE1712... I now tried the Audiophile
>>>> 2496.
>>>> Same behaviour! There is no way to clock from external (S/PDIF). The
>>>> 'Multi Track Internal Clock Default' setting will always override the
>>>> external clock rate and mess up the capturing.
>>> Well, it /should/ work -- according to the 1010's manual.  I'll bet it's
>>> some register setting that's missing on the ice1712 -- but I have no
>>> access to the specs/datasheets/schematics on these things.
>>>
>>> I wonder -- did this ever work on Linux?
> 
> Yes! I while ago I was doing stuff with the Delta 66 and things were
> fine. That was back with Ubuntu 10.04 and Alsa 1.0.22 and also 1.0.23.
> I just grabbed an old Ubuntu 10.04 ISO which contains Alsa 1.0.22 and
> live booted it on my machine. Tests show that it's working as expected
> with the 1010LT: It's properly externally clocked.
> 
> 
>> However I do seem to remember some relatively recent changes related
>> to external wordclock on the 1010; maybe it has been broken?
> 
> I found commit b8b1a4cb6842fb33769be1ad636f062d31d588c3 from Jan 17
> 23:20:03 2011. It's a patch on delta.c and it's regarding a clock issue
> (though not exactly wordclock). I reverted that patch and recompiled but
> no success.
> 
> I'm going to continue later on that topic. At least there must have been
> some change that broke it since 1.0.23.

Hi Jonas,

first - did you try with "Multi Track Rate Locking" on and off? This
control is a bit clumsy.

How about
http://git.alsa-project.org/?p=alsa-kmirror.git;a=blobdiff;f=pci/ice1712/ice1712.c;h=fb61943fc4dc9631853d76fa2524cd51880bcd9a;hp=c7cff6f8168a2d0159a0df20ea2c97550dafd6db;hb=b125bc8783367e3eb65312039a29bf2f25e931db;hpb=3e3911eb86fc7016c9cfef0525b9568c3106c4e4
?

It is from about that time.

pro_rate_locked is both when locked explicitly as well as when switched
to spdif clock

http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=pci/ice1712/ice1712.c;h=5be2e120a14e25a03744b873e690f765eecb9545;hb=ec10d549379e10b38fe365fbf6bc13bf44f965ac#l133



Please check ice1712 register values, specifically MT RATE to make sure
ice1712 is switched to internal clocks when it should be clocked
externally instead (
http://ftp.sunet.se/pub/Linux/alsa/manuals/icensemble/envy24.pdf ). Or
just dump  ice1712 in proc here, I will check with the datasheet.

Unfortunately there is no /proc register dump coded for cs8427 yet. If
you want to investigate further, you can add it to i2c/cs8427.c in a
manner similar to e.g.
http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4114.c;h=fdf3c1b65e388414c995a597ef2b351b4ec2a220;hb=HEAD#l451

Thanks,

Pavel.
