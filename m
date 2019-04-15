From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 3/3] ALSA: seq: Protect racy pool
 manipulation from OSS sequencer
Date: Mon, 15 Apr 2019 11:52:01 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1904151143030.20954@eliteleevi>
References: <20190412122935.4092-1-tiwai@suse.de>
 <20190412122935.4092-4-tiwai@suse.de>
 <alpine.DEB.2.21.1904150930580.20954@eliteleevi>
 <s5hsgujkbpu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 074AAF80CAB
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2019 10:50:43 +0200 (CEST)
In-Reply-To: <s5hsgujkbpu.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 15 Apr 2019, Takashi Iwai wrote:

> > > +void snd_seq_client_ioctl_unlock(int clientid)
> > > +{
> > > +	struct snd_seq_client *client;
> > > +
> > > +	client = snd_seq_client_use_ptr(clientid);
> > > +	if (WARN_ON(!client))
> > > +		return;
> > > +	mutex_unlock(&client->ioctl_mutex);
> > > +	snd_use_lock_free(&client->use_lock);
> > > +	snd_seq_client_unlock(client);
> > 
> > is that double-unlock intentional? snd_seq_client_unlock() seems to call
> > the same snd_use_lock_free for the same handle as on the previous line.
> 
> Yes, it's intentional.  The trick is snd_seq_client_ioctl_lock()
> doesn't call snd_seq_client_unlock(), i.e. keeps refcount up.  This
> is, in turn, released in snd_seq_client_ioctl_unlock().
> snd_seq_client_ioctl_unlock() gets its refcount at use_ptr(), hence
> this releases twice.  Maybe it's worth for more comments.

ah yes, ok thanks, just checking. :) I was misled by the asymmetric 
names. As you are taking the refcount with two client_use_ptr() calls in 
both lock and unlock, would it be more logical to have two 
snd_seq_client_unlock() calls in unlock?

Otherwise patchset looks good!
