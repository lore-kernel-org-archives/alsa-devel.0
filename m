From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ALSA: hda - apply CS420X erratum fix for
 CS4207 only
Date: Thu, 3 Mar 2011 18:49:42 +0000
Message-ID: <C9953E43.3D17%brian.austin@cirrus.com>
References: <s5h39n4jnfx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id DD3BF103819
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 19:49:55 +0100 (CET)
In-Reply-To: <s5h39n4jnfx.wl%tiwai@suse.de>
Content-Language: en-US
Content-ID: <B10E524E4896CE498E8333EFE5F349AA@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>
List-Id: alsa-devel@alsa-project.org

So the verb sequence that this refers to needs to be done _before_ the
controls are built.  If the controls are built, then this sequence can
clobber some outputs and inputs.  It's my fault, I didn=B9t put this code in
the correct place. This sequence should go into the beginning of
cs_build_controls() so that it is run before build_output and build_input
are called.

I can make the changes to fix this.

Thanks again for the help
Brian

On 3/3/11 8:20 AM, "Takashi Iwai" <tiwai@suse.de> wrote:

>At Thu, 03 Mar 2011 19:37:52 +0530,
>Arun Raghavan wrote:
>> =

>> On Thu, 2011-03-03 at 14:58 +0100, Takashi Iwai wrote:
>> > At Thu, 03 Mar 2011 17:50:22 +0530,
>> > Arun Raghavan wrote:
>> > > =

>> > > On Thu, 2011-03-03 at 13:01 +0100, Takashi Iwai wrote:
>> > > > At Thu,  3 Mar 2011 03:18:18 +0530,
>> > > > Arun Raghavan wrote:
>> > > > > =

>> > > > > From: Arun Raghavan <arun@accosted.net>
>> > > > > =

>> > > > > The commit a769cbcf60cee51f4431c0938acd39e7e5b76b8d
>> > > > >     ALSA: hda - Add errata initverb sequence for CS42xx codecs
>> > > > > applies a fix for a chip erratum that is specific to CS4207
>> > > > > unconditionally. On CS4206, this causes digital output to never
>>be
>> > > > > activated.
>> > > > =

>> > > > It might be the power-state the verb table sets?
>> > > > Try to comment out only the line setting SPDIF Tx to D3,
>> > > >   {0x08, AC_VERB_SET_POWER_STATE, 0x03}
>> > > > instead of disabling the whole verbs, just for testing.
>> > > =

>> > > Indeed, this also works.
>> > =

>> > OK, to be sure, try the patch below.
>> =

>> Yep, works just fine.
>
>Thanks for checking.  Merged now to sound git tree.
>
>
>Takashi
>
