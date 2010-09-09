From: Felix Homann <fexpop@web.de>
Subject: M-Audio Fast Track Ultra (8r) mixer: How to verify dB
	information?
Date: Thu, 09 Sep 2010 23:37:34 +0200
Message-ID: <4C89539E.8030701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 682F6243D3
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 23:37:41 +0200 (CEST)
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

Hi list,

after some struggle I managed to get the mixer in the M-Audio working. 
Before I submit a patch I would like to know if there's an way to test 
the dB information for the controls. I'm using the mixer_vol_tlv TLV 
callback right now but I'm not sure it produces correct data.

Kind regards,

Felix
