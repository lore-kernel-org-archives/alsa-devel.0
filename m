From: Caleb Crome <caleb@crome.org>
Subject: Re: Real-time audio over local network with good
	quality
Date: Tue, 5 Apr 2016 08:47:26 -0700
Message-ID: <CAG5mAdwLs8n+a1rx1xEvP65y_EEaz02ekxK7mV=NDDUxHg6Ynw@mail.gmail.com>
References: <CAAu8FsdLJfSNau-OYcvja4F6rhFmu9skZvR0DeM38dA_wN+BMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f170.google.com (mail-ob0-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 52B73265041
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 17:47:48 +0200 (CEST)
Received: by mail-ob0-f170.google.com with SMTP id fp4so12070229obb.2
 for <alsa-devel@alsa-project.org>; Tue, 05 Apr 2016 08:47:48 -0700 (PDT)
In-Reply-To: <CAAu8FsdLJfSNau-OYcvja4F6rhFmu9skZvR0DeM38dA_wN+BMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricardo Biehl <rbpoficial@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

What software is running on the microphone?  If it's linux, you can use
netjack, or perhaps pulseaudio too.  I'm not familiar with pulse though.

-Caleb


On Thu, Mar 31, 2016 at 11:52 AM, Ricardo Biehl <rbpoficial@gmail.com>
wrote:

> Hello guys! I'm sorry if this mail is not part of the scope of this list
> :-(
>
> I've come from the kernelnewbies mailing list with the same subject as
> following ...
>
> I'm working on a project which aims to be a microphone system that
> will work over local network <https://github.com/ricardobiehl/ipmic>.
> So I've found many difficulties in ALSA library and Linux Network.
> Basically, I need help to make my software get low latency and high
> quality audio :-) .
>
> When I said "high quality audio" I'm referring to (1channel * 16bit
> sample * 22050Hz) without noise. And "low latency" is about to 0.1
> second or less.
>
> Any contribution with the project is welcome!
>
> Thank you a lot!
>
> --
> Ricardo Biehl Pasquali
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
