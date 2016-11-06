From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about the buffer length in the
	transfer	callback of the PCM External Plugin
Date: Sun, 6 Nov 2016 12:26:43 +0100
Message-ID: <c50375c2-42df-f588-3c42-33cd3b2f8a08@ladisch.de>
References: <a68475dd084f4a45b224791224c7c244@LGNMSXB01.prod.bk.dfs>
 <19904f93-f0ba-56a9-2980-ed52fe2a32bb@ladisch.de>
 <6c2af613d3b64138bc6e7c6cf69486cf@LGNMSXB01.prod.bk.dfs>
 <2dc2c73c-9d7c-3d3e-4d23-9797de2d1ec4@ladisch.de>
 <165e6496dc554e18836006a6b77461ce@LGNMSXB01.prod.bk.dfs>
 <93708608-9498-de05-9256-d650a44e18d8@ladisch.de>
 <1ce46f88056b4b2caa2ecf770da07d76@LGNMSXB01.prod.bk.dfs>
 <23292d9e-2fb6-1805-96c8-b2d5fa336665@ladisch.de>
 <e48b1619d89d4f7faf5640fd2d337555@LGNMSXB01.prod.bk.dfs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D3998266629
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 12:27:21 +0100 (CET)
In-Reply-To: <e48b1619d89d4f7faf5640fd2d337555@LGNMSXB01.prod.bk.dfs>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bach, Andrea" <andrea.bach@dfs.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bach, Andrea wrote:
> What I tried is to copy the buffer I get in chunks of a 64 bytes into
> an intermediate buffer for processing and whenever I processed
> 64 bytes I copied the result to the output buffer .... but what to do
> with the remaining 40 bytes...

Leave them in the intermediate buffer, and handle them later when you've
got 24 more bytes.

> and what to return in the output buffer when the remaining bytes could
> not be processed??

Delay the entire chain by 64 bytes, i.e., insert 64 byte at the start of
the stream.  Then you always have too many bytes instead of too few
bytes, and those can be handled with the intermediate buffer.


Regards,
Clemens
