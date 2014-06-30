From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-utils 5/5] The amidicat program
 itself, better late than never
Date: Mon, 30 Jun 2014 13:33:00 +0200
Message-ID: <53B14AEC.40205@ladisch.de>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-6-git-send-email-alsa@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
 [80.67.31.100]) by alsa0.perex.cz (Postfix) with ESMTP id E2B3A265119
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 13:33:04 +0200 (CEST)
In-Reply-To: <1404118503-22921-6-git-send-email-alsa@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Josh Lehan <alsa@krellan.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Josh Lehan wrote:
> +++ b/amidicat/amidicat.c
> +#define MAX_HEX_DIGITS		(2)

Is this symbol defined for future compatibility with larger bytes?  ;-)

> +	int		is_hex;

For booleans, use "bool" from <stdbool.h>.

> +prettyprint_capmask(unsigned int capmask)
> +{
> +	/* The r/w letters indicate read/write capability */
> +	/* Capital R/W letters indicate subscription */

Would anybody understand the difference?

Just restrict the listing to ports that you can handle.

> +			port_name = strdup(
> +				snd_seq_port_info_get_name(port_info));

Please note that checkpatch is just a tool to find problems; introducing
new problems like this just to shut it up is counterproductive.

(Overlong lines could be a sign that the nesting is too deep, but the
ALSA function names do not help ...)

> +str_to_cli_port(snd_seq_t *handle, char *str, int *outcli, int *outport)

Why not use snd_seq_parse_address()?

> +	r = snd_seq_set_client_name(handle, cli_name);
> +	if (r < 0) {
> +		/* This early in the program, it's not threaded,
> +		 * errno is OK to use */
> +		fprintf(stderr, "Unable to set ALSA client name: %s\n",
> +			strerror(errno));

The error code is in r.  Use snd_strerror().

(And errno _is_ thread safe.)

> +	/* FUTURE: Do we need any more type bits here? */
> +	port_id = snd_seq_create_simple_port(handle, cli_name, caps,
> +		SND_SEQ_PORT_TYPE_MIDI_GENERIC);

You should set all appropriate TYPE bits.  You must set CAP bits if you
want to allow others to connect from/to this port.

> +		r = snd_seq_event_output_direct(handle, ev);
> +		if (r < 0) {
> +			/* Return if a real error happened */
> +			if (-EAGAIN != r)

EAGAIN can never happen if the device has not been configured to be
non-blocking.

> +		r = snd_seq_drain_output(handle);

snd_seq_event_output_direct() bypasses the output buffer, so this does
not make sense.

> +		r = snd_seq_sync_output_queue(handle);

You have not scheduled any events to be delivered later, so this does
not make sense.

> +		/* FUTURE: Why does snd_seq_sync_output_queue()
> +		 * always return 1, not 0 as it should? */

Because the documentation is wrong.

> +			r = printf("%02X%s", ui,
> +				((size_left > 1) ? " " : "\n"));

Why not use %c?

> +		/* Standard C whitespace */
> +		/* Avoid usage of isspace()
> +		 * because that would introduce locale variations */

Where does this program change the locale to be different from "C"?
(And what would it matter if a Klingon space were to be ignored? :-)

> +		/* Send a dummy message to ourself,
> +		 * so ALSA gets unblocked in other thread */
> +		snd_seq_ev_clear(&ev);

This results in a SND_SEQ_EVENT_SYSTEM event.  You might want to use
one of the USR events ...

> +		/* Check global flag, under lock,
> +		 * see if other thread is telling us to exit */
> +		pthread_mutex_lock(&g_mutex);
> +		is_endinput = g_is_endinput;
> +		pthread_mutex_unlock(&g_mutex);

... and if you check for that event (and its source address) here, you
don't need a separate mutex.

> +	/* Apologies for the awkward line breaks,
> +	 * the mandate of the checkpatch script left no alternative */

checkpatch looks for printk().  Ignore it.

> +	pthread_cond_init(&g_cond, NULL);

This is not used.


Regards,
Clemens
