From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bug
Date: Tue, 31 Mar 2015 14:42:08 +0200
Message-ID: <551A9620.6090308@ladisch.de>
References: <1427551386.3092172.246393281.691C33A7@webmail.messagingengine.com>	<5518F8F3.10304@ladisch.de>	<1427711234.231499.246955417.6E2E7C65@webmail.messagingengine.com>	<55192FBC.1070307@ladisch.de>	<1427726222.1872206.247049189.3E3BB0F7@webmail.messagingengine.com>	<551A4A2E.8040905@blennerhassett.gen.nz>	<1427789953.2143209.247430925.7143290B@webmail.messagingengine.com>	<551A5D21.8000406@ladisch.de>
 <1427792714.2152814.247446829.32E51ED1@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id F03FA261A7F
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 14:42:11 +0200 (CEST)
In-Reply-To: <1427792714.2152814.247446829.32E51ED1@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Nikita N." <nikitan@operamail.com>
Cc: alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

Nikita N. wrote:
>> http://www.iua.upf.es/~mdeboer/projects/alsamixergui/
>
> this link is broken, please provide a correct one

This is the last known link.

>> Please note that _every_ mixer application on _every_ OS might be able
>> to set the controls to those dangerous values.
>
> is it "might" or it is?

I was not able to test all of them.  But I would be surprised if there
is any mixer that knows about this broken hardware and somehow restricts
the mixer ranges.

> Is also your alsamixer textual version tool, capable of speakers
> burnout?

As I already wrote above, on that hardware, I estimate that _every_
mixer tool is capable of that.


Regards,
Clemens
