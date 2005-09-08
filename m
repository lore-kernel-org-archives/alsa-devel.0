From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Brand-new notebook useless with Linux...
Date: Thu, 08 Sep 2005 15:31:44 -0400
Message-ID: <1126207905.12697.20.camel@mindpipe>
References: <200509081522_MC3-1-A986-1B52@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 7C7EA1C4
	for <alsa-devel@alsa-project.org>; Thu,  8 Sep 2005 21:31:47 +0200 (MEST)
In-Reply-To: <200509081522_MC3-1-A986-1B52@compuserve.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-09-08 at 15:19 -0400, Chuck Ebbert wrote:
> In-Reply-To: <1125805091.14032.69.camel@mindpipe>
> 
> On Sat, 03 Sep 2005 at 23:38:10 -0400, Lee Revell wrote:
> 
> > On Sat, 2005-09-03 at 18:58 -0400, Chuck Ebbert wrote:
> > > I just bought a new notebook.
> > 
> > I'd return it if I were you.
> 
>  What fun is that?  I have learned that HP/Compaq is hostile to Linux,
> for one thing, which was interesting (my system is a Compaq Presario
> V2312US.)
> 
>  Can you help me find out why my codec is unknown?  I gave up trying to
> figure out how to get the codec ID and hacked the source to print it:
> 
> 
> atiixp: codec 0 not available for modem
> atiixp: no codec available
> ALSA device list:
>   #0 ATI IXP rev 2 with 0x43585430 at 0xd0003400, irq 177
> 
> 
> So it's a Conexant codec with ID 0x30 on an atiixp.  OSS has some support
> for this codec, apparently.

Wait, that sounds like the modem, not the AC97 audio codec.

You might be able to get the modem to work with the (proprietary)
slmodem software modem, or something.  I wouldn't count on it though.

Does your sound work?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
