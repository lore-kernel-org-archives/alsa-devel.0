From: "Demian Martin" <demianm_1@yahoo.com>
Subject: Juli@ ICE1724 and 24 bit audio
Date: Mon, 9 Feb 2009 12:09:11 -0800
Message-ID: <366C228A7F9A4AAF9EE7190DC4C0EE68@PDSDesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.prem.mail.sp1.yahoo.com
	(smtp103.prem.mail.sp1.yahoo.com [98.136.44.58])
	by alsa0.perex.cz (Postfix) with SMTP id 239A6103840
	for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2009 21:09:13 +0100 (CET)
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
Cc: pavel.hofman@ivitera.com, pavel.hofman@insite.cz
List-Id: alsa-devel@alsa-project.org

I have the driver working fine for sample rates from 44.1K to 196K however
it seems to be truncating the data to 16 bits. I wasn't sure until I started
testing with the HRx 176.4K 24 bit files that have an embedded HDCD flag in
the LSB. The files work OK on Windoze systems (with a lot of low level
settings tweaked) and they play fine but the flag isn't detected by a system
that can detect them. Further looking at the data stream with a scope it
seems the last 8 bits aren't changing. Is there anything I can do to control
the driver to confirm this problem or change the playback settings to make
it work?

 

Demian Martin

Product Design Services

784 Cary Drive

San Leandro, CA 94577

209 613 6990
