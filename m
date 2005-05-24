From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: simple alsa adapter template
Date: Tue, 24 May 2005 18:10:56 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505241758240.29815-100000@studcom.urz.uni-halle.de>
References: <4292DC3C.2080404@avantwave.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.Uni-Halle.DE [141.48.3.51])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B8FF81FB
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 18:11:01 +0200 (MEST)
In-Reply-To: <4292DC3C.2080404@avantwave.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tomko <tomko@avantwave.com>, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tomko wrote:
> I am now trying to write a adapter driver for DAC3560 called by the ALSA
> subsystem, can anyone tell me where i can find a template for it ?

There is a document that describes how to write an ALSA driver, with
some PCI-specific parts:
<http://www.alsa-project.org/documentation.php#Driver>

(Takashi, the HTML is somewhat out of date.)


The details of your driver depend on whatever I2S/I2C controller you
have connected to the DAC3560C.  If it is some embedded CPU, it might
be more or less similar to one of the existing ARM drivers:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/arm/


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
