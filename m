From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: How to configure SGTL5000 ASoC as master?
Date: Tue, 10 Jan 2012 15:57:47 +0200
Message-ID: <4F0C43DB.1070000@bluegiga.com>
References: <4F0BD878.40508@bluegiga.com>
	<7FE21149F4667147B645348EC605788508AA69@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from darkblue.bluegiga.com (bluegiga.fi [194.100.31.45])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F59D24598
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 14:57:49 +0100 (CET)
In-Reply-To: <7FE21149F4667147B645348EC605788508AA69@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 01/10/2012 08:43 AM, Dong Aisheng-B29396 wrote:
>> SGTL5000 ASoC is hard coded to be slave in sound/soc/mxs/mxs-sgtl5000.c.
> Yes, Saif TX can only work on master mode so we simply only support master mode
> for both saif rx/tx.

You are right. I didn't notice that before. Thanks.

Lauri
