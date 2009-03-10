From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed missing
	McBSP pinmux for SFFSDR
Date: Tue, 10 Mar 2009 08:55:06 -0700
Message-ID: <87hc21tlt1.fsf@deeprootsystems.com>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<1236655929-31688-5-git-send-email-hugo@hugovil.com>
	<20090310102921.GA12297@sirena.org.uk>
	<20090310100341.cc08cc08.hugo@hugovil.com>
	<20090310151615.GB12297@sirena.org.uk>
	<20090310114211.4ad49269.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 95DA31037FC
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 16:55:11 +0100 (CET)
Received: by rv-out-0506.google.com with SMTP id f9so2275228rvb.0
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 08:55:10 -0700 (PDT)
In-Reply-To: <20090310114211.4ad49269.hugo@hugovil.com> (Hugo Villeneuve's
	message of "Tue\, 10 Mar 2009 11\:42\:11 -0400")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hugo Villeneuve <hugo@hugovil.com> writes:

> On Tue, 10 Mar 2009 15:16:32 +0000
> Mark Brown <broonie@sirena.org.uk> wrote:
>
>> On Tue, Mar 10, 2009 at 10:03:41AM -0400, Hugo Villeneuve wrote:
>> 
>> > I based those patches on the latest linux-davinci git tree, which
>> > has the function.
>> 
>> Do not submit patches for mainline which are not based on mainline
>> trees.  Code which relies on out of tree changes needs to wait for
>> those out of tree changes to be merged before submitting to mainline.
>
> I did not know that these changes were not in mainline yet. I was told
> that all davinci ASoC code changes were to be submitted only to ALSA,
> and then were imported back into the davinci git tree. Apparently this
> is not quite like that anymore.
>
> Kevin, what is the new rule to submit davinci ASoC patches?
>

The DaVinci ASoC code is indeed in mainline, but not all of the
DaVinci core (in this case the pin mux) is yet in mainline.  I will be
pushing it during the next merge window.

On a related note, sound/soc/davinci/davinci-[evm,sffsdr].c is
actually board-level setup code and should not actually live in
sound/asoc/.  It should live in arch/arm/mach-davinci/* and follow the
rest of the davinci chip/board code upstream.

Kevin
