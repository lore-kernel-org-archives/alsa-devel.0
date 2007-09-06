From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Thu, 06 Sep 2007 13:20:08 +0200
Message-ID: <46DFE268.7080404@gmail.com>
References: <46dfa2e7d6be4@wp.pl> <46DFD29A.6020601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 3565924370
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 13:26:38 +0200 (CEST)
In-Reply-To: <46DFD29A.6020601@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/06/2007 12:12 PM, Rene Herman wrote:

> Full duplex (simultaneous playback and capture) is something that 
> neither Sb Pro nor CS4231 does. I do see that SB Pro doesn't natively 
> support S16_LE it seems...

Sorry, incorrect -- the cs4231 is full duplex. It's only the cs4248 (ad1848) 
which is not. Need to figure out how to do full duplex on a sound galaxy; 
old driver didn't do so.

Rene.
