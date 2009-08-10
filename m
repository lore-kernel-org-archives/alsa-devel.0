From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 08:46:59 -0400
Message-ID: <9e4733910908100546r5fa2e189s12ff72c3217c271a@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
	<4A7FCF0A.1000806@ladisch.de>
	<9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>
	<4A800B47.6020201@ladisch.de>
	<9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>
	<4A8012B4.5000009@ladisch.de>
	<9e4733910908100541y495f491cy7a25351a8c36f3dd@mail.gmail.com>
	<20090810124350.GB24947@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 38604103873
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 14:47:00 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c37so957014anc.2
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2009 05:46:59 -0700 (PDT)
In-Reply-To: <20090810124350.GB24947@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2009 at 8:43 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Aug 10, 2009 at 08:41:20AM -0400, Jon Smirl wrote:
>> On Mon, Aug 10, 2009 at 8:29 AM, Clemens Ladisch<clemens@ladisch.de> wro=
te:
>
>> > Linked substreams are handled by ALSA's kernel part with a loop inside
>> > a spinlock.
>
>> Linking via =A0snd_soc_dai_link or is there another way to link?
>
> That's completely unrelated - each link there just defines a CODEC<->CPU
> connection.
>

Does this link them?
snd_pcm_set_sync(substream); in open()

and then remove this loop in trigger?
snd_pcm_group_for_each_entry(substream, sub) {
			snd_pcm_trigger_done(substream, sub);




-- =

Jon Smirl
jonsmirl@gmail.com
