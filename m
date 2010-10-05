From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] Creative Sound Blaster X-Fi Titanium
 PCIe support
Date: Tue, 05 Oct 2010 08:11:47 +0200
Message-ID: <4CAAC1A3.9030500@ladisch.de>
References: <AANLkTik5Xtk1SP72qOgVaAJfvytZE=Nz+ifo7VXcUcuJ@mail.gmail.com>	<4CA5894E.1030907@ladisch.de>
	<m2lj6hx13x.fsf@getmail.no>	<20101001204054.28d16bd4@symphony.aura-online.co.uk>	<m2hbh5wsi8.fsf@getmail.no>
	<4CA976B3.9090009@ladisch.de> <m2mxqtvq4h.fsf@getmail.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A0D43103827
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 08:11:54 +0200 (CEST)
Received: by wwi18 with SMTP id 18so320794wwi.2
	for <alsa-devel@alsa-project.org>; Mon, 04 Oct 2010 23:11:54 -0700 (PDT)
In-Reply-To: <m2mxqtvq4h.fsf@getmail.no>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thor Kristoffersen <thorkr@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thor Kristoffersen wrote:
> I did a bit of searching, and I found that
> if I relax my requirements a bit to include PCI cards, there is another
> card called HT-Omega Claro that would seemingly fit the bill, and it's
> significantly cheaper than the Xonar.  Do you (or anyone else) happen to
> know if this is also fully supported by ALSA?

http://www.alsa-project.org/main/index.php/Matrix:Vendor-HT_Omega

> By the way, does the volume control work on the digital output stream on
> these cards?

No; on most cards (including these ones), the digital output does not
have a volume control because this would reduce the precision of the
samples; the volume is supposed to be controlled by whichever device
does the digital-to-analog conversion.


Regards,
Clemens
