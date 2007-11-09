From: Friedrich Lobenstock <f.lobenstock@scottygroup.com>
Subject: [ASoc] TDM over one SSC channel on AT91 possible?
Date: Fri, 09 Nov 2007 12:37:00 +0100
Message-ID: <4734465C.4020900@scottygroup.com>
Reply-To: Alsa-Devel Mailing List <alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.scottygroup.com (mailrelay1.scottygroup.com
	[193.154.221.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 732D324343
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 12:37:03 +0100 (CET)
Received: from [10.2.1.125] (gw-graz.scottygroup.com [193.154.221.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mailrelay1.scottygroup.com (Postfix) with ESMTP id 37EC9127
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 12:36:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello!

The background:   I'm just designing an ATMEL AT91RM9200 based board which
                  got two TLV320AIC33 on board. It is either possible
to hook up the two TLV320AIC33 to a separate SSC (synchronous serial
control) channel each or use one SSC channel and configure it for TDM (time
division multiplex) mode. There is already a driver for
TLV320AIC14k/TLV320AIC2k in the development tree, so adding support for the
TLV320AIC33 should be feasible.

What I'm not sure about is the fact if ASOC is prepared for using channels,
especially SSC, in TDM mode. Is the core ASOC structure prepared to handle
that?

Would we be better off instantiate one drive twice each time with different
parameters for the SSC channel?

Thanks for any feedback.

-- 
MfG / Regards
Friedrich Lobenstock
_________________________________________________________
SCOTTY Group Austria GmbH
a SCOTTY Group plc company, http://www.scottygroup.com/
_________________________________________________________
