From: Florian Faber <faber@faberman.de>
Subject: Re: Extern dsp device
Date: Sun, 15 Aug 2010 13:09:47 +0200
Message-ID: <4C67CAFB.20302@faberman.de>
References: <1184DC07-4A5D-4DB0-816B-8FE8ACD074A7@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from india820.server4you.de (india820.server4you.de [85.25.152.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 67DFF10380C
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 13:09:59 +0200 (CEST)
In-Reply-To: <1184DC07-4A5D-4DB0-816B-8FE8ACD074A7@web.de>
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

On 08/14/10 23:14, Christoph Kuhr wrote:

> Goal: zero-latency routing and dsp

This is far from being zero latency. Why don't you connect the FPGA to
the ADAT ports where you can work with the audio data on a proper level.
You can still control the FPGA via Ethernet.

Besides, what would be the practical use of such a plug-in-device?


Flo
-- 
Machines can do the work, so people have time to think.
public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
