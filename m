From: Josh Lehan <alsa@krellan.com>
Subject: Re: [PATCH - alsa-utils 5/5] The amidicat program
 itself, better late than never
Date: Tue, 01 Jul 2014 01:10:27 -0700
Message-ID: <53B26CF3.5040606@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-6-git-send-email-alsa@krellan.com>
 <53B14AEC.40205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www7.pairlite.com (www7.pairlite.com [64.130.10.17])
 by alsa0.perex.cz (Postfix) with ESMTP id C7604264F03
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 10:10:29 +0200 (CEST)
In-Reply-To: <53B14AEC.40205@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/30/2014 04:33 AM, Clemens Ladisch wrote:
> Josh Lehan wrote:
>> +++ b/amidicat/amidicat.c
>> +#define MAX_HEX_DIGITS		(2)
> 
> Is this symbol defined for future compatibility with larger bytes?  ;-)

No, it's just to avoid a magic number in the parser later on, makes it
somewhat easier to read.

>> +	int		is_hex;
> 
> For booleans, use "bool" from <stdbool.h>.

Good suggestion.

>> +prettyprint_capmask(unsigned int capmask)
>> +{
>> +	/* The r/w letters indicate read/write capability */
>> +	/* Capital R/W letters indicate subscription */
> 
> Would anybody understand the difference?
> 
> Just restrict the listing to ports that you can handle.

I wanted to give a complete listing, because it's useful for diagnostics
and troubleshooting.  It can handle both direct and subscription
connections.

It's surprising how different the various permissions are, for the
default devices on my system, and so it's useful to see this.

>> +			port_name = strdup(
>> +				snd_seq_port_info_get_name(port_info));
> 
> Please note that checkpatch is just a tool to find problems; introducing
> new problems like this just to shut it up is counterproductive.

Didn't think this was a problem, to copy this string locally.  It's
correctly freed later.

>> +str_to_cli_port(snd_seq_t *handle, char *str, int *outcli, int *outport)
> 
> Why not use snd_seq_parse_address()?

Nice, missed that function!  Will do.  Was looking for some helpful
utility function like that.

>> +	r = snd_seq_set_client_name(handle, cli_name);
>> +	if (r < 0) {
>> +		/* This early in the program, it's not threaded,
>> +		 * errno is OK to use */
>> +		fprintf(stderr, "Unable to set ALSA client name: %s\n",
>> +			strerror(errno));
> 
> The error code is in r.  Use snd_strerror().

Good suggestion, thanks.

>> +	/* FUTURE: Do we need any more type bits here? */
>> +	port_id = snd_seq_create_simple_port(handle, cli_name, caps,
>> +		SND_SEQ_PORT_TYPE_MIDI_GENERIC);
> 
> You should set all appropriate TYPE bits.  You must set CAP bits if you
> want to allow others to connect from/to this port.

I think I'm setting the appropriate CAP bits (including DUPLEX if both
read and write are enabled).

As for the TYPE bits, that is a point of confusion for me.  What would a
program like this be classified as?  Probably need to add at least
SND_SEQ_PORT_TYPE_SOFTWARE.  Are the TYPE bits used for any
decision-making within the ALSA sequencer, or are they merely
informational for users to see?

>> +		r = snd_seq_event_output_direct(handle, ev);
>> +		if (r < 0) {
>> +			/* Return if a real error happened */
>> +			if (-EAGAIN != r)
> 
> EAGAIN can never happen if the device has not been configured to be
> non-blocking.

I actually see EAGAIN quite commonly under high load.  This one-liner
demonstrates it, there's a high number of "output retries" seen, and the
counter for this comes from here.

cat /dev/urandom | ./amidicat --port "Midi Through" --verbose > /dev/null

>> +		r = snd_seq_drain_output(handle);
> 
> snd_seq_event_output_direct() bypasses the output buffer, so this does
> not make sense.
> 
>> +		r = snd_seq_sync_output_queue(handle);
> 
> You have not scheduled any events to be delivered later, so this does
> not make sense.

Interesting, perhaps I can remove this section entirely and it will
still work!

>> +		/* FUTURE: Why does snd_seq_sync_output_queue()
>> +		 * always return 1, not 0 as it should? */
> 
> Because the documentation is wrong.

Yikes!

>> +			r = printf("%02X%s", ui,
>> +				((size_left > 1) ? " " : "\n"));
> 
> Why not use %c?

I didn't want to print the byte as a raw byte here, but as a
human-readable hex number.  In the mode where raw bytes are output,
write() is used instead, not printf().

>> +		/* Standard C whitespace */
>> +		/* Avoid usage of isspace()
>> +		 * because that would introduce locale variations */
> 
> Where does this program change the locale to be different from "C"?
> (And what would it matter if a Klingon space were to be ignored? :-)

It doesn't change the locale.  I wanted it to run the same no matter
what locale the user had set, however.  Nothing else in the program
depends on locale, and I didn't want to bring that in just for this.

>> +		/* Send a dummy message to ourself,
>> +		 * so ALSA gets unblocked in other thread */
>> +		snd_seq_ev_clear(&ev);
> 
> This results in a SND_SEQ_EVENT_SYSTEM event.  You might want to use
> one of the USR events ...

Good suggestion.

>> +		/* Check global flag, under lock,
>> +		 * see if other thread is telling us to exit */
>> +		pthread_mutex_lock(&g_mutex);
>> +		is_endinput = g_is_endinput;
>> +		pthread_mutex_unlock(&g_mutex);
> 
> ... and if you check for that event (and its source address) here, you
> don't need a separate mutex.

Thanks, but it seems easier/cleaner just to check the global under a
mutex here, as I get the same result with much less code.

>> +	/* Apologies for the awkward line breaks,
>> +	 * the mandate of the checkpatch script left no alternative */
> 
> checkpatch looks for printk().  Ignore it.

This is userspace code, can't use printk().

I learned that I'm granted an indulgence from checkpatch, if the
offending long line contains only a string literal (and optional leading
whitespace).

>> +	pthread_cond_init(&g_cond, NULL);
> 
> This is not used.

Good catch!  It was a leftover from an earlier draft.

> Regards,
> Clemens

Thanks for reviewing.  Other than these points above, what do you think
of the program?  Did you try running it?  I'll submit a revised patch soon.

Josh
