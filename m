From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: Re: [PATCH 1/2] ASoC: pcm3060: Add control for
	differential output
Date: Fri, 9 Nov 2018 14:06:50 +0100
Message-ID: <34162ae4-5000-f355-a5a2-90c7b7c6c3e7@birdec.tech>
References: <20181029085913.17298-1-kmarinushkin@birdec.tech>
 <20181105112036.GC5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D8C267AB4
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 14:04:46 +0100 (CET)
In-Reply-To: <20181105112036.GC5365@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 11/05/18 12:20, Mark Brown wrote:
> On Mon, Oct 29, 2018 at 09:59:12AM +0100, Kirill Marinushkin wrote:
>> DAC may be switched between differential and single-ended output.
> 
> Isn't this something that'd be better controlled by DT - it's usually
> going to be part of the board design?
> 

I agree with that. I implemented it as a switch, just because that's how other
codec drivers do. In such situations, I prefer to be aligned with already
existing code.

Indeed, it's more logical to implement such setup via DT. I will rewrite and
send it as patch v2.

Best Regards,
Kirill
