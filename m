From: Mogens Lindholdt Lauridsen <MLN@bang-olufsen.dk>
Subject: Seg. fault when using Salsa 0.0.25
Date: Thu, 5 Nov 2009 11:32:39 +0100
Message-ID: <OFEE21A8C2.FE0362B7-ONC125765F.0031AF64-C1257665.0039E9F7@bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B04D8103930
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 11:32:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

I got an application which uses Salsa 0.0.25. When I quit this 
application, it ends with a seg. fault.

I don't know if this is caused by my application using Salsa wrongly, or a 
problem in Salsa.

However, I got a fix for it.

When my application closes, "hctl_elem_event_handler" is called. And since 
"helem->private_data" is null, this causes a seg. fault:
        snd_mixer_elem_t *elem = helem->private_data;
        snd_mixer_t *mixer = elem->mixer;

It seems like:
        if (!elem)
                return 0;
should have been before:
        snd_mixer_t *mixer = elem->mixer;

An easy way to fix/avoid this is to remove "snd_mixer_t *mixer = 
elem->mixer;" and replace "mixer" with "elem->mixer" in the function. Like 
this:

static int hctl_elem_event_handler(snd_hctl_elem_t *helem,
                                   unsigned int mask)
{
        snd_mixer_elem_t *elem = helem->private_data;
//MLN fix:      snd_mixer_t *mixer = elem->mixer;
        int err;

        if (!elem)
                return 0;

        if (mask == SND_CTL_EVENT_MASK_REMOVE) {
                err = _snd_mixer_elem_throw_event(elem, mask);
                if (err < 0)
                        return err;
                remove_simple_element(helem, 1);
                return 0;
        }
        if (mask & SND_CTL_EVENT_MASK_INFO) {
                remove_simple_element(helem, 0);
                add_simple_element(helem, elem->mixer); // MLN fix: 
"mixer" substituted by "elem->mixer"
                err = snd_mixer_elem_info(elem);
                if (err < 0)
                        return err;
                snd_mixer_sort(elem->mixer);  // MLN fix: "mixer" 
substituted by "elem->mixer"
        }
        if (mask & SND_CTL_EVENT_MASK_VALUE) {
                err = update_simple_element(helem, elem);
                if (err < 0)
                        return err;
                if (err) {
                        err = snd_mixer_elem_value(elem);
                        if (err < 0)
                                return err;
                }
        }
        return 0;
}

Kind regards,
Mogens
