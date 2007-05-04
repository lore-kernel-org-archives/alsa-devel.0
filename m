From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Aureon 7.1 Firewire supported by ALSA ?
Date: Fri, 04 May 2007 11:02:10 +0200
Message-ID: <463AF692.9080904@joow.be>
References: <200705040808.30501.mgd@technosis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thumbler.kulnet.kuleuven.ac.be (thumbler.kulnet.kuleuven.ac.be
	[134.58.240.45]) by alsa0.perex.cz (Postfix) with ESMTP id 5F8162445B
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 11:02:14 +0200 (CEST)
In-Reply-To: <200705040808.30501.mgd@technosis.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Gerdau <mgd@technosis.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Michael Gerdau wrote:
> Hi list,
> 
> looking for an external (USB or Firewire) interface to record at
> least a single stereo 44.1kHz/24bit S/P-DIF signal I've come
> across the Aureon 7.1 Firewire but have not been able to find out
> whether it is already supported by ALSA.
> 
It is not supported by ALSA. But it is supported by FreeBoB, meaning 
that you can use it with any jack-enabled application.

There is not native ALSA support yet.

Greets,

Pieter Palmers

Check:
freebob.sf.net
ffado.org
