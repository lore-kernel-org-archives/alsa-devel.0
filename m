From: James Cameron <quozl@laptop.org>
Subject: Re: I sent hardware informations with the script about
 a MEDION laptop with Intel devices
Date: Mon, 3 Jul 2017 19:46:53 +1000
Message-ID: <20170703094653.GC12700@us.netrek.org>
References: <CALmBKtk6TnY4rB2jj+NSc-8wo1cnNh4Qr2W0o8Yvw-rFPUmqog@mail.gmail.com>
 <CALmBKtmcqqw1A_5zM6g+LPJJOKRcMNG+oOkhiqQZUX4tDPzTJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swan.laptop.org (swan.laptop.org [18.85.44.157])
 by alsa0.perex.cz (Postfix) with ESMTP id B137C266884
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 11:47:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALmBKtmcqqw1A_5zM6g+LPJJOKRcMNG+oOkhiqQZUX4tDPzTJQ@mail.gmail.com>
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
Cc: fulgor fulgor <l.vanwinnendaele@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 03, 2017 at 11:21:09AM +0200, fulgor fulgor wrote:
> Is there any news about a module for this laptop ?

Please use better subject line, and at least link to your previous
message.

http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/121766.html

A recent patch "ASoC: rt5645: Add quirk override by module option" and
those immediately prior by the same author on the same driver fixed my
problems with a similar laptop.  Needed experimentation with
snd_soc_rt5645.quirks value and boot command line changes.

Please, don't reply directly to me in future.  It's not my job to fix
your laptop.

-- 
James Cameron
http://quozl.netrek.org/
