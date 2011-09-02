From: Daniel Mack <zonque@gmail.com>
Subject: Re: submitting patch: specify destination kernel
	version(s)
Date: Fri, 2 Sep 2011 14:50:36 +0200
Message-ID: <CACTFLAN-HSBbYz1NQo7oLyMqz50wvz_dhTRBWA+OF2gVp6b=1w@mail.gmail.com>
References: <1322a11922c.1088573675407063638.-3372964620296301533@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F3F4103961
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 14:50:37 +0200 (CEST)
Received: by pzk1 with SMTP id 1so4843046pzk.2
	for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2011 05:50:36 -0700 (PDT)
In-Reply-To: <1322a11922c.1088573675407063638.-3372964620296301533@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: Greg KH <greg@kroah.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 2, 2011 at 2:16 PM, Torsten Schenk <torsten.schenk@zoho.com> wrote:
> Hi,
>
> I'm currently preparing a patch for the kernel, I want it to be included from 3.0 on, but not in versions before. I once got a hint to put
>
> Cc: stable@kernel.org
>
> but that seems not to do the trick. How could it be achieved, that the patch only appears in 3.0 (and later)?
>

This is not really officially documented, but there seems to be a
general agreement that this line should do what you want:

  Cc: stable@kernel.org [3.0+]

At least, other patches were submitted that way. Greg, is that correct?


Daniel
