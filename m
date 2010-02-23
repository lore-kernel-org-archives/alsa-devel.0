From: Jerone Young <jerone.young@canonical.com>
Subject: Re: Conexant CX20561 alsa driver not muting headphone
 jack on Thinkpads when mute button pressed .. any ideas?
Date: Tue, 23 Feb 2010 03:44:31 -0600
Message-ID: <1266918271.32128.12.camel@laptop>
References: <1266882934.2831.40.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id CBB181038AC
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 10:44:34 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NjrJi-00081L-5k
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 09:44:34 +0000
Received: from adsl-71-145-133-119.dsl.austtx.sbcglobal.net ([71.145.133.119]
	helo=[192.168.1.6]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <jerone.young@canonical.com>) id 1NjrJh-0007cZ-QF
	for alsa-devel@alsa-project.org; Tue, 23 Feb 2010 09:44:34 +0000
In-Reply-To: <1266882934.2831.40.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

So I believe I know the answer (or almost) to the problem. The problem
is the speaker & headphones DACs are not being mixed on the same mixer.

The problem is to figure out which mixer does this I need the spec for
the codec.

Does anyone know I can get a hold of data sheet for the Conexant CX20561
or CXT5051 ?


				Thanks,
					Jerone

On Mon, 2010-02-22 at 17:55 -0600, Jerone Young wrote:
> There is an interesting problem with Lenovo Thinkpads X200, X200s, X301,
> & .. looks like W500  using the Conexant CX20561 codec under Linux with
> alsa.
> 
> But if you have your headphone plugged in. You get audio .. but if you
> press the hardware mute button .. it will not mute the headphones. By
> pulling out the headphones you will notice though that the internal
> speakers are muted.
> 
> At first I blamed the bios. But then I did a test under FreeDOS where I
> used the beep command for sound. Sure enough I press the mute button and
> the headphone jack is muted.
> 
> I've been looking for any documentation I can find on the CX20561 but
> there is non out there I can find. I could be wrong, but it seems some
> bit isn't being flipped for this codec to work correctly with this
> functionality with the alsa driver.
> 
> 
> Any ideas?
> 
> I've created a bug here:
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4928
> 
> 			Thanks,
> 				Jerone
> 
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
