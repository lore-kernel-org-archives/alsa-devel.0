From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Newbie help with WM8962 and tinyalsa
Date: Wed, 19 Dec 2012 10:43:26 +0000
Message-ID: <20121219104326.GA23450@sirena.org.uk>
References: <1355341592.61998.YahooMailNeo@web142406.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E3AA5264F0F
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 11:43:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1355341592.61998.YahooMailNeo@web142406.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randi Eckstein <randdeck@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 12, 2012 at 11:46:32AM -0800, Randi Eckstein wrote:

> If anyone has an explanation on how to use tinymix to play on a
> wm8962, I'd really appreciate it.

tinymix doesn't do playback, you want to use tinyplay.  There's nothing
special about wm8962 from a playback point of view, it should just work
as part of the sound card like any other CODEC.
