From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 19:45:01 +0100
Message-ID: <20100727184500.GA20277@sirena.org.uk>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
	<1280238546.3085.89.camel@odin>
	<AANLkTikGhu8EVLozlBWmC6Tuu_gHZX_mkTRImsMo91TE@mail.gmail.com>
	<1280251590.3085.112.camel@odin>
	<AANLkTin7zDYdZGdoYXhF9eJovcbaPGy98HRkqeL7tqpC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 56C3D2417E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 20:45:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTin7zDYdZGdoYXhF9eJovcbaPGy98HRkqeL7tqpC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 27, 2010 at 01:20:58PM -0500, Timur Tabi wrote:
> On Tue, Jul 27, 2010 at 12:26 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > I think you are probably a special case here since you are the only
> > person who is dynamically building a DAI link array atm. Everyone else
> > has a static table.

> I thought the whole point behind this "multi-component" stuff was to
> eliminate the need for static tables!

For most systems the major win is that we can have more than one CODEC
(or other register based device) in a single system.  Static tables
really aren't a problem for anyone else, at the end of the day you have
a static table somewhere for the board - it's just that with your device
tree usage you've put that data into the device tree.

The change in the particular static data to provide a layer of
indirection from the actual DAI/CODEC structures is a win for other
people because it helps probe multiple instances of the same CODEC, but
there's still some static data.

> Look at cs4270.c.  The chip has only one digital interface, so I have
> a single DAI structure.  Are you telling me that I need to have two
> DAIs in the CS4270 driver?  Won't that break something else?

Yeah, I think if we can't have the same audio interface in more than one
DAI link we probably have a problem with multi-drop links and with
independant wiring of TX and RX directions.
