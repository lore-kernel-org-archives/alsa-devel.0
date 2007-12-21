From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Conexant CX2051 on HP Spartan
Date: Fri, 21 Dec 2007 16:42:15 -0200
Message-ID: <5f52f6d70712211042j2e0537bsfb84e7d67bd27db5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 98FA51038A7
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 19:42:19 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so279410rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 10:42:16 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working with Herton Krzesinski on a HP Spartan laptop which has a
Conexant CX2051 configured with internal and external microphones
connected to two different ADC nodes (0x14 and 0x15 in
http://helllabs.org/tmp/hp-spartan-ng.png). We were able to get input
from one or other ADC, but we weren't able to switch from one capture
source to another (switching between  0x17 and 0x1d would be simple,
but HP chose to route the external and internal mics to two different
ADCs). What is the recommended way to handle this kind of setup?
