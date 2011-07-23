From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Sending headset insertion events to user space on
 bootup
Date: Sat, 23 Jul 2011 08:45:05 +0100
Message-ID: <20110723074505.GA14526@sirena.org.uk>
References: <4E29C862.8010208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E84410380E
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jul 2011 09:45:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E29C862.8010208@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brad Rubin <brubin@codeaurora.org>
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 22, 2011 at 11:58:42AM -0700, Brad Rubin wrote:

> Does anyone know of a solution so user space can receive headset 
> insertion events on bootup?

Userspace can read the state of the device at any time, when it starts
up it should look at the current state.
