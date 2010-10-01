From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 01 Oct 2010 19:21:50 +0400
Message-ID: <4CA5FC8E.4020209@aknet.ru>
References: <4CA4B6BF.3080503@aknet.ru>
	<alpine.LNX.2.00.1010011332210.20467@eeebox2.perex-int.cz>
	<4CA5CB0D.9030003@aknet.ru>
	<alpine.LNX.2.00.1010011408410.20467@eeebox2.perex-int.cz>
	<4CA5D359.9040400@aknet.ru>
	<alpine.LNX.2.00.1010011512520.20467@eeebox2.perex-int.cz>
	<4CA5F5D5.4090508@aknet.ru>
	<alpine.LNX.2.00.1010011701180.20467@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E55924461
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 17:21:51 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1010011701180.20467@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  01.10.2010 19:04, Jaroslav Kysela wrote:
> The Dummy and STx7109 devices does not have appropriate configuration 
> files in /usr/share/alsa/cards tree and namehint does not list hw: 
> like devices by default. Use "defaults.namehint.showall=1" in your 
> configuration file (~/.asoundrc).
defaults.namehint.showall=1 didn't make a difference,
but defaults.namehint.extended=1 did.
Thanks again!
