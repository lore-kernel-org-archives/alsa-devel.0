From: Christoph Kuhr <christoph.kuhr@web.de>
Subject: Extern dsp device
Date: Sat, 14 Aug 2010 23:14:26 +0200
Message-ID: <1184DC07-4A5D-4DB0-816B-8FE8ACD074A7@web.de>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 938B724569
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 23:15:26 +0200 (CEST)
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5436015D94454
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 23:15:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi everybody,

In my bachlor project im planing to realise an outboard fpga dsp  
device connected by gbit ethernet and driven by alsa.

The idea:
computer system with linux rt kernel, extra gbit ethernet if and for  
example rme hdsp 9652  audio if.
Outboard fpga with gbit if and DSP routines (PureD ata Engine?)

Now the fpga board is connected via gbit eth, the kernel gets it and  
inserts the gbit ethernet card into the audio signal path.
Managed with and alsa driver, cooperating with the snd-rme9652.
With a gui sending OSC to the fpga board, controlling the dsp.

Goal: zero-latency routing and dsp

Do you think this strategy might work?

Ck
