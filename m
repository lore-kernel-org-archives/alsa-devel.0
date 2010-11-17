From: Eric Lammerts <alsa-devel@lists.lammerts.org>
Subject: Re: [PATCH] cm6206: turn off de-emphasis in s/pdif
Date: Tue, 16 Nov 2010 22:24:52 -0500 (EST)
Message-ID: <Pine.LNX.4.61.1011162206100.2186@kermit.ultrawaves>
References: <Pine.LNX.4.61.1011161859260.551@kermit.ultrawaves>
	<AANLkTik6-V2Gv5JCWeSmv_qxETgjpn7nL75UZz74dvJ2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ultrawaves.com (rrcs-71-43-195-114.se.biz.rr.com
	[71.43.195.114]) by alsa0.perex.cz (Postfix) with ESMTP id 2226B243C1
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 04:24:55 +0100 (CET)
In-Reply-To: <AANLkTik6-V2Gv5JCWeSmv_qxETgjpn7nL75UZz74dvJ2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Pardini <pardo.bsso@gmail.com>
Cc: Dan Allongo <gongo2k1@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tue, 16 Nov 2010, Adrian Pardini wrote:
> Hi all, I have to resubmit some patches for the same chip related to
> headphone support. Will you find it useful if I added the de-emphasis
> control as a mixer switch?

I don't think it would add that much value, pre-emphasis is hardly 
ever used. And if there are applications that care about it, they 
probably can handle it in software, since many drivers don't have 
such a mixer switch.

If you do make it a mixer switch, I would appreciate it if the 
default is "off" :-).

Eric
