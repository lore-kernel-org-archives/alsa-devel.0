From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: M-audio Delta Audiophile 192 drivers
Date: Thu, 13 Dec 2007 11:31:03 +0100
Message-ID: <476109E7.2030309@insite.cz>
References: <475FFD18.3040103@gmail.com>
	<1197500848.4985.118.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from prague.insite.cz (r3g29.net.upc.cz [213.220.198.29])
	by alsa0.perex.cz (Postfix) with ESMTP id E4CD324651
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 11:31:10 +0100 (CET)
In-Reply-To: <1197500848.4985.118.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manel Clos <manelclos@gmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Rosegarden tries to open default midi device upon startup. The ice1724 
code has some kind of infinite loop in IRQ handler problem, experimental 
untested patch by Takashi is

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000641.html

I solved the same problem on Prodigy192 by disabling MPU401 in the 
driver, see the code prodigy192.c in the latest HG devel version 
(something like no_MPU401 = 1 - sorry I have no access to hg now). I 
guess it is a standard way of configuration, should be straightforward 
in your specific card file as well.

BTW, the same lockup occurs whenever the midi device is opened by any 
application, e.g. amidi.

The proper way would be to test Takashi's patch (still merges cleanly) 
and fix mpu401 code. Unfortunately, I do not have a midi cable to 
connect my midi keyboard via MIDI to check (using USB now).

Regards,

Pavel.


Tobin Davis napsal(a):
> I'd start with downloading, building, and installing the 1.0.15 driver
> tree.  If you want to keep it in a deb package, you can apt-get install
> alsa-source, then copy the alsa-driver-1.0.15 stuff over the top of the
> alsa-source from ubuntu and rebuild the package.
> 
> Tobin
> 
> On Wed, 2007-12-12 at 16:24 +0100, Manel Clos wrote: 
> 
>> Hi all!
>>
>> We purchased a M-audio Delta Audiophile 192, which uses the ICE1724
>> chipset. Using Ubuntu gutsy 7.10 and alsa 1.0.14. PCM is working, but as
>> soon as we start Rosegarden the complete system hangs (SysRq doesn't
>> even work). Also, the input of the card is not shown in gnome-mixer.
>>
>> Is there anything we can do to help the development of the driver? We
>> are able to compile kernel + patches, do C programming, test PCM, Midi...
>>
>> Thanks in advance!
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> -- Tobin Davis 
> 
> 
> What is now proved was once only imagin'd.
> 		-- William Blake
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-----------------

inSITE, s.r.o.

Kafkova 16, 160 00 Praha 6
Rubesova 29, 326 00 Plzen

Tel., fax: +420 - 37 - 74 493 58
GSM: +420 - 603 - 163 973
Email: pavel.hofman@insite.cz

www.educity.cz, www.insite.cz
www.meetings.cz, www.hrzive.cz
www.comben.cz, www.hr-online.cz
-------------------------------
Navstivte www.educity.cz, server
s nejvetsi nabidkou profesniho
vzdelavani na ceskem internetu.
