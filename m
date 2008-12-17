From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Trying to figure out what went wrong with my HDMI.
Date: Wed, 17 Dec 2008 09:03:35 +0100
Message-ID: <4948B257.9080606@ladisch.de>
References: <e5df86c90812150742l71fcdccdp6c8b4ce51a02155d@mail.gmail.com>	
	<4947ABFE.5080603@ladisch.de>
	<e5df86c90812160653v1e3ed11fl1c485a4634e106c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id D36BF1037EB
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 09:03:38 +0100 (CET)
In-Reply-To: <e5df86c90812160653v1e3ed11fl1c485a4634e106c1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Jenks <mjenks1968@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Jenks wrote:
> On Tue, Dec 16, 2008 at 7:24 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Use "plughw:0,3" instead of "hw:0,3".
>
> What is the difference?

Plughw automatically converts to a sample format that the device
supports.

> And why did hw:0,3 work before?

Probably your old hardware did support mono playback.

> If I want to use it in Myth, would it be ALSA:plughw:0,3 then?

Yes.  (It is possible that Myth can do resampling and channel rerouting
by itself; in this case, hw would also work.)


HTH
Clemens
