From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Setting the AC97 private data
Date: Tue, 28 Apr 2009 16:40:37 -0400
Message-ID: <9e4733910904281340hf06c71fj79f091cbb6e6f770@mail.gmail.com>
References: <9e4733910904280951t3f03f8c4p44e4a7025ebb7ef1@mail.gmail.com>
	<20090428195942.GA10325@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E94FC245A7
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 22:40:40 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1549008qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2009 13:40:40 -0700 (PDT)
In-Reply-To: <20090428195942.GA10325@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 3:59 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Apr 28, 2009 at 12:51:31PM -0400, Jon Smirl wrote:
>
>> Is there some easier way to set this data?
>
> Not particularly; only one AC97 controller is supported at once.
>

mpc5200 allows multiple active AC97 controllers but I've never want to
use more than one at a time.


-- 
Jon Smirl
jonsmirl@gmail.com
