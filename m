From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: support for jackSense feature in modern sound cards
Date: Sun, 10 Feb 2008 21:55:20 +0000
Message-ID: <20080210215519.GC32198@sirena.org.uk>
References: <200802110103.37082.balajirrao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 81D36103893
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 22:55:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802110103.37082.balajirrao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Balaji Rao <balajirrao@gmail.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 11, 2008 at 01:03:37AM +0530, Balaji Rao wrote:

> How well is the jack sense feature in modern soundcards supported in the 
> kernel ? I opened up a few driver sources like hda-intel and found the 
> word 'jack sense' in some files, but i could not find it being used anywhere.

FWIW this feature is frequently called "jack detect" or "headphone
detect".  I have actually been looking at this, mostly within the
context of ASoC although obviously this all applies to ALSA core too.
There is some in-kernel support for it at present, though some of those
don't expose anything to user space and do fixed things to the hardware
when there is a headphone detect event.

There is also an existing user space API for communicating events to
user space via the input subsystem - this is in use by some of the
Zaurus systems.  Jacks are represented as switch events of type
SW_HEADPHONE_INSERT.  User space can listen for these events and can
then adjust the system configuration as appropriate.

My plan for supporting this in ALSA had been to add helpers to assist in
the creation of input devices representing the jacks along with new
switch types to allow systems that can detect the type of device plugged
into a jack to represent this to user space (eg, SW_SPEAKER_INSERT).
The helpers would parent the input device off the sound card device and
provide a name for the jack to user space.  My intention is to post some
code once I've got sound working on the Zylonite (since that has jack
detect support and would allow me to show working code).

> Are there standard interfaces in kmix or equivalent software that use the jack 
> sense feature ? If not, wouldn't it be nice to have a standard interface to 
> expose this feature so that kmix and others could make use of in a device 
> independent way ?

The existing user space API does seem reasonable to me - logically, a
headphone jack does correspond to a switch and applications that respond
to jack insert events are likely to also want to pay attention to other
input events such as the mute and volume control keys often found on
keyboards.

For embedded uses the expectation was that this would be used in
conjunction with the ALSA scenario management API which my colleague
Liam Girdwood is currently developing:

	http://opensource.wolfsonmicro.com/node/14

This may or may not be appropriate for desktop systems, I am less
familiar with the issues there.
