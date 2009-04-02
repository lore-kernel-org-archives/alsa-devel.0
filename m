From: Simon Hengel <simon.hengel@wiktory.org>
Subject: Re: vi-like key bindings for alsamixer
Date: Thu, 2 Apr 2009 17:50:34 +0200
Message-ID: <20090402155034.GA5790@john>
References: <1238615895-5980-1-git-send-email-simon.hengel@gmx.net>
	<49D46195.5030609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id ABADF103877
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:50:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <49D46195.5030609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 08:56:21AM +0200, Clemens Ladisch wrote:
> > Is this deemed suitable for the masses?
> 
> _Undocumented_ commands certainly aren't.  ;-)
This is certainly true.

While working on documentation I realized that '+' and KEY_UP, contrary
to what is documented, do different things.

'+' increases volume by 1% whereas KEY_UP increases volume by 2%.

So actually it is like:

W | +           increase volume by 1%
w | KEY_UP      increase volume by 2%
X | -           decrease volume by 1%
x | KEY_DOWN    decrease volume by 2%

Still this makes no difference with my hardware, as the granularity is >
3% (e.g. snd_mixer_selem_get_playback_volume_range gives {0, 31} or {0,
15} for {min, max}).

I wonder if it would be a good idea to unify it. Consequently one could
do the same for left & right levels.
