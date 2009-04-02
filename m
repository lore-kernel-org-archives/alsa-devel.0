From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Interleaving and Deinterleaving support
Date: Thu, 02 Apr 2009 17:33:30 +0200
Message-ID: <49D4DACA.2010308@ladisch.de>
References: <BAY119-W55D505978A73AE7CDB81D4B08B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3F51110386D
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:33:29 +0200 (CEST)
In-Reply-To: <BAY119-W55D505978A73AE7CDB81D4B08B0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Singaravelan Nallasellan <singaravelann@hotmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Singaravelan Nallasellan wrote:
> Does alsa core in the kernel support interleaving and deinterleaving?

No, but the alsa-lib plugins can do this.

> if the driver receives a deinterleaved stream and wants to interleave
> for the sound card, should the driver perform the conversion?

No, the driver should just set the bit that indicates that the hardware
supports interleaved data; the data will then be automatically
converted by alsa-lib.


HTH
Clemens
