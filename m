From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: Re: Maya44 revised patch - vu meters
Date: Thu, 14 Feb 2008 09:25:58 +0100
Message-ID: <47B3FB16.6090906@insite.cz>
References: <47B37EE7.5000905@lightshed.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (cable.insite.cz [84.242.84.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AFE72443C
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 09:26:09 +0100 (CET)
In-Reply-To: <47B37EE7.5000905@lightshed.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rainer Zimmermann <mail@lightshed.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The vu-meters in alsamixer are not changing, because alsamixer does not 
  refresh regularly their values. They reflect status of ice1724 
vu-meters at the moment of alsamixer start.

I have already raised the issue and I got a fair answer - alsamixer is a 
console mixer and should thus consume as little network bandwidth as 
possible.

Since the meaning of these read-only controls is clear only upon 
detailed study of the driver and Envy24 datasheet plus I encounter a lot 
of questins/complaints about them, I suggest to change their type from 
MIXER to PCM. They would still be readily accessible from amixer or API.

Here is my little vu-meter script I use for testing ice1724 cards:

while true; do amixer cget name="Multi Track Peak" | grep ": values";
sleep 0.5; done

Thanks for considering this minor change which would simplify life of a 
lot of users/admins.

Regards,

Pavel Hofman.


Rainer Zimmermann wrote:
> 
> This is the revised version of the ESI Maya44 patch.
> changes are mainly coding style, some cleanups and using a patch file 
> for ice1724.c .
> 
> The added code now (mostly) passes checkpatch.pl, except for some "#if 
> 0"'s which I'd leave in for the development phase.
> 
> Also, I changed the rate setting logic, which (for now) allows all rates 
> up to 192kHz even for capturing. As capturing actually only supports 96 
> kHz, while capturing & playback rates are linked, this is not really ok. 
> I'd appreciate suggestions about how this could be handled properly, 
> while still supporting playback up to 192 kHz...
> 
> 
> Again, feedback & testing is appreciated.
> 
> For more information, see doc/README.maya44 .
> 
> 
> -Rainer
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
-----------------

inSITE, s.r.o.

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
