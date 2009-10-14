From: Luke Yelavich <themuso@ubuntu.com>
Subject: Re: SPDIF with X-Fi
Date: Wed, 14 Oct 2009 11:34:21 +1100
Message-ID: <20091014003421.GA3743@strigy.yelavich.home>
References: <4AD51A4C.3070005@amfes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F1571038BD
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 02:34:28 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Mxrox-0002yc-Bw
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2009 01:34:27 +0100
Received: from ppp121-44-120-20.lns20.syd6.internode.on.net ([121.44.120.20]
	helo=localhost) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.69)
	(envelope-from <themuso@ubuntu.com>) id 1Mxrow-00044U-JD
	for alsa-devel@alsa-project.org; Wed, 14 Oct 2009 01:34:27 +0100
Content-Disposition: inline
In-Reply-To: <4AD51A4C.3070005@amfes.com>
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

On Wed, Oct 14, 2009 at 11:24:44AM EST, Daniel L. Miller wrote:
> Perhaps I'm going about this the wrong way (if so, please tell me), but...
> 
> My X-Fi card is now working with the new driver.  I am connected to my 
> amplifier via a fiber optic cable.  Sending standard two-channel audio 
> to the "front" alsa plug gets directed to the spdif output and sounds 
> great.  But I want to have my full surround active - particularly for 
> movies already encoded with dts and/or ac-3.
> 
> Do I need to specially configure ALSA is any fashion to make this work?  Do I need to use the iecset tool?

You need to configure the application playing audio to use AC3 passthrough, which will simply send AC3 directly from your app via optical to your amplifier.

Luke
