From: Timur Tabi <timur@freescale.com>
Subject: Re: OSS app works but aplay does not with
	SNDRV_PCM_FMTBIT_U32_LE
Date: Thu, 20 Sep 2007 15:50:52 -0500
Message-ID: <46F2DD2C.2080503@freescale.com>
References: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>	<1190184377.23573.1211414421@webmail.messagingengine.com>	<0MKp8S-1IY1GZ25ZF-0008LO@mrelay.perfora.net>	<1190217792.23470.1211502657@webmail.messagingengine.com>
	<0MKp8S-1IY3QT3Lfw-0008HE@mrelay.perfora.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 04D2224540
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 22:51:01 +0200 (CEST)
In-Reply-To: <0MKp8S-1IY3QT3Lfw-0008HE@mrelay.perfora.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Strobel <steve.strobel@link-comm.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve Strobel wrote:

> Does a result code of -22 mean anything significant?

-22 is EINVAL, which usually means an invalid parameter.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
