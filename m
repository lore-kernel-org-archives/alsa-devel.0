From: Erik Friesen <friesendrywall@gmail.com>
Subject: Re: SGTL5000
Date: Sun, 7 Feb 2016 16:08:53 -0500
Message-ID: <CAEuupiuJyW1gfp8u=GgTiN0noF+UvcF64DZtn=Kk5PCcypE7Cw@mail.gmail.com>
References: <CAEuupiuoR=3MVkP5aS3Jn1GQvUdQ1a9rmT1-2oQSQUdCfZRQ1Q@mail.gmail.com>
 <CAEuupiuH3r5w11EV6C7rYi_8pwrfuw1fWGyHhbxoYQWcMrSsDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD67260474
 for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2016 22:08:56 +0100 (CET)
Received: by mail-ig0-f169.google.com with SMTP id mw1so45899345igb.1
 for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2016 13:08:56 -0800 (PST)
In-Reply-To: <CAEuupiuH3r5w11EV6C7rYi_8pwrfuw1fWGyHhbxoYQWcMrSsDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Test email
On Feb 6, 2016 8:52 AM, "Erik Friesen" <friesendrywall@gmail.com> wrote:

> Is this list active?  Can someone at least confirm the alsa-devel
> filter isn't kicking my emails out?
>
> I have a couple suggested changes to sgtl5000.c.
>
> On Wed, Feb 3, 2016 at 12:06 PM, Erik Friesen <friesendrywall@gmail.com>
> wrote:
> > I was sort of directed to this list from linux-arm.
> >
> > I have been working with an embeddedarm ts4900 and built a baseboard
> > that uses the sgtl5000.  I also have worked with the RiotBoard, which
> > uses the same chip, both using the i.mx6 arm.  I find that
> > occasionally the sgtl5000 is resetting, and there is no way to bring
> > it back online.  As near as I can tell, the i2c bus comes back alive,
> > for example alsamixer communicates fine, coms happen on the i2c bus
> > per scope.  However, its obvious the chip never gets re initialized by
> > how it acts.
> >
> > I know the thing shouldn't reset, that is the primary problem, but I
> > still want some backup method.  Its probably due to ground bounce from
> > a non earth grounded setup.  It could be that using the external
> > regulator will help, we will see.
> >
> > Is there a suggestion on a way the sgtl5000.c could be extended to
> > support some sort of re initialize routine?
> >
> > I am using the embeddedarm repo as a base kernel.  sgtl5000.c has been
> > updated to include
> > ret = sgtl5000_fill_defaults(sgtl5000);
> > but the base kernel is 3.10.53.  However, the riotboard runs 4.3 with
> > similar results.
>
