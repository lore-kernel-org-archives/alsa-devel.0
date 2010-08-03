From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM
	ordering problem
Date: Tue, 3 Aug 2010 09:15:12 +0300
Message-ID: <201008030915.37405.peter.ujfalusi@nokia.com>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	<201008021359.11636.peter.ujfalusi@nokia.com>
	<3C7676DA-EAAB-4C56-AD3A-2537EFEDF056@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 492DB2433C
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 08:15:49 +0200 (CEST)
In-Reply-To: <3C7676DA-EAAB-4C56-AD3A-2537EFEDF056@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 03 August 2010 05:56:40 ext Mark Brown wrote:
> > A. When the user configures the capture routing, and starts the capture
> > B. When the user changes the capture routing during active capture
> > (analog to digital, or back).
> =

> It feels like you're focusing in on one specific use case here - there's
> way more active->active transitions that are possible. For example, you
> could switch in bypass or start a second (unrelated) capture stream on
> devices that can support that. I think any change in DAPM needs to be
> motivated in more general terms than you're using here. For
> driver-specific changes this is fine but for changes in the generic code
> we need to think things through more generically.

Sure, I'm pointing these two cases, since I have noticed the problem in the=
se. =

But the same thing happens, when one enables the bypass vs during enabled b=
ypass =

the routing is changed.
We do have different register write sequences, which means that we could ha=
ve =

different type of pop depending on the current sequence.
In startup (playback/capture/bypass) we most likely have pop from component=
s =

powering up, while during active state (and changing the routings) we might=
 need =

to deal with the pop coming from components turning off.
As I said, this might be not an issue at all, but the twl4030 codec used to =

switch two bits with DAPM_MUX (within the enum, and than with POST_REG even=
t). =

Because of the ordering change, in runtime this causes problems, since the =

DAPM_MUX's POST_REG comes as the last thing in the sequence.

The patch against soc-dapm.c is my way of asking about this different seque=
nces =

on startup vs runtime routing change.

I can fix this problem within the twl4030 codec as well (patch 2), which gi=
ves =

me satisfying results, so I'm happy if you ack that.

I only need one of the two patch, and my bet goes for the fix within the tw=
l4030 =

codec driver, but I do wanted to bring up the root cause of this problem =

(surfaced with my codec driver). =



Thanks,
P=E9ter
