From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: mixer device
Date: Tue, 18 May 2004 12:31:39 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405181213330.27420-100000@studcom.urz.uni-halle.de>
References: <1084522933.28725.9.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1084522933.28725.9.camel@shrek.bitfreak.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronald S. Bultje" <R.S.Bultje@students.uu.nl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ronald S. Bultje wrote:
> is it possible for me to get the cardnumber (and thereby the hw:N
> entry) for a given non-hw device (e.g. dspN, hw:N,M, dmix, ...)?

Try something like this:

/* Get the slave pcm of a pcm node.  Caller must free the result. */
static snd_config_t *get_pcm_slave_pcm(snd_config_t *pcm)
{
	snd_config_t *slave;
	snd_config_t *result = NULL;
	int free_slave = 0;
	const char *str;

	if (snd_config_search(pcm, "slave", &slave) < 0)
		goto _exit;
	if (snd_config_get_string(slave, &str) >= 0) {
		if (snd_config_search_definition(snd_config, "pcm_slave", str, &slave) < 0)
			goto _exit;
		free_slave = 1;
	}
	if (snd_config_get_type(slave) != SND_CONFIG_TYPE_COMPOUND)
		goto _exit;

	if (snd_config_search(slave, "pcm", &pcm) < 0)
		goto _exit;
	if (snd_config_get_string(pcm, &str) >= 0) {
		if (snd_config_search_definition(snd_config, "pcm", str, &pcm) >= 0)
			result = pcm;
	} else {
		/* always make a dynamic copy, because the caller frees it */
		if (snd_config_copy(&pcm, pcm) >= 0)
			result = pcm;
	}
_exit:
	if (free_slave)
		snd_config_delete(slave);
	return result;
}

/* Get the card number from a pcm node.  Searches recursively. */
static int get_pcm_card(snd_config_t *pcm)
{
	snd_config_t *slave_pcm;
	snd_config_t *card_node;
	long card;

	if (snd_config_get_type(pcm) != SND_CONFIG_TYPE_COMPOUND)
		return -1;
	slave_pcm = get_pcm_slave_pcm(pcm);
	if (slave_pcm) {
		card = get_pcm_card(slave_pcm);
		snd_config_delete(slave_pcm);
		return card;
	} else if (snd_config_search(pcm, "card", &card_node) >= 0) {
		const char *str;
		if (snd_config_get_integer(card_node, &card) >= 0)
			return card;
		if (snd_config_get_string(card_node, &str) >= 0)
			return snd_card_get_index(str);
	}
	return -1;
}

/* Get the card number from a pcm device name. */
static int get_named_pcm_card(const char *pcm_name)
{
	snd_config_t *pcm;
	int card;

	if (snd_config_update() < 0)
		return -1;

	if (snd_config_search_definition(snd_config, "pcm", pcm_name, &pcm) < 0)
		return -1;
	card = get_pcm_card(pcm);
	snd_config_delete(pcm);
	return card;
}


/* ... */
card = get_named_pcm_card(pcm_name);
if (card >= 0)
	sprintf(ctl_name, "hw:CARD=%d", card);
else
	/* unknown card */


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
