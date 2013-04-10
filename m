From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC snd_soc_dai_ops for clock mux control
Date: Wed, 10 Apr 2013 14:16:26 +0100
Message-ID: <20130410131625.GA27050@sirena.org.uk>
References: <8F928A9825EEF0458AC402C3ABF8BEB1053E0DEF@HI2EXCH01.adit-jv.com>
 <515D15B9.8080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B598265F7D
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 15:16:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <515D15B9.8080608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gellner,
 Christoph (ADITG/SW1)" <cgellner@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 03, 2013 at 10:55:05PM -0700, Gabriel M. Beddingfield wrote:

> If so, there's a couple options I can think of.  (A) You could call
> a codec-specific API in your machine driver that expresses this
> intent. (B) you could create "virtual" clock ID's that express the
> mapping (e.g. FLL1_TX, FLL1_RX, FLL2_TX, FLL2_RX).  I think (A) is a
> cleaner solution that clearly communicates what is happening.

Or just extend snd_soc_dai_set_sysclk() to have an extra paremeter for
source like we did with snd_soc_dai_set_pll() (for pretty much the same
reason).
