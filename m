From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH] [updated] pcm: rate: Add capability to
 pass configuration node to plugins
Date: Tue, 21 Feb 2017 12:02:49 +0000
Message-ID: <da34dc72-db60-d707-4747-1601123e7f81@IEE.org>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
 <e1ebb06d-6f43-fde8-7b9e-653d247a4a19@gmail.com>
 <s5h4lzxxn9c.wl-tiwai@suse.de>
 <a15b8e68-a9b5-2ed2-29b2-a0ab5b997d7e@gmail.com>
 <a66a494e-3bd6-c813-6786-ca9deceabdc0@IEE.org> <s5hwpcosqrp.wl-tiwai@suse.de>
 <7b3c655f-4b7a-e10a-90ff-5cb480332f3f@IEE.org> <s5hefywsnoz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E202666EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 13:02:51 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id c85so108286660wmi.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 04:02:51 -0800 (PST)
In-Reply-To: <s5hefywsnoz.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 17/02/17 17:59, Takashi Iwai wrote:
> It becomes too complex by mixing up things in a single loop.
> Let's take it just simple like:
>
> 	if (is_string_array(converter)) {
> 		snd_config_for_each(i, next, converter) {
> 			// like the old way
> 		}
> 	} else {
> 		// handle for the new compound type
> 	}


Like this?

	else if (snd_config_get_type(converter) == SND_CONFIG_TYPE_COMPOUND) {
		/*
		 * If the convertor compound is an array of alternatives then the id of
		 * the first element will be "0" (or maybe NULL). Otherwise assume it is
		 * a structure and must have a "name" id to identify the converter type.
		 */
		snd_config_iterator_t i, next;
		i = snd_config_iterator_first(converter);
		if (i && i != snd_config_iterator_end(converter)) {
			snd_config_t *n = snd_config_iterator_entry(i);
			const char *id;
			snd_config_get_id(n, &id);
			if (!id || strcmp(id, "0") == 0) {
				snd_config_for_each(i, next, converter) {
					n = snd_config_iterator_entry(i);
					if (snd_config_get_string(n, &type) < 0)
						break;
					err = rate_open_func(rate, type, NULL, 0);
					if (!err)
						break;
				}

			} else {
				snd_config_for_each(i, next, converter) {
					snd_config_t *n = snd_config_iterator_entry(i);
					const char *id;
					snd_config_get_id(n, &id);
					if (strcmp(id, "name") != 0)
						continue;
					if (snd_config_get_string(n, &type) < 0)
						break;
					err = rate_open_func(rate, type, converter, 0);
					if (!err)
						break;
				}
			}
		}
