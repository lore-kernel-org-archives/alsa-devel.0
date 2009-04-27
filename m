From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 10:02:47 -0400
Message-ID: <9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
	<9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
	<20090427092514.GB1760@sirena.org.uk>
	<9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 31B0F24574
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 16:02:49 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so1503718rvb.32
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 07:02:48 -0700 (PDT)
In-Reply-To: <20090427135737.GA20591@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 9:57 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Apr 27, 2009 at 09:50:01AM -0400, Jon Smirl wrote:
>> On Mon, Apr 27, 2009 at 5:25 AM, Mark Brown <broonie@sirena.org.uk> wrot=
e:
>
>> > Does that patch need merging for 2.6.30 (you said I2S was broken)?
>
>> Grant and I are the only two active users of I2S and we're passing
>> patches to each other. =A0I don't have I2S completely fixed yet.
>
>> I'll post a series today that reorgs things to make my real patches
>
> If you're reorganising the code that's not really suitable for 2.6.30.
>
>> My real patches fix up i2s and implement ac97.
>
> It sounds like we need fixed I2S for 2.6.30 and then a 2.6.31 series
> which does the reorganising and addition of AC97 support.

The fixes have been implemented on top of the reorganized code.  It is
hard to review the fixes right now because no one has the reorganized
base.

Is there really a problem with sending the reorg in now? There are
only two users of the code and we have both ack'd it.

>



-- =

Jon Smirl
jonsmirl@gmail.com
