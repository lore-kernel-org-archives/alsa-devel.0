From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: about the alsa i2c interface
Date: Thu, 09 Jun 2005 02:47:56 -0400
Message-ID: <1118299677.14638.1.camel@mindpipe>
References: <9AEDBAA573BBD346BCF9637D80097D9119E60A@greysvr02.GreyInnovation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7C89B1F4
	for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2005 08:54:21 +0200 (MEST)
In-Reply-To: <9AEDBAA573BBD346BCF9637D80097D9119E60A@greysvr02.GreyInnovation.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tehn-Yit Chin <Tehn-Yit.Chin@greyinnovation.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-06-09 at 13:09 +1000, Tehn-Yit Chin wrote:
> Hi,
> 
> We are trying to provide support for the CS43L43 device under the ALSA
> architecture on an embedded platform.
> 
> During my early investigation, I noticed that ALSA has its own i2c code.
> What is this required, and why doesn't it use the mainline i2c support?
> On our platform, there are one other devices on the i2c bus, so I would
> like to use the mainline i2c code.

This is explained in "Writing an ALSA Driver"  (you did read it,
right?).  Basically the kernel's i2c layer is overly complex, and ALSA
only needs a small subset of it, so ALSA implements its own minimal i2c
layer.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
