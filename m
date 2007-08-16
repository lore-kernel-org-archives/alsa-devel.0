From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Voip Application with ALSA OSS Emulation ==> voice
 delay
Date: Thu, 16 Aug 2007 08:47:36 +0200
Message-ID: <1187246856.13434.1205658833@webmail.messagingengine.com>
References: <loom.20070815T160926-869@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4C7E6243BD
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 08:47:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20070815T160926-869@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Akio <akioolin@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Akio wrote:
> Right now, we are using a arm box with linux kernel 2.6.14 to
> develop a voip  solution. After the rtp connection was 
> connected at first 20 secs, there is no delay. As the timing passing
> by, the delay will going longer and longer.  After 16 houres, the 
> delay will up to 12 secs.

If the sending and the receiving computers don't use the same clock,
there will be a small difference in the sample rate.  You have to
measure this and adjust the data accordingly (by resampling or just
adding/dropping some samples).

> Because the alsa lib application can't detect any alsa device,

I'd guess that either the device nodes in /dev/snd/ or the configuration
files in /use/share/alsa/ are missing.


HTH
Clemens
