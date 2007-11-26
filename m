From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: POSIX clocks and ALSA
Date: Mon, 26 Nov 2007 09:31:10 +0200
Message-ID: <474A763E.7090001@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh06.mail.saunalahti.fi (emh06.mail.saunalahti.fi
	[62.142.5.116]) by alsa0.perex.cz (Postfix) with ESMTP id 2EEA02476D
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 08:31:13 +0100 (CET)
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id A2D17C8B86
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 09:31:12 +0200 (EET)
Received: from marumake.local (a88-112-236-112.elisa-laajakaista.fi
	[88.112.236.112])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 82D3A158B70
	for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2007 09:31:09 +0200 (EET)
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

Hello,

Some years ago there was some talk about UST support in Linux, but the 
support never happened. With the hrtimers patch (and I'm not quite sure 
if even earlier?) CLOCK_MONOTONIC would seem like a fairly good UST time 
source. What I'd like to see, is a selectable clock for ALSA 
timestamping, e.g. something like snd_sw_params_clock(..., clockid_t 
clk). Would this seem plausible? I don't know that much about ALSA 
internals, so, no idea whether different clocks on different 
pcms/whatever would quickly turn into an unmanageable mess.

-- Heikki Lindholm
