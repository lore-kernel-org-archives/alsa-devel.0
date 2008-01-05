From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: fujitsu siemens amilo la 1703 vt1807 hda
	intel	card problem
Date: Fri, 04 Jan 2008 18:56:24 -0800
Message-ID: <1199501784.3732.527.camel@razman.gruemaster.com>
References: <f5976be10801041748j5271c4eas8a6b2d2851b4a838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E8D724492
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 03:56:26 +0100 (CET)
In-Reply-To: <f5976be10801041748j5271c4eas8a6b2d2851b4a838@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Norayr Chilingaryan <gnorayr@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could you download and run
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh

This script will provide a lot of useful information.  After running it,
please reply to this email with the link that the script generates, so
we can retrieve the data, thanks.

Tobin

On Sat, 2008-01-05 at 02:48 +0100, Norayr Chilingaryan wrote:

> Hello
> I decided to write here, firtly, because my messages in aksa-user have been
> ingored, and secondly, because I understood that my card most probably just
> unsupported and I must contact developers.
> 
> I have tried to pass options model=fujitsu, because I have a fujitsu
> siements notebook etc
> I have also tried to pass amny other options in /etc/modules.d/alsa but
> withnot effect
> I use gentoo, and the only thing I noticed with latest kernels and alsa
> drivers 1.0.15 is that I can hear sound through  the headphones, but with
> low volume.
> It is not possible to get volume higher or speaker to make sounds now.
> 
> So, please, this is information about the card
> 
> 04:01.0 Audio device: VIA Technologies, Inc. VIA High Definition Audio
> Controller (rev 10)
> 
> kakraphoon ~ # cat /proc/asound/card0/codec#* | grep Codec
> Codec: VIA VIA VT1708
> Codec: Motorola Si3054
> 
> 
> Thank you very much
> 
> Norayr
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


Hain't we got all the fools in town on our side?  And hain't that a big
enough majority in any town?
		-- Mark Twain, "Huckleberry Finn"
