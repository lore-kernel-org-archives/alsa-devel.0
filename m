From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to retrieve the final data being played by HW
Date: Thu, 29 Apr 2010 10:19:58 +0100
Message-ID: <20100429091957.GB21607@sirena.org.uk>
References: <4BD94E3A.2040301@fortemedia.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 63A6D24422
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 11:20:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BD94E3A.2040301@fortemedia.com.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yu Hang <hangy@fortemedia.com.cn>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 29, 2010 at 05:15:38PM +0800, Yu Hang wrote:

> For example, the 1st instance had mixes the data into destination 
> buffer, but 2nd instance haven't complete the mix operation. Would the 
> data in destination buffer be playing by HW?
> Or there is some mechanism to guarantee the data will be played after 
> all mix operation is done.

You need to ensure that the user configures the plugin stack
appropriately to ensure that your plugin is the last one that's run, you
can't do this purely from within your plugin.  Even if that's done you'd
also need to rely on them not configuring any DSP in the hardware which
would disrupt things.
