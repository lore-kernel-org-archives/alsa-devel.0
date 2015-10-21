From: Caleb Crome <caleb@crome.org>
Subject: Re: Gmail thinks most alsa-devel mail is spam
Date: Wed, 21 Oct 2015 12:32:22 -0700
Message-ID: <CAG5mAdyivbfwi1JBwHdu+c89j0GkE0Cux+eww7+SnAvUTkCPug@mail.gmail.com>
References: <5627833D.8020908@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 272B4260715
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 21:32:43 +0200 (CEST)
Received: by wicfx6 with SMTP id fx6so106144820wic.1
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 12:32:42 -0700 (PDT)
In-Reply-To: <5627833D.8020908@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, alsa-devel-owner@alsa-project.org, mailman-owner@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Timur,
   Very interesting. I checked myself, and I get almost all the alsa
emails without them going to spam. (I'm using gmail too).  However, 2
specifically did end up in spam:

[alsa-devel] [PATCH 0/3] ASoC: dapm: add PGA kcontrol, dai_link enhancement &

and

[alsa-devel] Driver for audio power amplifier ICs?


I updated my filter so it will never go to spam:

In gmail go to

   settings->Filters and blocked Addresses->Create New Filter

Subject = [alsa-devel]

Then, "Create Filter With This Search"

Then "Apply The Label" = alsa
and tick the box that says, "Never send it to Spam"
and the box that says, "Also apply this filter to matching conversations"

That should get you out of the check-spam loop.

-Caleb






On Wed, Oct 21, 2015 at 5:21 AM, Timur Tabi <timur@tabi.org> wrote:
> Hi,
>
> I use gmail to subscribe to Linux mailing lists, and most of the mail to
> alsa-devel ends up in the spam folder.  According to gmail, the reason is:
>
> "Why is this message in Spam? It is in violation of Google's recommended
> email sender guidelines."
>
> and then it tell me to look here:
>
> https://support.google.com/mail/answer/81126?hl=en#authentication
>
> Is this something that can be fixed?  It's really annoying have to check my
> spam folder every day to fish out messages from alsa-devel.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
