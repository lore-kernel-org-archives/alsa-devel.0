From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: ALSA: tons of false positives because of
	snd_ctl_find_id()
Date: Fri, 2 Feb 2018 11:29:03 +0300
Message-ID: <20180202082903.GA11023@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DB71266EEB
 for <alsa-devel@alsa-project.org>; Fri,  2 Feb 2018 09:29:19 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Iwai,

The patch 72cbfd45fac6: "ALSA: ice1724 - Add ESI Maya44 support" from
May 6, 2009, leads to the following static checker warning:

	sound/pci/ice1712/maya44.c:204 maya_vol_put()
	error: buffer overflow 'chip->wm' 2 <= u32max.

sound/pci/ice1712/maya44.c
   199  static int maya_vol_put(struct snd_kcontrol *kcontrol,
   200                          struct snd_ctl_elem_value *ucontrol)
   201  {
   202          struct snd_maya44 *chip = snd_kcontrol_chip(kcontrol);
   203          struct snd_wm8776 *wm =
   204                  &chip->wm[snd_ctl_get_ioff(kcontrol, &ucontrol->id)];
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is a false positive obviously, but this code is crazy hard for
static analysis to parse.

snd_ctl_find_id() in sound/core/control.c
   682  /**
   683   * snd_ctl_find_id - find the control instance with the given id
   684   * @card: the card instance
   685   * @id: the id to search
   686   *
   687   * Finds the control instance with the given id from the card.
   688   *
   689   * The caller must down card->controls_rwsem before calling this function
   690   * (if the race condition can happen).
   691   *
   692   * Return: The pointer of the instance if found, or %NULL if not.
   693   *
   694   */
   695  struct snd_kcontrol *snd_ctl_find_id(struct snd_card *card,
   696                                       struct snd_ctl_elem_id *id)
   697  {
   698          struct snd_kcontrol *kctl;
   699  
   700          if (snd_BUG_ON(!card || !id))
   701                  return NULL;
   702          if (id->numid != 0)
   703                  return snd_ctl_find_numid(card, id->numid);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

On this path, we don't check id->index.  Which is fine because we don't
use it.  It would really make my life simpler if we could set the
unchecked fields to zero.  How Smatch works is that we merge all the
success paths together so it would either be zero or checked which is
easy to deal with.  In the current code it's either checked or
unchecked which is just unchecked when you merge the success paths
together.

I can probably figure out other ways to deal with this if that's not a
good idea.

   704          list_for_each_entry(kctl, &card->controls, list) {
   705                  if (kctl->id.iface != id->iface)
   706                          continue;
   707                  if (kctl->id.device != id->device)
   708                          continue;
   709                  if (kctl->id.subdevice != id->subdevice)
   710                          continue;
   711                  if (strncmp(kctl->id.name, id->name, sizeof(kctl->id.name)))
   712                          continue;
   713                  if (kctl->id.index > id->index)
   714                          continue;
   715                  if (kctl->id.index + kctl->count <= id->index)
   716                          continue;
   717                  return kctl;
   718          }
   719          return NULL;
   720  }
   721  EXPORT_SYMBOL(snd_ctl_find_id);

regards,
dan carpenter
