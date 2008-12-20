From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: ASoC updates
Date: Sat, 20 Dec 2008 09:58:36 -0500
Message-ID: <74eb1fe20812200658w7c6fb103o843ee65d0e8ade90@mail.gmail.com>
References: <4edcd8463d981e4babef82167aa58131539c367f.1229601269.git.stanley.miao@windriver.com>
	<20081219163501.0e235884.jarkko.nikula@nokia.com>
	<s5h4p10w7nm.wl%tiwai@suse.de> <20081220135131.GA12554@sirena.org.uk>
	<35fa40850812200611t2983e6f5n30b8d1a8ca2b9966@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BFEB1037ED
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 15:58:37 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so738187waf.16
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 06:58:36 -0800 (PST)
In-Reply-To: <35fa40850812200611t2983e6f5n30b8d1a8ca2b9966@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: SUBHRANIL CHOUDHURY <subhra85@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Dec 20, 2008 at 9:11 AM, SUBHRANIL CHOUDHURY <subhra85@gmail.com> wrote:
> Dear all,
> I am new to ALSA  programming.
> Suppose if i have to add some hardware specific feature in the ALSA sound
> driver and expose to the application via the ALSA library, how can do that?

The generic interface to do that would be hwdep... in userspace, you
would have to modify libasound2 (alsa-lib) to correctly use the hwdep
interface, as documented here:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___hw_dep.html

>
> Please reply if you have some inputs.

Please look through the documentation for 5 minutes first before
posting to the ML... the updated documentation for 1.0.18 is
maintained at
http://www.alsa-project.org/alsa-doc/alsa-lib/index.html

Thanks,

Sean

> Anything is welcome.
> Thanks in advance.
>
> Regards,
> Subhranil
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
