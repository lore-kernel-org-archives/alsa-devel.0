From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 1/4] ALSA: hda - codec add DP MST
 support for connection list
Date: Tue, 8 Mar 2016 06:47:51 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D190467FCAB@SHSMSX103.ccr.corp.intel.com>
References: <1457362666-53937-1-git-send-email-libin.yang@linux.intel.com>
 <1457362666-53937-2-git-send-email-libin.yang@linux.intel.com>
 <s5h8u1udyww.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 847262656EB
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 07:47:55 +0100 (CET)
In-Reply-To: <s5h8u1udyww.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, March 08, 2016 12:41 AM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong; Yang, Libin
> Subject: Re: [alsa-devel] [RFC PATCH 1/4] ALSA: hda - codec add DP MST
> support for connection list
> 
> On Mon, 07 Mar 2016 15:57:43 +0100,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > This patches adds the support of connection list for DP MST.
> > With this, hdmi driver in DP MST mode can easily reuse
> > the connection list mechanism.
> >
> > Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
> 
> I would just replace the function with *_mst() and provide the old
> ones via static inline wrappers instead of having two copies.

I see. I will change it.

Regards,
Libin

> 
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/hda_codec.c | 134
> ++++++++++++++++++++++++++++++++++++++++++----
> >  sound/pci/hda/hda_codec.h |   5 ++
> >  2 files changed, 128 insertions(+), 11 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 8374188..d4c81f7 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -110,23 +110,24 @@ struct hda_conn_list {
> >  	struct list_head list;
> >  	int len;
> >  	hda_nid_t nid;
> > +	int dev_id;
> >  	hda_nid_t conns[0];
> >  };
> >
> >  /* look up the cached results */
> >  static struct hda_conn_list *
> > -lookup_conn_list(struct hda_codec *codec, hda_nid_t nid)
> > +lookup_conn_list(struct hda_codec *codec, hda_nid_t nid, int dev_id)
> >  {
> >  	struct hda_conn_list *p;
> >  	list_for_each_entry(p, &codec->conn_list, list) {
> > -		if (p->nid == nid)
> > +		if ((p->nid == nid) && (p->dev_id == dev_id))
> >  			return p;
> >  	}
> >  	return NULL;
> >  }
> >
> > -static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int
> len,
> > -			 const hda_nid_t *list)
> > +static int add_conn_list(struct hda_codec *codec, hda_nid_t nid,
> > +			 int dev_id, int len, const hda_nid_t *list)
> >  {
> >  	struct hda_conn_list *p;
> >
> > @@ -135,6 +136,7 @@ static int add_conn_list(struct hda_codec
> *codec, hda_nid_t nid, int len,
> >  		return -ENOMEM;
> >  	p->len = len;
> >  	p->nid = nid;
> > +	p->dev_id = dev_id;
> >  	memcpy(p->conns, list, len * sizeof(hda_nid_t));
> >  	list_add(&p->list, &codec->conn_list);
> >  	return 0;
> > @@ -150,8 +152,13 @@ static void remove_conn_list(struct
> hda_codec *codec)
> >  	}
> >  }
> >
> > -/* read the connection and add to the cache */
> > -static int read_and_add_raw_conns(struct hda_codec *codec,
> hda_nid_t nid)
> > +/*
> > + * read the connection and add to the cache
> > + * the caller should select the device entry by sending the
> > + * corresponding verb if necessary before calling this function
> > + */
> > +static int read_and_add_raw_conns(struct hda_codec *codec,
> hda_nid_t nid,
> > +				  int dev_id)
> >  {
> >  	hda_nid_t list[32];
> >  	hda_nid_t *result = list;
> > @@ -166,7 +173,8 @@ static int read_and_add_raw_conns(struct
> hda_codec *codec, hda_nid_t nid)
> >  		len = snd_hda_get_raw_connections(codec, nid, result,
> len);
> >  	}
> >  	if (len >= 0)
> > -		len = snd_hda_override_conn_list(codec, nid, len, result);
> > +		len = snd_hda_override_conn_list_mst(codec, nid,
> > +					     dev_id, len, result);
> >  	if (result != list)
> >  		kfree(result);
> >  	return len;
> > @@ -197,7 +205,7 @@ int snd_hda_get_conn_list(struct hda_codec
> *codec, hda_nid_t nid,
> >  		const struct hda_conn_list *p;
> >
> >  		/* if the connection-list is already cached, read it */
> > -		p = lookup_conn_list(codec, nid);
> > +		p = lookup_conn_list(codec, nid, 0);
> >  		if (p) {
> >  			if (listp)
> >  				*listp = p->conns;
> > @@ -206,7 +214,7 @@ int snd_hda_get_conn_list(struct hda_codec
> *codec, hda_nid_t nid,
> >  		if (snd_BUG_ON(added))
> >  			return -EINVAL;
> >
> > -		err = read_and_add_raw_conns(codec, nid);
> > +		err = read_and_add_raw_conns(codec, nid, 0);
> >  		if (err < 0)
> >  			return err;
> >  		added = true;
> > @@ -215,6 +223,49 @@ int snd_hda_get_conn_list(struct hda_codec
> *codec, hda_nid_t nid,
> >  EXPORT_SYMBOL_GPL(snd_hda_get_conn_list);
> >
> >  /**
> > + * snd_hda_get_conn_list_mst - get connection list in mst mode
> > + * @codec: the HDA codec
> > + * @nid: NID to parse
> > + * @dev_id: device entry id
> > + * @listp: the pointer to store NID list
> > + *
> > + * Parses the connection list of the given widget and stores the pointer
> > + * to the list of NIDs.
> > + *
> > + * Returns the number of connections, or a negative error code.
> > + *
> > + * Note that the returned pointer isn't protected against the list
> > + * modification.  If snd_hda_override_conn_list() might be called
> > + * concurrently, protect with a mutex appropriately.
> > + */
> > +int snd_hda_get_conn_list_mst(struct hda_codec *codec, hda_nid_t
> nid,
> > +			      int dev_id, const hda_nid_t **listp)
> > +{
> > +	bool added = false;
> > +
> > +	for (;;) {
> > +		int err;
> > +		const struct hda_conn_list *p;
> > +
> > +		/* if the connection-list is already cached, read it */
> > +		p = lookup_conn_list(codec, nid, dev_id);
> > +		if (p) {
> > +			if (listp)
> > +				*listp = p->conns;
> > +			return p->len;
> > +		}
> > +		if (snd_BUG_ON(added))
> > +			return -EINVAL;
> > +
> > +		err = read_and_add_raw_conns(codec, nid, dev_id);
> > +		if (err < 0)
> > +			return err;
> > +		added = true;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(snd_hda_get_conn_list_mst);
> > +
> > +/**
> >   * snd_hda_get_connections - copy connection list
> >   * @codec: the HDA codec
> >   * @nid: NID to parse
> > @@ -246,6 +297,39 @@ int snd_hda_get_connections(struct
> hda_codec *codec, hda_nid_t nid,
> >  EXPORT_SYMBOL_GPL(snd_hda_get_connections);
> >
> >  /**
> > + * snd_hda_get_connections_mst - copy connection list in mst mode
> > + * @codec: the HDA codec
> > + * @nid: NID to parse
> > + * @dev_id: device entry id
> > + * @conn_list: connection list array; when NULL, checks only the size
> > + * @max_conns: max. number of connections to store
> > + *
> > + * Parses the connection list of the given widget and stores the list
> > + * of NIDs.
> > + *
> > + * Returns the number of connections, or a negative error code.
> > + */
> > +int snd_hda_get_connections_mst(struct hda_codec *codec,
> hda_nid_t nid,
> > +				int dev_id, hda_nid_t *conn_list,
> > +				int max_conns)
> > +{
> > +	const hda_nid_t *list;
> > +	int len = snd_hda_get_conn_list_mst(codec, nid, dev_id, &list);
> > +
> > +	if (len > 0 && conn_list) {
> > +		if (len > max_conns) {
> > +			codec_err(codec, "Too many connections %d for
> NID 0x%x\n",
> > +				   len, nid);
> > +			return -EINVAL;
> > +		}
> > +		memcpy(conn_list, list, len * sizeof(hda_nid_t));
> > +	}
> > +
> > +	return len;
> > +}
> > +EXPORT_SYMBOL_GPL(snd_hda_get_connections_mst);
> > +
> > +/**
> >   * snd_hda_override_conn_list - add/modify the connection-list to
> cache
> >   * @codec: the HDA codec
> >   * @nid: NID to parse
> > @@ -262,17 +346,45 @@ int snd_hda_override_conn_list(struct
> hda_codec *codec, hda_nid_t nid, int len,
> >  {
> >  	struct hda_conn_list *p;
> >
> > -	p = lookup_conn_list(codec, nid);
> > +	p = lookup_conn_list(codec, nid, 0);
> >  	if (p) {
> >  		list_del(&p->list);
> >  		kfree(p);
> >  	}
> >
> > -	return add_conn_list(codec, nid, len, list);
> > +	return add_conn_list(codec, nid, 0, len, list);
> >  }
> >  EXPORT_SYMBOL_GPL(snd_hda_override_conn_list);
> >
> >  /**
> > + * snd_hda_override_conn_list_mst - add/modify the connection-list
> to cache
> > + * @codec: the HDA codec
> > + * @nid: NID to parse
> > + * @dev_id: device entry id
> > + * @len: number of connection list entries
> > + * @list: the list of connection entries
> > + *
> > + * Add or modify the given connection-list to the cache.  If the
> corresponding
> > + * cache already exists, invalidate it and append a new one.
> > + *
> > + * Returns zero or a negative error code.
> > + */
> > +int snd_hda_override_conn_list_mst(struct hda_codec *codec,
> hda_nid_t nid,
> > +			   int dev_id, int len, const hda_nid_t *list)
> > +{
> > +	struct hda_conn_list *p;
> > +
> > +	p = lookup_conn_list(codec, nid, dev_id);
> > +	if (p) {
> > +		list_del(&p->list);
> > +		kfree(p);
> > +	}
> > +
> > +	return add_conn_list(codec, nid, dev_id, len, list);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_hda_override_conn_list_mst);
> > +
> > +/**
> >   * snd_hda_get_conn_index - get the connection index of the given NID
> >   * @codec: the HDA codec
> >   * @mux: NID containing the list
> > diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
> > index 373fcad..deeed35 100644
> > --- a/sound/pci/hda/hda_codec.h
> > +++ b/sound/pci/hda/hda_codec.h
> > @@ -330,6 +330,9 @@ snd_hda_codec_write(struct hda_codec
> *codec, hda_nid_t nid, int flags,
> >  	snd_hdac_get_sub_nodes(&(codec)->core, nid, start_nid)
> >  int snd_hda_get_connections(struct hda_codec *codec, hda_nid_t nid,
> >  			    hda_nid_t *conn_list, int max_conns);
> > +int snd_hda_get_connections_mst(struct hda_codec *codec,
> hda_nid_t nid,
> > +				int dev_id, hda_nid_t *conn_list,
> > +				int max_conns);
> >  static inline int
> >  snd_hda_get_num_conns(struct hda_codec *codec, hda_nid_t nid)
> >  {
> > @@ -345,6 +348,8 @@ int snd_hda_get_conn_list(struct hda_codec
> *codec, hda_nid_t nid,
> >  			  const hda_nid_t **listp);
> >  int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t
> nid, int nums,
> >  			  const hda_nid_t *list);
> > +int snd_hda_override_conn_list_mst(struct hda_codec *codec,
> hda_nid_t nid,
> > +			   int dev_id, int len, const hda_nid_t *list);
> >  int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
> >  			   hda_nid_t nid, int recursive);
> >  int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
> > --
> > 1.9.1
> >
