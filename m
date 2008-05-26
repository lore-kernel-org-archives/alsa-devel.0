From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: Re: snd_kcontrol questions
Date: Mon, 26 May 2008 15:12:48 +0530
Message-ID: <827ad74d0805260242k15349ea3m2ecef3c5c8646218@mail.gmail.com>
References: <827ad74d0805212315o7e55bf92q6aa81cfa9c1e461e@mail.gmail.com>
	<483551D7.1000500@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by alsa0.perex.cz (Postfix) with ESMTP id BD41C103816
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 11:42:49 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so388613and.80
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2008 02:42:48 -0700 (PDT)
In-Reply-To: <483551D7.1000500@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks a lot. Answers for 1 and 3 helped me fix my issues. Ill review my
code for 2 and shall seek your help if i find myself unlucky.

Thanks again.


On Thu, May 22, 2008 at 4:28 PM, Clemens Ladisch <clemens@ladisch.de> wrote:

> Harsha priya gupta wrote:
> > 1. I want to define a snd_kcontrol that is of type mono.
>
> In the control's info callback, set the count element of the
> snd_ctl_elem_info structure to 1.
>
> > 2. My input controls give out 9 channels when i say 'split channels' in
> > kmix. can anyone help me how to fix that to 2 channels
>
> There's something wrong in your code.  Which you didn't show.
>
> > 3. I would want to get the individual setting of each channel from KMIX
> into
> > my ALSA driver. How do I get them?
>
> The snd_ctl_elem_value structure contains an array of values.
>
>
> HTH
> Clemens
>



-- 
-Harsha
