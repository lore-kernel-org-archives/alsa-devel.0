From: Christoph Kuhr <christoph.kuhr@web.de>
Subject: Re: Extern dsp device
Date: Sun, 15 Aug 2010 20:55:57 +0200
Message-ID: <E032C65C-DFB6-4453-8AC2-BB93132E6D61@web.de>
References: <1184DC07-4A5D-4DB0-816B-8FE8ACD074A7@web.de>
	<4C67CAFB.20302@faberman.de>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate03.web.de (fmmailgate03.web.de [217.72.192.234])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0D61037EA
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Aug 2010 21:01:03 +0200 (CEST)
In-Reply-To: <4C67CAFB.20302@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The practical use would be the processing of the IOs of the soundcard  
in live performances.

Ck



Am 15.08.2010 um 13:09 schrieb Florian Faber <faber@faberman.de>:

> On 08/14/10 23:14, Christoph Kuhr wrote:
>
>> Goal: zero-latency routing and dsp
>
> This is far from being zero latency. Why don't you connect the FPGA to
> the ADAT ports where you can work with the audio data on a proper  
> level.
> You can still control the FPGA via Ethernet.
>
> Besides, what would be the practical use of such a plug-in-device?
>
>
> Flo
> -- 
> Machines can do the work, so people have time to think.
> public key DA43FEF4          x-hkp://wwwkeys.eu.pgp.net
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
