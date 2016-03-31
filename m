From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA license
Date: Thu, 31 Mar 2016 16:13:34 +0200
Message-ID: <56FD308E.8090006@ladisch.de>
References: <3CD7D8096827214EA72BFDC6B95C7CC931B5654F@VEREXCH02.harrisbroadcast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 401BE2666D6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 16:13:36 +0200 (CEST)
In-Reply-To: <3CD7D8096827214EA72BFDC6B95C7CC931B5654F@VEREXCH02.harrisbroadcast.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Li, Steve" <Steve.Li@imaginecommunications.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Li, Steve wrote:
> I am trying to use ALSA in a commercial application. I see that in the
> introduction page, ALSA is licensed under GPL and LGPL. Can you tell
> me which part of ALSA is licensed under LGPL?

The ALSA library itself is licensed under the LGPL, so your closed-
source application can link to libasound.so.2.  Other parts of ALSA
(kernel drivers, plugins, etc.) are GPL.


Regards,
Clemens
