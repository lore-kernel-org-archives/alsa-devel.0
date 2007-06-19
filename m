From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: SoC multiple streams
Date: Tue, 19 Jun 2007 11:18:03 +0100
Message-ID: <1182248283.26658.134.camel@localhost.localdomain>
References: <4676FF4A.3020508@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 27138103802
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 12:18:04 +0200 (CEST)
In-Reply-To: <4676FF4A.3020508@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Longerbeam <stevel@embeddedalley.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-06-18 at 14:55 -0700, Steve Longerbeam wrote:
> Hi all,
> 
> I'm developing an SoC driver for a sound engine that supports playing up 
> to 64 simultaneous substreams, all mixed in h/w to a stereo DAC. But it 
> doesn't appear that the SoC framework supports multiple substreams, 
> according to soc_new_pcm(). Am I missing something, or is this on the 
> asoc development roadmap?
> 

It's now on the development roadmap ;)

https://bugtrack.alsa-project.org/wiki/wikka.php?wakka=ASoCRoadMap

Liam
