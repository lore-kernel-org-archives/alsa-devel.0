From: Tapio Vihuri <tapio.vihuri@nokia.com>
Subject: Re: [PATCH v4 1/3] ECI: input: introduce ECI accessory
	input driver
Date: Thu, 20 Jan 2011 09:57:28 +0200
Message-ID: <1295510248.26257.7.camel@dell>
References: <1295438816-27937-1-git-send-email-tapio.vihuri@nokia.com>
	<1295438816-27937-2-git-send-email-tapio.vihuri@nokia.com>
	<20110119174412.GB29107@core.coreip.homeip.net>
Reply-To: tapio.vihuri@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id CD424103A27
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 08:57:47 +0100 (CET)
In-Reply-To: <20110119174412.GB29107@core.coreip.homeip.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: randy.dunlap@oracle.com, alsa-devel@alsa-project.org, samu.p.onkalo@nokia.com, peter.ujfalusi@nokia.com, linux-kernel@vger.kernel.org, ilkka.koskinen@nokia.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-19 at 09:44 -0800, ext Dmitry Torokhov wrote:
> Hi Tapio,
> 
> On Wed, Jan 19, 2011 at 02:06:54PM +0200, tapio.vihuri@nokia.com wrote:
> > +
> > +	for (; key->type != KE_END; key++) {
> > +		switch (key->type) {
> > +		case KE_KEY:
> > +			__set_bit(key->keycode, eci->acc_input->keybit);
> > +			break;
> > +		case KE_SW:
> > +		case KE_VSW:
> > +			__set_bit(key->keycode, eci->acc_input->swbit);
> > +			break;
> > +		}
> > +	}
> > +
> 
> Is this still needed? I believe sparse_keymap_setup() below shoudl take
> care of this...
> 
> > +	__set_bit(EV_KEY, eci->acc_input->evbit);
> > +	__set_bit(EV_SW, eci->acc_input->evbit);
> > +	__set_bit(EV_REP, eci->acc_input->evbit);
> > +
> > +	err = sparse_keymap_setup(eci->acc_input, eci_keymap, NULL);
> > +	if (err)
> > +		goto err_free_dev;
> > +
> 

Hi Dmitry.

Thanks for pointing this out, as we have sparse keymap, we should use
it :)

How about KE_VSW case ? Shouldn't it be in the sparse_keymap_setup {}
also ?

---------8<------------------------

int sparse_keymap_setup(struct input_dev *dev,
                        const struct key_entry *keymap,
                        int (*setup)(struct input_dev *, struct
key_entry *))
{
        size_t map_size = 1; /* to account for the last KE_END entry */
        const struct key_entry *e;
        struct key_entry *map, *entry;
        int i;
        int error;

        for (e = keymap; e->type != KE_END; e++)
                map_size++;

        map = kcalloc(map_size, sizeof (struct key_entry), GFP_KERNEL);
        if (!map)
                return -ENOMEM;

        memcpy(map, keymap, map_size * sizeof (struct key_entry));

        for (i = 0; i < map_size; i++) {
                entry = &map[i];

                if (setup) {
                        error = setup(dev, entry);
                        if (error)
                                goto err_out;
                }

                switch (entry->type) {
                case KE_KEY:
                        __set_bit(EV_KEY, dev->evbit);
                        __set_bit(entry->keycode, dev->keybit);
                        break;

                case KE_SW:
                        __set_bit(EV_SW, dev->evbit);
                        __set_bit(entry->sw.code, dev->swbit);
                        break;
                }
        }

        dev->keycode = map;
        dev->keycodemax = map_size;
        dev->getkeycode_new = sparse_keymap_getkeycode;
        dev->setkeycode_new = sparse_keymap_setkeycode;

        return 0;

 err_out:
        kfree(map);
        return error;
}



BR,
Tapsa

-- 
Tapsa
050 4876788
