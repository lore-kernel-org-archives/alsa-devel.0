From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: SoC scenarii API
Date: Tue, 13 Jan 2009 23:31:27 +0100
Message-ID: <87tz82yh1c.fsf@free.fr>
References: <87iqojqvyq.fsf@free.fr> <20090113155602.GD11651@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 88E071037EC
	for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2009 23:31:35 +0100 (CET)
In-Reply-To: <20090113155602.GD11651@sirena.org.uk> (Mark Brown's message of
	"Tue\, 13 Jan 2009 15\:56\:04 +0000")
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
Cc: alsa-devel@alsa-project.org, lrg@kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Tue, Jan 13, 2009 at 12:36:13PM +0100, Robert Jarzmik wrote:
>
>> As mioa701 submission was stopped due to the need of a generic scenarii API,
>> this a first attempt to design such an API in order to unblock mioa701
>> submission.
>
> You can still carry on submitting the core machine support and then
> patch it to add the scenario stuff later.  That'd probably make review
> slightly easier too since it'd identify the new stuff explicitly.

Mmm ... at the risk of having another hardware incident ... why not ? Let's take
chances and see if another mio overheats.

> In general I'd like to see more exploration of the use cases that this
> is intended to satisfy, including in terms of the mioa701 itself.  The
> documentation should make it clear that this is not intended to be a
> scalable solution and is only intended to be useful for hardware that is
> very limited.  
More comments then ? You know how poor my english is, you'll have to cope with
it, sorry ... I'll add some information at the beginning.

> What are you using for user space - is it one of the standard stacks
> like FSO?  Looking at the features you've got I'm a bit concerned that
No. Userspace is Trolltech's Qtopia over alsa-lib.

> the scenarios may get limiting in future: with both bluetooth and GSM
> things are already pretty complex.  The only thing it's missing compared
> to OpenMoko is WiFi.  For example, with your current scenarios I'm not
> sure if it'd be possible to record a call or do simultaneous record and
> playback?
You're right. That functionnality is not available. That's the price to pay,
somehow.

>  For dealing with overheating I *expect* that you only need to
> have the machine driver prevent particular combinations of outputs being
> simultaneously enabled.
Ah, I feel you're right. The problem is, we don't have the specification, so we
cannot be sure what creates the overheating.

> That said, this looks mostly reasonable as a scenario API.  I assume
> that it creates new controls for the master volume and for selecting the
> scenario?
Yes, namely "SoC Volume" and "SoC Mode".

> The main issues I can see are with how state transitions are
> managed and with how machine drivers interact with this if they need to
> update the configuration at run time.
Ah, the missing pre_scenario() and post_scenario() handlers in snd_soc_scenario
I guess. I thought about these and forgot them. Will these deal with your
concern ?

>
>> struct setup_mixmux {
>> 	char *mixname;		/* Codec Mixer or Muxer name */
>> 	int  val;		/* Codec Mixer or Muxer value to enforce */
>> };
>
> This structure needs namespacing.  Also, "Mux" not "Muxer".
Right, I'll amend that.

>
>> /**
>>  * struct soc_scenario - describes one sound usecase
>
> snd_soc_scenario.
>
>>  * @name: Scenario name, value as will be seen in alsa "SoC Mode" alsa control
>>  * @pin_setup: Pin configuration to perform on scenario activation
>>  *	Table of all pins, as they should be configured. Each elements is a
>>  *	pin_change value, describing how to handle a specific pin.
>>  *      Table size must be the same as in snd_soc_scenario_init().
>
> The table size ought to be specified in only one place.
>
>>  * @mixer_cleanup: Mixers/muxes to set up in phase (b)
>>  *	Table of all mixers/muxes to modify, NULL terminated.
>>  * @mixer_setup: Mixers/muxers to set up in phase (c)
>>  *	Table of all mixers/muxes to modify, NULL terminated
>
> Hrm.  This all feels either too flexible or too inflexible WRT state
> transitions.  If you do need to impose ordering beyond what DAPM can
> figure out for itself then I'd expect to see any number of steps being
> allowed.  If that isn't required then the intermediate step could just
> be dropped.  If there were going to be some sort of "idle" state to
> transition through I'd expect to just see that identified and then the
> switchover to do a state->idle->state transition.
As you wish. mixer_cleanup can be removed, as a state->idle->state will do the
same thing.

> This might also be better with snd_ctl_elem_values so that it can cope
> with any control - there's definitely a need for configuring PGAs
> per-scenario, for example.
Right, I'll amend that.

>  Please also use a number of elements parameter for consistency with the rest
> of the API (both here and ASoC wide).
OK.

>
>> struct soc_scenario {
>> 	const char *name;				/* scenario name */
>> 	const unsigned char pin_setup[];		/* pin_change for pins */
>> 	const struct setup_mixmux mixes_cleanup[];	/* mix cleanup */
>> 	const struct setup_mixmux mixes_setup[];	/* mix setup */
>
> More natural would be pointers to arrays...
Maybe. I was thinking of some macro magic to define each soc_scenario (thus the
const). Let me activate thing a bit about it.
>
>> int snd_soc_scenario_init(struct snd_soc_codec *codec,
>> 			  struct soc_scenario *scenario, int nb_scenarii,
>
> Please make this take a snd_soc_card rather than a snd_soc_codec.  Most
> of the card-wide APIs currently take a codec but this is in the process
> of being fixed.  Also, scenarios is the more usual plural in English.
> For consistency with the rest of the API it'd be nice to use num rather
> than nb.
OK.

> Some of the documentation about the situations where this API should be
> used should go with this function.
>
>> 			  char *pin_names[], int nb_pins);
>
> I'm not sure why the pin names are specified separately here?  Would it
> not be better to just use the pin lists in the scenarios.
There are _no_ pin lists in scenarios. The scenarios only define a transition
for each pin index. The actual pins are initialized once in the init function
(ie. pin_names[0] = "Rear Speaker" for example). Then, in each scenario,
pin_setup[0] will tell what to do to "Rear Speaker" : leave it, activate it or
deactivate it.

>> /**
>>  * snd_soc_scenario_init - initialize soc scenarii
>>  * @codec: codec used for the init
>>  */
>> void snd_soc_scenario_release(struct snd_soc_codec *code);
>
> I sense bitrot :)
Yes ...

I'll send an update soon.

--
Robert
