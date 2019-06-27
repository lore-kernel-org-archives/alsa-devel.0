From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] device property: Add new array helper
Date: Thu, 27 Jun 2019 11:17:55 +0200
Message-ID: <CAJZ5v0g8or=OrEYBPE4K7k6P1ymAHOdwFaqZE9-Lr8eVp0hubg@mail.gmail.com>
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
 <20190627001530.GG527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEC0AF806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 11:18:08 +0200 (CEST)
Received: by mail-ot1-f67.google.com with SMTP id l15so1537551otn.9
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 02:18:08 -0700 (PDT)
In-Reply-To: <20190627001530.GG527@kroah.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 27, 2019 at 2:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 26, 2019 at 04:36:10PM +0100, Charles Keepax wrote:
> > It is fairly common to want to read an integer array property
> > that is composed of an unknown number of fixed size integer
> > groups. For example, say each group consists of three values
> > which correspond to the settings for one input on the device
> > and the driver supports several chips with different numbers
> > of inputs.
> >
> > Add a new helper function to provide this functionality, it
> > differs for the existing helpers in that it allows reading a
> > smaller number of values than the full array size and checks
> > that the number of values read is a multiple of the group size.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |  2 ++
> >  2 files changed, 50 insertions(+)
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Well, I'm kind of not convinced about this one.

More comments in direct reply to the patch message.
