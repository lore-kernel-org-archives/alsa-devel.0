From: Eliot Blennerhassett <eblennerhassett@audioscience.com>
Subject: Re: multiple devices or one device w/ multiple
	subdevices?
Date: Tue, 25 Aug 2009 15:06:00 +1200
Message-ID: <4A935518.4030608@audioscience.com>
References: <6160a5130908241026g574282cuc878346df2ff31ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F62A2441B
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 05:06:27 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MfmMc-0007bQ-Vb
	for alsa-devel@alsa-project.org; Tue, 25 Aug 2009 05:06:26 +0200
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2009 05:06:26 +0200
Received: from eblennerhassett by 121-72-250-62.cable.telstraclear.net with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2009 05:06:26 +0200
In-Reply-To: <6160a5130908241026g574282cuc878346df2ff31ef@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote:
> Hi,
> I have a piece of custom hardware that provides 7 independent PCM
> outputs. 
 >
> My conclusion is that multiple devices would seem like a much better
> option. But I wanted to check with the community that I am on the
> right track. Thanks for your feedback!

It used to be that there was a limit of 4 devices per card.
But no (or large) limit on subdevices.

If this still applies you will need to use subdevices, and for 
simplicity you would create just one device with 7 subdevs.

--
Eliot
