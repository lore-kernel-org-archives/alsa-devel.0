From: Thorsten Riess <tcriess@gmx.de>
Subject: Intel HDA pin-config values (patch_sigmatel.c) - Dell
 Inspiron 1721 (also 1521?) mic
Date: Sat, 11 Aug 2007 16:24:33 +0100
Message-ID: <46BDD4B1.7030507@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.18.16]) by alsa0.perex.cz (Postfix) with ESMTP id 591DB10393C
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Aug 2007 17:24:33 +0200 (CEST)
Received: from unknown (HELO [192.168.2.3]) (053367@[77.100.96.4])
	(envelope-sender <tcriess@gmx.de>)
	by smtprelay04.ispgateway.de (qmail-ldap-1.03) with SMTP
	for <alsa-devel@alsa-project.org>; 11 Aug 2007 15:24:32 -0000
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

Hi,

I am wondering where the values of ref9205_pin_configs in patch_sigmatel
come from. The SigmaTel documentation gives different reference values for
the 9205.
The set of values I use at the moment is
static unsigned int ref9205_pin_configs[12] = {
	0x02214020, 0x02a19041, 0x40000100, 0x40000100,
	0x40000100, 0x40000100, 0x40000100, 0x40000100,
	0x10a000f0, 0x50a000f0, 0x01441030, 0x01c41030
};
(the first two are actually from the SigmaTel document, the other just mute
the remaining in/outs)
These numbers actually work quite well for the Dell Inspiron 1721 (and
probably for the 1521), even the mic input works - although the quality
could be better and the input levels have to be adjusted carefully.
Can anybody confirm this?
Thorsten.
