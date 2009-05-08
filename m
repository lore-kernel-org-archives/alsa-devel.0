From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Master vs. Front/Rear/LFE/... elements
Date: Fri, 08 May 2009 18:36:02 +1200
Message-ID: <4A03D2D2.1040800@audioscience.com>
References: <20090506175824.GA30355@tango.0pointer.de>
	<s5hbpq5s3fx.wl%tiwai@suse.de> <20090507100915.GB27897@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id B893F248A1
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 08:36:05 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KJB002BUBO25730@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 08 May 2009 18:36:03 +1200 (NZST)
In-reply-to: <20090507100915.GB27897@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, May 07, 2009 at 10:49:22AM +0200, Takashi Iwai wrote:
> 
>> IMO, the best would be a total rewrite of the current mixer API, as I
>> mentioned some times.  Right now it's more complicated than needed,
>> but not powerful enough to handle exceptional cases.
> 
> Indeed - for example, something that allowed audio routing to be
> expressed in the mixing API would be a very big win for embedded systems
> too.
> 
>> I know designing a generic and fully-working API is pretty difficult,
>> though...
> 
> Certainly non-trivial :)

I just dumped my notes here on other systems that have some concept of
routing/connectivity/topology

http://bigblen.wordpress.com/2009/05/08/linux-audio-control-topology/

Comments welcome

Still very much a work in progress...

--
Eliot
