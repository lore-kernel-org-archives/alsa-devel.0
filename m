From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [alsa-devel] [RFC PATCH v2] ASoC: dpcm: prevent snd_soc_dpcm
 use after free
Date: Wed, 6 Mar 2019 23:09:42 +0800
Message-ID: <1551884982.4300.7.camel@mtksdaap41>
References: <1551861979-26601-1-git-send-email-kaichieh.chuang@mediatek.com>
 <0c9de818-80b4-d172-422d-a96b47aa7f1e@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <0c9de818-80b4-d172-422d-a96b47aa7f1e-/Fr2/VpizcU@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, hochi.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, michael.hsiao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-03-06 at 10:19 +0100, Jaroslav Kysela wrote:
> Dne 06. 03. 19 v 9:46 KaiChieh Chuang napsal(a):
> > the dpcm get from fe_clients/be_clients
> > may be free before use
> > 

> > @@ -1294,9 +1294,11 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
> >  #ifdef CONFIG_DEBUG_FS
> >  		debugfs_remove(dpcm->debugfs_state);
> >  #endif
> > +		spin_lock(&fe->card->dpcm_lock);
> >  		list_del(&dpcm->list_be);
> >  		list_del(&dpcm->list_fe);
> >  		kfree(dpcm);
> > +		spin_unlock(&fe->card->dpcm_lock);
> 
> The unlock might be moved before kfree(). Also, I don't see the
> list_add() spin lock protection in your patch.
> 
> 				Jaroslav
> 

The dpcm_lock in this patch is to protect the instance of dpcm,
e.g. protect dpcm not to be free while dereference from the
be_clients/fe_clients.

The lock is not meant to protect the list "be_clients" and "fe_client",
e.g. not meant to protect add/remove dpcm from these list.

The lock is added only at the places that may have race with
dpcm_be_disconnect(), e.g. kfree(dpcm). And note that, many places that
call for_each_dpcm_be/fe() cannot use spin_lock, since there are pcm
callbacks which can sleep.
