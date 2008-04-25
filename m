From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How can you tell if the speaker jack on your	sound
	card has anything plugged into it???
Date: Fri, 25 Apr 2008 20:49:18 +0100
Message-ID: <20080425194917.GA26621@sirena.org.uk>
References: <48123137.70107@summitmediagroupllc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 01E5B2477F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 21:49:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48123137.70107@summitmediagroupllc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean Thayne <sthayne@summitmediagroupllc.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 25, 2008 at 01:29:59PM -0600, Sean Thayne wrote:

>       I was talking with some users in the irc channel in the free node, 
> and was hoping to find a way to get the information about weither or not 
> anything was plugged into the sound card, I've seen this feature with 
> windows vista. I search thru a bunch of documentation sites and also 
> scanned the /proc & /sys to no avail...

There's currently no standard way of getting this information from user
space even where the hardware provides it.
