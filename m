From: Alan Young <Alan.Young@IEE.org>
Subject: Re: [PATCH] [updated] pcm: rate: Add capability to
 pass configuration node to plugins
Date: Tue, 21 Feb 2017 15:24:06 +0000
Message-ID: <a81fa08e-07e7-7178-d7e3-b69d24a31c0b@IEE.org>
References: <bdb7665c-5747-8888-fa2e-552e852fa375@IEE.org>
 <6d7c74b7-da90-5ae9-c355-c6884b2edf09@gmail.com>
 <s5hy3xg8zkp.wl-tiwai@suse.de>
 <e1ebb06d-6f43-fde8-7b9e-653d247a4a19@gmail.com>
 <s5h4lzxxn9c.wl-tiwai@suse.de>
 <a15b8e68-a9b5-2ed2-29b2-a0ab5b997d7e@gmail.com>
 <a66a494e-3bd6-c813-6786-ca9deceabdc0@IEE.org> <s5hwpcosqrp.wl-tiwai@suse.de>
 <7b3c655f-4b7a-e10a-90ff-5cb480332f3f@IEE.org> <s5hefywsnoz.wl-tiwai@suse.de>
 <da34dc72-db60-d707-4747-1601123e7f81@IEE.org> <s5hr32r67l4.wl-tiwai@suse.de>
 <3b8cd9c9-8248-b22a-ebb8-dce7d901951d@IEE.org> <s5hbmtv61uq.wl-tiwai@suse.de>
 <2cb132c7-638b-6d93-621d-3460654660b8@IEE.org> <s5h7f4j60fm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CD232666EA
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 16:24:08 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id 196so29757611wmm.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 07:24:08 -0800 (PST)
In-Reply-To: <s5h7f4j60fm.wl-tiwai@suse.de>
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

On 21/02/17 15:14, Takashi Iwai wrote:
> On Tue, 21 Feb 2017 16:04:54 +0100,
> Alan Young wrote:
>> +	else if (snd_config_get_type(converter) == SND_CONFIG_TYPE_COMPOUND) {
>> +		snd_config_iterator_t i, next;
>> +		snd_config_for_each(i, next, converter) {
>> +			snd_config_t *n = snd_config_iterator_entry(i);
>> +			const char *id;
>> +			snd_config_get_id(n, &id);
>> +			if (strcmp(id, "name") != 0)
>> +				continue;
>> +			snd_config_get_string(n, &type);
>> +			break;
>> +		}
>> +		if (!type) {
>> +			SNDERR("No name given for rate converter");
>> +			return -EINVAL;
> Resource leaks.
>
>
Can you expand on that a little please? What leaks?
