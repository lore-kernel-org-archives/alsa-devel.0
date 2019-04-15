From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 3/3] ALSA: seq: Protect racy pool
 manipulation from OSS sequencer
Date: Mon, 15 Apr 2019 09:37:18 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1904150930580.20954@eliteleevi>
References: <20190412122935.4092-1-tiwai@suse.de>
 <20190412122935.4092-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57D25F896E2
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2019 08:36:01 +0200 (CEST)
In-Reply-To: <20190412122935.4092-4-tiwai@suse.de>
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

Hi Takashi,

On Fri, 12 Apr 2019, Takashi Iwai wrote:

> +/* Unlock and unref the given client; for OSS sequencer use only */
> +void snd_seq_client_ioctl_unlock(int clientid)
> +{
> +	struct snd_seq_client *client;
> +
> +	client = snd_seq_client_use_ptr(clientid);
> +	if (WARN_ON(!client))
> +		return;
> +	mutex_unlock(&client->ioctl_mutex);
> +	snd_use_lock_free(&client->use_lock);
> +	snd_seq_client_unlock(client);

is that double-unlock intentional? snd_seq_client_unlock() seems to call
the same snd_use_lock_free for the same handle as on the previous line.

Br, Kai
