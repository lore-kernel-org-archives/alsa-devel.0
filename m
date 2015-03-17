From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Mon, 16 Mar 2015 17:55:04 -0700
Message-ID: <20150317005503.GA5480@Asurada-GSX>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8ED261A03
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 01:55:11 +0100 (CET)
Received: by pagr17 with SMTP id r17so80625145pag.0
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 17:55:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Embedded <programassem@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

On Mon, Mar 16, 2015 at 03:30:49PM +0800, Shawn Embedded wrote:

>     Now there is a wm8962 on the i.mx6 board, running well, and we
> want to add an extra wm8962 to the board, connected to i.mx6 on
> another SSI port through a different i.mx6's AUDMUX port. The two
> wm8962 will work independently completely, at the same time possiblly.

I'm not sure if your requirement is to create another dai-link. But
have you tried to simply add a new device node for the new dai-link?

Supposing two WM8962 chips on one board, there should be two WM8962
nodes hanging to the I2C node with different I2C slave addresses.

So you may need two different dai-link nodes for each of the WM8962
i2c nodes as well. And, of course, you need to specify different SSIs
and different AUDMUX ports for two dai-link nodes.

Then you will get two sound card in the system.

Nicolin
